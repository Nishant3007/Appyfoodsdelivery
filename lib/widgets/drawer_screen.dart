import 'package:appyfooddelivery/config/const/assets.dart';
import 'package:appyfooddelivery/config/const/color_config.dart';
import 'package:appyfooddelivery/core/Home/view/home_screen.dart';
import 'package:appyfooddelivery/core/Login/view/login_screen.dart';
import 'package:appyfooddelivery/core/My%20Orders/view/my_order_screen.dart';
import 'package:appyfooddelivery/core/Profile/view/profile_screen.dart';
import 'package:appyfooddelivery/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/const/constant.dart';
import '../databse/MySharedPreferences.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 200,
              padding: EdgeInsets.only(left: 10),
              color: ColorConfig.redColor,
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(Assets.user), fit: BoxFit.fill)),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          SharedPreferencesRepository.getString(
                              AppConstants.DRIVER_NAME),
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.w),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 28.sp,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10.sp),
                            Expanded(
                              child: Text(
                                SharedPreferencesRepository.getString(
                                    AppConstants.DRIVER_PHONE),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
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
                              color: Colors.white,
                            ),
                            SizedBox(width: 10.sp),
                            Expanded(
                              child: Text(
                                "dummy@gmail.com",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
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
            ),
            listTile("Dashboard", () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => BottomNavigation(0,true)));
            }),
            Divider(),
            listTile("My Orders", () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => BottomNavigation(1,true)));
  }),
            Divider(),
            listTile("My Account", () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => BottomNavigation(2,true)));
            }),
            Divider(),
            listTile("Settings", () {}),
            Divider(),
            listTile("Logout", () {
              SharedPreferencesRepository.putBool(AppConstants.IS_LOGIN, false);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (route) => false);
            }),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget listTile(String text, ontap) {
    return ListTile(
      onTap: ontap,
      title: Text(text),
      trailing: Icon(Icons.arrow_right),
    );
  }
}
