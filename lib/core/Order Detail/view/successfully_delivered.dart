import 'package:appyfooddelivery/config/const/assets.dart';
import 'package:appyfooddelivery/config/const/color_config.dart';
import 'package:appyfooddelivery/widgets/bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessfullyDelieverd extends StatefulWidget {
  late final String? orderNo;
  late final String? deliveryDate;
  late final String? paymentType;
  late final String? totalAmount;

  SuccessfullyDelieverd(
      this.orderNo, this.deliveryDate, this.paymentType, this.totalAmount);

  @override
  _SuccessfullyDelieverdState createState() => _SuccessfullyDelieverdState();
}

class _SuccessfullyDelieverdState extends State<SuccessfullyDelieverd> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
/*    Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => BottomNavigation(1,false)),
          (route) => false);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.redColor,
      body: SafeArea(
        child: Container(
          child: Column(
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
                                bottom:
                                    BorderSide(color: ColorConfig.redColor))),
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
                          Image.asset(Assets.successfullGif),
                          SizedBox(height: 16.h),
                          Text(
                            "Successfully Delivered",
                            style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorConfig.redColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
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
                            border:
                                Border(top: BorderSide(color: Colors.white))),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                          color: ColorConfig.redColor,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(80))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80.sp,
                          ),
                          rowContainer("Order Number", widget.orderNo.toString()),
                          SizedBox(
                            height: 16.sp,
                          ),
                          rowContainer("Delivery Date", widget.deliveryDate.toString()),
                          SizedBox(
                            height: 16.sp,
                          ),
                          rowContainer("Payment Method", widget.paymentType.toString()),
                          SizedBox(
                            height: 16.sp,
                          ),
                          rowContainer("Cash Collected", "£${widget.totalAmount.toString()}"),
                          SizedBox(
                            height: 40.sp,
                          ),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Colors.white)))),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            BottomNavigation(1, false)),
                                    (route) => false);
                              },
                              child: Text(
                                "Continue",
                                style: TextStyle(color: ColorConfig.redColor),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget rowContainer(String text, String text2) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16.sp),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Text(
            ":",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.sp),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            text2,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16.sp),
          ),
        ),
      ],
    );
  }
}
