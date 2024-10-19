import 'package:appyfooddelivery/config/const/assets.dart';
import 'package:appyfooddelivery/config/const/color_config.dart';
import 'package:appyfooddelivery/model/reasonsresponse/UnsuccessfulReasonResponse.dart';
import 'package:appyfooddelivery/model/submitreason/SubmitReasonResponse.dart';
import 'package:appyfooddelivery/utils/utils.dart';
import 'package:appyfooddelivery/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/const/constant.dart';
import '../../../databse/MySharedPreferences.dart';
import '../../../network/dioclient/dio_client.dart';

class DeliveryUnsuccessful extends StatefulWidget {
  late final String restaurantId;
  late final String orderId;
  late final String? orderNo;

  DeliveryUnsuccessful(this.restaurantId, this.orderId, this.orderNo);

  @override
  _DeliveryUnsuccessfulState createState() => _DeliveryUnsuccessfulState();
}

class _DeliveryUnsuccessfulState extends State<DeliveryUnsuccessful> {
  int index1 = 0;
  late DioClient dioClient;
  bool isLoading = true;
  List<UnsuccessfulResonsResultData> _mDeliveryUnsuccessfulReason = [];
  bool mDataFetched = false;

  String mReasonId = "";
  String mMessage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dioClient = DioClient();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) getReasons();
    return Scaffold(
      backgroundColor: ColorConfig.redColor,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 100.h,
                            decoration: BoxDecoration(
                                color: ColorConfig.redColor,
                                border: Border(
                                    bottom: BorderSide(
                                        color: ColorConfig.redColor))),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(80))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 30.sp,
                              ),
                              Image.asset(
                                Assets.unsuccessfullGif,
                                height: 80,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                "Delivery Unsuccessful",
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConfig.redColor),
                              ),
                              Text(
                                "Order Number - #${widget.orderNo}",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 100.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    top: BorderSide(color: Colors.white))),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          decoration: BoxDecoration(
                              color: ColorConfig.redColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(80))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30.sp,
                              ),
                              Text(
                                "Choose one of the following reason",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(
                                height: 20.sp,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  physics: ClampingScrollPhysics(),
                                  itemCount:
                                      _mDeliveryUnsuccessfulReason.length,
                                  itemBuilder: (context, position) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          index1 = position;
                                          mReasonId =
                                              _mDeliveryUnsuccessfulReason[
                                                      position]
                                                  .id
                                                  .toString();
                                        });

                                        if (_mDeliveryUnsuccessfulReason[
                                                    position]
                                                .id ==
                                            5) {
                                          _modalBottomSheetMenu();
                                        }
                                      },
                                      child: Container(
                                        height: 50.h,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        decoration: BoxDecoration(
                                            color: position == index1
                                                ? Colors.white
                                                : Colors.transparent,
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Text(
                                            "${_mDeliveryUnsuccessfulReason[position].reasonName}",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: position == index1
                                                    ? ColorConfig.redColor
                                                    : Colors.white),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !isLoading,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.white)))),
                          onPressed: () {
                            submitReason();
                          },
                          child: Text(
                            "Continue",
                            style: TextStyle(color: ColorConfig.redColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.sp,
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

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 450.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Column(
              children: [
                SizedBox(
                  height: 20.sp,
                ),
                Text("Enter your reason",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18.sp)),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: new Container(
                    child: TextFormField(
                      maxLines: 10,
                      cursorColor: Colors.red.shade900,
                      style: TextStyle(color: Colors.red.shade900),
                      onChanged: (value) {
                        setState(() {
                          mMessage = value;
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        contentPadding: EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.red, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                SizedBox(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ColorConfig.redColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red)))),
                      onPressed: () {
                        submitReason();
                      },
                      child: Text("Submit")),
                )
              ],
            ),
          );
        });
  }

  getReasons() {
    dioClient.getUnsuccessfulReasons().then((value) async {
      UnsuccessfulReasonResponse unsuccessfulResponse =
          UnsuccessfulReasonResponse.fromJson(value);
      if (unsuccessfulResponse.resultData != null) {
        _mDeliveryUnsuccessfulReason.clear();
        _mDeliveryUnsuccessfulReason.addAll(unsuccessfulResponse.resultData!);
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  submitReason() {
    if (_mDeliveryUnsuccessfulReason[index1].id != 5)
      mMessage = _mDeliveryUnsuccessfulReason[index1].reasonName.toString();

    dioClient
        .submitReasonStatus(
            SharedPreferencesRepository.getString(AppConstants.DRIVER_ID),
            widget.orderId,
            widget.restaurantId,
            mReasonId,
            mMessage)
        .then((value) async {
      SubmitReasonResponse submitReasonResponse =
          SubmitReasonResponse.fromJson(value);
      if (submitReasonResponse.resultData != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => BottomNavigation(1, false)),
            (route) => false);
        MyUtils()
            .showToast(submitReasonResponse.resultData!.reasonName.toString());
      }
    });
  }
}
