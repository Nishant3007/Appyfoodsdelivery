import 'package:appyfooddelivery/config/const/assets.dart';
import 'package:appyfooddelivery/config/const/color_config.dart';
import 'package:appyfooddelivery/core/Login/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginAsScreen extends StatefulWidget {
  @override
  _LoginAsScreenState createState() => _LoginAsScreenState();
}

class _LoginAsScreenState extends State<LoginAsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConfig.redColor,
      body: SafeArea(
        child: Container(
          child: ListView(
            padding: EdgeInsets.only(left: 18, right: 18),
            children: [
              Image.asset(Assets.appyWhiteLogoBig,
                  scale: 2.h, fit: BoxFit.fill),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                "Ahoy!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text("Deliver Your Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  )),
              SizedBox(
                height: height * 0.01,
              ),
              Text("Seamlessly and Intuitively.",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 22.sp,
                  )),
              SizedBox(
                height: height * 0.07,
              ),
              Text(
                "Login As",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 8, 18, 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Resturant's Driver",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      )),
                      Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white)),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 26.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
