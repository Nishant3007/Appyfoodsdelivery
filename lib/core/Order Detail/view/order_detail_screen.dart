import 'package:appyfooddelivery/config/const/assets.dart';
import 'package:appyfooddelivery/config/const/color_config.dart';
import 'package:appyfooddelivery/config/const/constant.dart';
import 'package:appyfooddelivery/core/Order%20Detail/view/successfully_delivered.dart';
import 'package:appyfooddelivery/model/orderdetailsresponse/OrderDetailsResponse.dart';
import 'package:appyfooddelivery/utils/utils.dart';
import 'package:appyfooddelivery/widgets/sperate_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../databse/MySharedPreferences.dart';
import '../../../model/updateorderstatusresponse/UpdateOrderStatusResponse.dart';
import '../../../network/dioclient/dio_client.dart';
import '../../GoogleMap/view/google_map_screen.dart';
import 'delievery_unsuccessful.dart';

class OrderDetailScreen extends StatefulWidget {
  late final String mOrderId;
  late final String mFromPage;

  OrderDetailScreen(this.mOrderId, this.mFromPage);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late DioClient dioClient;
  bool isLoading = true;
  OrderDetailsResultData _mOrderDetailsResultData = OrderDetailsResultData();
  List<Listofitems> mListOfItems = [];
  var mOrderStatus = 0;
  Location mLocation = new Location();
  bool _mServiceEnabled = false;
  bool mOrderStarted = false;
  late LatLng mStartLatLang;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dioClient = DioClient();
  }

  @override
  Widget build(BuildContext context) {
    getLocationUpdates();
    if (isLoading) getOrderDetailsApi();
    MyUtils().logger.wtf(widget.mFromPage.toString());

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Number #${_mOrderDetailsResultData.orderId == null ? "#" : _mOrderDetailsResultData.orderId}",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: ColorConfig.redColor,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: !isLoading ? buttonSelected() : null,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : Container(
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: topPart(),
                          ),
                          MySeparator(color: Colors.black),
                          pickUpInformation(),
                          MySeparator(color: Colors.black),
                          deliveryInformation(),
                          MySeparator(color: Colors.black),
                          SizedBox(height: height * 0.01),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  "Items",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              listOfItemsContainer(),
                            ],
                          ),
                          noteContainer(),
                          MySeparator(color: Colors.grey),
                          SizedBox(height: height * 0.03),
                          totalBillRow("Subtotal",
                              _mOrderDetailsResultData.subtotal.toString()),
                          totalBillRow("Service Charge",
                              _mOrderDetailsResultData.serviceTax.toString()),
                          totalBillRow("Discount",
                              _mOrderDetailsResultData.discount.toString()),
                          totalBillRow("Total",
                              _mOrderDetailsResultData.totalamount.toString()),
                          SizedBox(height: height * 0.02),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget noteContainer() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Note",
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Row(
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: Colors.yellow.shade700,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    "Do not ring the bell",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: ColorConfig.redColor,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget topPart() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Visibility(
                visible: false,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          image: AssetImage(Assets.user), fit: BoxFit.fill)),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _mOrderDetailsResultData.cFirstName.toString() +
                          " " +
                          (_mOrderDetailsResultData.cLastName.toString() != ""
                              ? _mOrderDetailsResultData.cLastName
                                  .toString()
                                  .substring(0, 2)
                              : ""),
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: ColorConfig.redColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.w),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 28.sp,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10.sp),
                        Expanded(
                          child: Text(
                            _mOrderDetailsResultData.customerMobile.toString(),
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: false,
                      child: Row(
                        children: [
                          Icon(
                            Icons.mail_outline_outlined,
                            size: 28.sp,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10.sp),
                          Expanded(
                            child: Text(
                              "sarah.joseph@gmail.com",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget pickUpInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " " + "Pickup Information",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        " " +
                            _mOrderDetailsResultData.restaurantName.toString(),
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _makePhoneCall('tel:' +
                            _mOrderDetailsResultData.restaurantPhoneno
                                .toString());
                      },
                      child: SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: Image.asset(Assets.phoneIcon,
                              color: ColorConfig.redColor)),
                    ),
                    SizedBox(width: 10.w),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      GoogleMapScreen(mStartLatLang)));
                        },
                        child: Icon(
                          Icons.directions,
                          color: ColorConfig.redColor,
                          size: 30.sp,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  " " +
                      _mOrderDetailsResultData.restaurantAddress
                          .toString()
                          .split(",")
                          .join("," + "\n"),
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  " " + _mOrderDetailsResultData.restaurantPhoneno.toString(),
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget deliveryInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Delivery Information",
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _makePhoneCall('tel:' +
                        _mOrderDetailsResultData.customerMobile.toString());
                  },
                  child: SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: Image.asset(Assets.phoneIcon,
                          color: ColorConfig.redColor)),
                ),
                SizedBox(width: 10.w),
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.directions,
                      color: ColorConfig.redColor,
                      size: 30.sp,
                    )),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Address : ${_mOrderDetailsResultData.customerAddress.toString()}",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Phone Number : ${_mOrderDetailsResultData.customerMobile.toString()}",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Order Date and Time : ${_mOrderDetailsResultData.orderdate.toString()}",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            widget.mFromPage == AppConstants.FROM_DELIVERED
                ? Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Estimated Delivery Time : ${_mOrderDetailsResultData.estimatedTime.toString() + " Min"}",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Payment Mode : ${_mOrderDetailsResultData.paymentTypeName.toString()}",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget listOfItemsContainer() {
    return ListView.builder(
      itemCount: mListOfItems.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var listOfItems = mListOfItems[index];
        return billingDetail(listOfItems);
      },
    );
  }

  Widget billingDetail(Listofitems listOfItems) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    listOfItems.itemName.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "£ ${listOfItems.itemPrice.toString()}",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16.sp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2),
            Text(
              "Quantity x ${listOfItems.quanitity.toString()}",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            /* Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              width: width,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)
              ),
              child: Text("Do not ring the bell",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                  decoration: TextDecoration.underline
                ),

              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget totalBillRow(String text, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        margin: EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "£ $price",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonSelected() {
    if (widget.mFromPage == AppConstants.FROM_PROCESSING) mOrderStarted = true;
    return Container(
      alignment: Alignment.center,
      height: mOrderStarted ? 95 : 80,
      child: Column(
        children: [
          if (widget.mFromPage != AppConstants.FROM_DELIVERED)
            Visibility(
              visible: mOrderStarted,
              child: Expanded(
                child: InkWell(
                  onTap: () {
                    /*        final snackBar = SnackBar(
                      content: Text(
                        "Navigate to map",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                      backgroundColor: ColorConfig.redColor);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
                    //   openMaps();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => GoogleMapScreen(mStartLatLang)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: ColorConfig.redColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ColorConfig.redColor)),
                    child: Center(
                      child: Text(
                        "Navigate",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (widget.mFromPage != AppConstants.FROM_DELIVERED)
            SizedBox(
              height: 10,
            ),
          if (widget.mFromPage != AppConstants.FROM_DELIVERED)
            Row(children: [
              Visibility(
                visible: !mOrderStarted,
                child: Expanded(
                  child: InkWell(
                    onTap: () {
                      final snackBar = SnackBar(
                          content: Text(
                            "Job has been started..",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                          backgroundColor: ColorConfig.redColor);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      MyUtils().buildLoading(context);
                      updateOrderStatus(OrderUpdateStatusCode.startOrder);

                      setState(() {
                        mOrderStarted = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: ColorConfig.redColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ColorConfig.redColor)),
                      child: Center(
                        child: Text(
                          "Start",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: mOrderStarted,
                child: Expanded(
                  child: InkWell(
                    onTap: () {
                      MyUtils().buildLoading(context);
                      updateOrderStatus(OrderUpdateStatusCode.delivered);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ColorConfig.redColor)),
                      child: Center(
                        child: Text(
                          "Delivered",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: ColorConfig.redColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: mOrderStarted,
                child: SizedBox(
                  width: 10,
                ),
              ),
              Visibility(
                visible: mOrderStarted,
                child: Expanded(
                  child: InkWell(
                    onTap: () {
                      //    Navigator.push(context, MaterialPageRoute(builder: (_)=>DeliveryUnsuccessful()));
                      MyUtils().buildLoading(context);
                      updateOrderStatus(OrderUpdateStatusCode.notDelivered);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ColorConfig.redColor)),
                      child: Center(
                        child: Text(
                          "Not Delivered",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: ColorConfig.redColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          if (widget.mFromPage == AppConstants.FROM_DELIVERED)
            Container(
              height: 50,
              child: Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        final snackBar = SnackBar(
                            content: Text(
                              "Order already delivered!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.sp),
                            ),
                            backgroundColor: ColorConfig.redColor);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: ColorConfig.redColor)),
                        child: Center(
                          child: Text(
                            "Successfully Delivered",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: ColorConfig.redColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

/*  openMaps() async {
    MapLauncher.showDirections(
      mapType: MapType.google,
      destination: Coords(30.3248635, 78.03924),
      origin: Coords(30.3081307, 78.0049969),
    );
  }*/

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getOrderDetailsApi() {
    dioClient
        .getOrderDetails(
            SharedPreferencesRepository.getString(AppConstants.DRIVER_ID),
            widget.mOrderId)
        .then((value) async {
      OrderDetailsResponse orderDetails = OrderDetailsResponse.fromJson(value);
      if (orderDetails.resultData != null) {
        _mOrderDetailsResultData = orderDetails.resultData!;
        mListOfItems.addAll(_mOrderDetailsResultData.listofitems!);
        setState(() {
          isLoading = false;
        });
      }else
        Navigator.pop(context);
    });
  }

  updateOrderStatus(String orderStatusCode) {

    MyUtils().showToast(widget.mOrderId);
    dioClient
        .updateOrderStatus(orderStatusCode, widget.mOrderId)
        .then((value) async {
      UpdateOrderStatusResponse updateOrderResponse =
          UpdateOrderStatusResponse.fromJson(value);
      if (updateOrderResponse.resultData != null &&
          updateOrderResponse.status == true) {
        Navigator.pop(context);
        switch (orderStatusCode) {
          case OrderUpdateStatusCode.startOrder:
            /*         Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => BottomNavigation(1, false)),
                    (route) => false);*/
            //  getLocationUpdates();
            break;
          case OrderUpdateStatusCode.delivered:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SuccessfullyDelieverd(
                        _mOrderDetailsResultData.orderId.toString(),
                        _mOrderDetailsResultData.deliverydate.toString(),
                        _mOrderDetailsResultData.paymentTypeName.toString(),
                        _mOrderDetailsResultData.totalamount.toString())));
            break;
          case OrderUpdateStatusCode.notDelivered:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => DeliveryUnsuccessful(
                        _mOrderDetailsResultData.restaurantId.toString(),
                        _mOrderDetailsResultData.orderId.toString(),
                        _mOrderDetailsResultData.orderno.toString())));
            break;
        }
      }else
        Navigator.pop(context);
    });
  }

  getLocationUpdates() async {
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _mServiceEnabled = await mLocation.serviceEnabled();
    if (!_mServiceEnabled) {
      _mServiceEnabled = await mLocation.requestService();
      if (!_mServiceEnabled) {
        return;
      }
    }

    _permissionGranted = await mLocation.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await mLocation.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    mLocation.enableBackgroundMode(enable: true);

    _locationData = await mLocation.getLocation();
    mStartLatLang = LatLng(_locationData.latitude!, _locationData.longitude!);
  }
}
