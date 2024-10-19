import 'package:appyfooddelivery/config/const/assets.dart';
import 'package:appyfooddelivery/config/const/color_config.dart';
import 'package:appyfooddelivery/widgets/sperate_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/const/constant.dart';
import '../../../databse/MySharedPreferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: [
            SizedBox(height: height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: topPart(),
            ),
            SizedBox(height: height * 0.01),
            MySeparator(color: Colors.grey),
            pickUpInformation(),
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
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                    //shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                        image: AssetImage(Assets.ic_user), fit: BoxFit.fill)),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      SharedPreferencesRepository.getString(
                          AppConstants.DRIVER_NAME),
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
                            SharedPreferencesRepository.getString(
                                AppConstants.DRIVER_PHONE),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.mail_outline_outlined,
                          size: 28.sp,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10.sp),
                        Expanded(
                          child: Text(
                            SharedPreferencesRepository.getString(
                                AppConstants.DRIVER_EMAIL),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
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
              "Your Restaurant",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Restaurant : ${SharedPreferencesRepository.getString(
                  AppConstants.DRIVER_RESTAURANT_NAME)}",
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Address : ${SharedPreferencesRepository.getString(
                  AppConstants.DRIVER_RESTAURANT_ADDRESS)}",
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Phone Number : ${SharedPreferencesRepository.getString(
                  AppConstants.DRIVER_RESTAURANT_PHONE)}",
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
