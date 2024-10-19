import 'dart:async';

import 'package:appyfooddelivery/config/const/assets.dart';
import 'package:appyfooddelivery/config/const/color_config.dart';
import 'package:appyfooddelivery/core/Home/view/home_screen.dart';
import 'package:appyfooddelivery/core/My%20Orders/view/my_order_screen.dart';
import 'package:appyfooddelivery/core/Profile/view/profile_screen.dart';
import 'package:appyfooddelivery/model/checkdriveravailabilityresponse/checkDriverAvailabilityResponse.dart';
import 'package:appyfooddelivery/model/senddriverletlangresponse/SendDriverLetLangResponse.dart';
import 'package:appyfooddelivery/utils/utils.dart';
import 'package:appyfooddelivery/widgets/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../config/const/constant.dart';
import '../databse/MySharedPreferences.dart';
import '../network/dioclient/dio_client.dart';

class BottomNavigation extends StatefulWidget {
  late final int selectedTab;
  bool fromAnotherScreen;

  BottomNavigation(this.selectedTab, this.fromAnotherScreen);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int initialPageIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  GlobalKey<ScaffoldState> drawerKey = new GlobalKey<ScaffoldState>();
  int drawerIndex = 0;
  String mDriverId = "";
  bool isLoading = true;
  late DioClient dioClient;
  Location mLocation = new Location();
  bool _mServiceEnabled = false;
  bool isDriverAvailable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dioClient = DioClient();
  }

  void _onItemTapped(int index) {
    setState(() {
      initialPageIndex = index;
      print(initialPageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    checkDriverAvailability();

    if (widget.fromAnotherScreen == true)
      setState(() {
        initialPageIndex = widget.selectedTab;
        widget.fromAnotherScreen = false;
      });

    return Scaffold(
        key: drawerKey,
        appBar: initialPageIndex == 1
            ? AppBar(
                title: Text("My Orders"),
                backgroundColor: ColorConfig.redColor,
                elevation: 0,
                centerTitle: true,
              )
            : AppBar(
                iconTheme: IconThemeData(color: ColorConfig.redColor),
                toolbarHeight: 80,
                title: Image.asset(
                  Assets.appyFoodLogoRed,
                  scale: 6.5,
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                leading: Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                      icon: Icon(
                        Icons.menu_rounded,
                        color: ColorConfig.redColor,
                      ),
                      onPressed: () {
                        drawerKey.currentState?.openDrawer();
                      },
                    )),
              ),
        drawer: Padding(
          padding: const EdgeInsets.only(bottom: 62.0),
          child: Drawer(
            child: DrawerScreen(),
          ),
        ),
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.black.withOpacity(0.2),
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.red,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.black))),
          child: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            backgroundColor: ColorConfig.redColor,
            key: _bottomNavigationKey,
            currentIndex: initialPageIndex,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history_sharp,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: "Recent Orders"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    Assets.profileIcon,
                    height: 30,
                    width: 30,
                  ),
                  label: "Profile"),
            ],
            type: BottomNavigationBarType.fixed,
            elevation: 20,
          ),
        ),
        body: IndexedStack(
          index: initialPageIndex,
          children: [
            HomeScreen(),
            MyOrdersScreen(),
            ProfileScreen(),
          ],
        ));
  }

  checkDriverAvailability() {
    mDriverId = SharedPreferencesRepository.getString(AppConstants.DRIVER_ID);
    dioClient.checkDriverAvailability(mDriverId).then((value) async {
      CheckDriverAvailabilityResponse recentOrders =
          CheckDriverAvailabilityResponse.fromJson(value);
      if (recentOrders.resultData != null) {
        if (recentOrders.resultData?.isdriverAvailability == true) {
          isDriverAvailable = true;
      //    getLocationUpdates();
        }
      }
    });
  }

  hitSendDriverLocation(LocationData locationData) {
    mDriverId = SharedPreferencesRepository.getString(AppConstants.DRIVER_ID);
    dioClient
        .sendDriverLetLang(mDriverId, locationData.latitude.toString(),
            locationData.longitude.toString())
        .then((value) async {
      SendDriverLetLangResponse recentOrders =
          SendDriverLetLangResponse.fromJson(value);
      if (recentOrders.resultData != null) {
      }
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

    // runs every 1 second
    Timer.periodic(new Duration(seconds: 3), (timer)async {
      _locationData = await mLocation.getLocation();
      hitSendDriverLocation(_locationData);
    });

  }
}
