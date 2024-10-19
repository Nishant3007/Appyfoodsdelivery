import 'dart:async';

import 'package:appyfooddelivery/config/const/assets.dart';
import 'package:appyfooddelivery/core/Login/view/login_as_screen.dart';
import 'package:appyfooddelivery/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/const/constant.dart';
import '../../../databse/MySharedPreferences.dart';
import '../../../widgets/bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Required for async calls in `main`
    MyUtils()
        .logger
        .i(SharedPreferencesRepository.getBool(AppConstants.IS_LOGIN));
    Timer(Duration(seconds: 6), () {
      if (!SharedPreferencesRepository.getBool(AppConstants.IS_LOGIN))
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginAsScreen()));
      else
        Navigator.pushReplacement(

            context, MaterialPageRoute(builder: (_) => BottomNavigation(1,false)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.splashBackGroundRed),
                    fit: BoxFit.fill)),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 100,
            child: Center(
              child: Image.asset(
                Assets.appyWhiteLogoBig,
                fit: BoxFit.fill,
                scale: 5.h,
              ),
            ),
          ),
          Positioned(
            right: 40,
            bottom: -5,
            child: Center(
              child: RotatedBox(
                  quarterTurns: 4,
                  child: Image.asset(
                    Assets.bike,
                    fit: BoxFit.fill,
                  )),
            ),
          ),
        ],
      )),
    );
  }
}
