import 'package:appyfooddelivery/config/const/assets.dart';
import 'package:appyfooddelivery/config/const/color_config.dart';
import 'package:appyfooddelivery/core/Order%20Detail/view/order_detail_screen.dart';
import 'package:appyfooddelivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/const/constant.dart';
import '../../../databse/MySharedPreferences.dart';
import '../../../model/recentorderresponse/RecentOrdersResponse.dart';
import '../../../network/dioclient/dio_client.dart';

class MyOrdersScreen extends StatefulWidget {
  static String routeName = '/first';

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  static const String knew = "New";
  static const String kprocessing = "Processing";
  static const String kdelivered = "Delivered";
  static String selectedOrder = "New";
  late DioClient dioClient;
  int noOrders = -1;
  bool isLoading = true;
  bool isButtonClicked = true;
  List<RecentOrdersResultData> mRecentOrdersList = [];
  bool isDeliveredSelected = false;
  bool isProcessingSelected = false;
  bool isNewSelected = false;
  String mDriverId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dioClient = DioClient();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true)
      if(selectedOrder==knew)
      getNewOrders();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          menuTabContainer("New", knew),
                          menuTabContainer("Processing", kprocessing),
                          menuTabContainer("Delivered", kdelivered),
                        ],
                      ),
                    ),
                  ),
                  /*      Visibility(visible: false, child: calendarView()),*/
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        /*     if(mRecentOrdersList.isEmpty)
                        Text("Currently there is No Orders!"),*/
                        recentOrderList(),
                        Visibility(
                          visible: !isLoading,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Currently No $selectedOrder Available",
                              style: TextStyle(
                                  color: ColorConfig.redColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(child: isLoading ? CircularProgressIndicator() : null)
          ],
        ),
      ),
    );
  }

  Widget calendarView() {
    isDeliveredSelected = false;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: 280,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          shadowColor: Colors.grey,
          elevation: 4,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('From: '),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: Colors.black)),
                        child: Text('01-02-2022'),
                      ),
                      SizedBox(child: Image.asset(Assets.ic_calendar)),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('To: '),
                      SizedBox(
                        width: 28,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: Colors.black)),
                        child: Text('01-03-2022'),
                      ),
                      SizedBox(child: Image.asset(Assets.ic_calendar)),
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 25,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorConfig.redColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ))),
                          onPressed: () {},
                          child: Text("Submit")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuTabContainer(String tabName, String selectedTab) {
    return Container(
        child: Expanded(
      child: InkWell(
        onTap: () {
          mRecentOrdersList.clear();
          setState(() {
            isLoading = true;
            switch (selectedTab) {
              case knew:
                {
                  selectedOrder = knew;
                  getNewOrders();
                }
                break;
              case kprocessing:
                {
                  selectedOrder = kprocessing;
                  getProcessingOrders();
                }
                break;
              case kdelivered:
                {
                  selectedOrder = kdelivered;
                  getRecentOrdersApi();
                }
                break;
            }
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              color: selectedOrder == selectedTab
                  ? ColorConfig.redColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              tabName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedOrder == selectedTab
                    ? Colors.white
                    : ColorConfig.redColor,
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget recentOrdersContainer(RecentOrdersResultData orderList) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(bottom: height * 0.04),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, offset: Offset(6, 6))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                "Orders #${orderList.orderId.toString()}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              )),
              Expanded(
                  child: Text(
                orderList.orderdate.toString(),
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              )),
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderList.name.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        orderList.address.toString(),
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  )),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.call,
                          size: 32.sp,
                          color: Colors.black,
                        ),
                      ))),
            ],
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "£ ${orderList.totalamount.toString()}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                          TextSpan(text: "\t\t"),
                          TextSpan(
                            text: orderList.paymentTypeName.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: ColorConfig.redColor),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "Total Items: ${orderList.totalitem.toString()}",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  )),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.location_on_outlined,
                          size: 32.sp,
                          color: Colors.black,
                        ),
                      ))),
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Text(
            orderList.deliveryNote.toString(),
            style: TextStyle(color: Colors.grey, fontSize: 16.sp),
          ),
          SizedBox(
            height: height * 0.01,
          ),
        ],
      ),
    );
  }

  Widget recentOrderList() {
    return ListView.builder(
      itemCount: mRecentOrdersList.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var orderList = mRecentOrdersList[index];
        return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => OrderDetailScreen(
                          mRecentOrdersList[index].orderId.toString(),
                          isNewSelected
                              ? AppConstants.FROM_NEW
                              : isProcessingSelected
                                  ? AppConstants.FROM_PROCESSING
                                  : isDeliveredSelected
                                      ? AppConstants.FROM_DELIVERED
                                      : AppConstants.FROM_NEW)));
            },
            child: recentOrdersContainer(orderList));
      },
    );
  }

  getNewOrders() {
    mDriverId = SharedPreferencesRepository.getString(AppConstants.DRIVER_ID);
    dioClient.getNewOrders(mDriverId).then((value) async {
      RecentOrdersResponse recentOrders = RecentOrdersResponse.fromJson(value);

      if(recentOrders.status==true)
        mRecentOrdersList.clear();

      if (recentOrders.resultData?.length != 0 &&
          recentOrders.resultData != null) {
        setState(() {
          isNewSelected = true;
          isDeliveredSelected = false;
          isProcessingSelected = false;
          mRecentOrdersList.addAll(recentOrders.resultData!);
          isLoading = false;
        });
      } else {

        MyUtils().logger.wtf("IS_LOADING: " +
            isLoading.toString() +
            " LIST_SIZE: " +
            recentOrders.resultData!.length.toString());

        setState(() {
          isNewSelected = true;
          isDeliveredSelected = false;
          isProcessingSelected = false;
          isLoading = false;
        });
      }
    });
  }

  getProcessingOrders() {
    mDriverId = SharedPreferencesRepository.getString(AppConstants.DRIVER_ID);
    dioClient.getProcessingOrders(mDriverId, "1").then((value) async {
      RecentOrdersResponse recentOrders = RecentOrdersResponse.fromJson(value);

      if(recentOrders.status==true)
        mRecentOrdersList.clear();

      if (recentOrders.resultData?.length != 0 &&
          recentOrders.resultData != null) {
        setState(() {
          isProcessingSelected = true;
          isDeliveredSelected = false;
          isNewSelected = false;
          mRecentOrdersList.addAll(recentOrders.resultData!);
          isLoading = false;
        });
      } else {
        setState(() {
          isProcessingSelected = true;
          isDeliveredSelected = false;
          isNewSelected = false;
          isLoading = false;
        });
      }
    });
  }

  getRecentOrdersApi() {
    mDriverId = SharedPreferencesRepository.getString(AppConstants.DRIVER_ID);
    dioClient.getRecentOrders(mDriverId, "1", "", "").then((value) async {
      RecentOrdersResponse recentOrders = RecentOrdersResponse.fromJson(value);

      if(recentOrders.status==true)
        mRecentOrdersList.clear();

      if (recentOrders.resultData?.length != 0 &&
          recentOrders.resultData != null) {
        setState(() {
          isDeliveredSelected = true;
          isNewSelected = false;
          isProcessingSelected = false;
          mRecentOrdersList.addAll(recentOrders.resultData!);
          isLoading = false;
        });
      } else {
        setState(() {
          isDeliveredSelected = true;
          isNewSelected = false;
          isProcessingSelected = false;
          isLoading = false;
        });
      }
    });
  }
}
