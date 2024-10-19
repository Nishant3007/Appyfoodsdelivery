import 'dart:async';

import 'package:appyfooddelivery/config/const/color_config.dart';
import 'package:appyfooddelivery/config/const/constant.dart';
import 'package:appyfooddelivery/core/Login/model/choose_restaurant_list.dart';
import 'package:appyfooddelivery/databse/MySharedPreferences.dart';
import 'package:appyfooddelivery/model/restaurantresponse/RestaurantResponse.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../model/loginresponse/LoginResponse.dart';
import '../../../network/dioclient/dio_client.dart';
import '../../../utils/utils.dart';
import '../../../widgets/bottom_navigation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<DropdownMenuItem<String>> _chooseRestaurantList =
      ChooseRestaurantList.chooseRestaurantList
          .map(
            (String value) =>
                DropdownMenuItem<String>(value: value, child: Text(value)),
          )
          .toList();

  bool isLoading = false;
  bool isLoggedIn = false;
  String mEmailOrPhone = "";
  String mPassword = "";
  String mRestaurantId = "";
  String mPosition = "";
  late List<RestaurantListData> mRestaurantList = [];
  late LoginResultData mLoginResponse = LoginResultData();
  late List<String> mRestaurantNames = [""];
  late DioClient dioClient;
  var _suggestionControler = new TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> _textFieldAutoCompleteKey =
      new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dioClient = DioClient();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: ColorConfig.redColor,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                )),
          ),
          backgroundColor: ColorConfig.redColor,
          elevation: 0.0,
        ),
        body: Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Text(
                  "Login as",
                  style: TextStyle(
                      fontSize: 26.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  "Restaurant's Driver",
                  style: TextStyle(
                      fontSize: 26.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Text(
                  "Choose Restaurant",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                restaurantDropDown(),
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  "E.mail/Phone Number",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  //height: 60.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: TextFormField(
                    cursorColor: Colors.red.shade900,
                    style: TextStyle(color: Colors.red.shade900),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (value) {
                      mEmailOrPhone = value;
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  "Password",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  //height: 60.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: TextFormField(
                    cursorColor: Colors.red.shade900,
                    style: TextStyle(color: Colors.red.shade900),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (value) {
                      mPassword = value;
                    },
                  ),
                ),
/*            SizedBox(height: height*0.06,),
            Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (_)=>Bottom_Navigation()), (route) => false);
                    },
                    child: Image.asset(Assets.loginButton))),*/

                SizedBox(
                  height: height * 0.06,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        MyUtils().buildLoading(context);
                       // hitLogin();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => BottomNavigation(1, false)),
                                (route) => false);
                      },
                      child: Container(
                        height: 64.h,
                        width: width / 2.5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40)),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: ColorConfig.redColor,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 42.h,
                                width: 42.w,
                                decoration: BoxDecoration(
                                  color: ColorConfig.redColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: height * 0.03,
                ),
              ],
            ),
            Stack(),
          ],
        ));
  }

  Widget restaurantDropDown() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
      child: AutoCompleteTextField(
        controller: _suggestionControler,
        suggestions: mRestaurantNames,
        clearOnSubmit: false,
        style: TextStyle(color: Colors.black, fontSize: 16.0),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        itemFilter: (item, query) {
          if (query.length >= 2) {
            Timer(Duration(seconds: 1), () {
              getRestaurantList(query);
              MyUtils().logger.wtf("QUERY: " + query.length.toString());
            });
          }
          return item.toString().toLowerCase().startsWith(query.toLowerCase());
        },
        itemSorter: (a, b) {
          return a.toString().compareTo(b.toString());
        },
        itemSubmitted: (item) {
          _suggestionControler.text = item.toString();
          int mSelectedIndex = mRestaurantNames.indexOf(item.toString());
          mRestaurantId =
              mRestaurantList[mSelectedIndex].restaurantId.toString();

          /*  for (final i in mRestaurantList){
                          if(i.restaurantName==selectedRes)
                            mRestaurantId=i.restaurantId.toString();

                        }

                        logger.i("RESTAURANT_NAME: " +
                            isSelectedRestaurant! +
                            "\n" +
                            "RESTAURANT_ID: " +
                            mRestaurantId);*/

          MyUtils().logger.i("RESTAURANT_NAME: " +
              item.toString() +
              "\n" +
              "RESTAURANT_ID: " +
              mRestaurantId);
        },
        itemBuilder: (context, item) {
          return Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  item.toString(),
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          );
        },
        key: _textFieldAutoCompleteKey,
      ),
    );
  }

  Widget restaurantListView() {
    return ListView.builder(
        itemBuilder: (context, position) {
          return InkWell(
            child: Container(
              height: 100,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(mRestaurantList[position].restaurantName.toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
            onTap: () => {
              Fluttertoast.showToast(msg: position.toString()),
            },
          );
        },
        itemCount: mRestaurantNames.length);
  }

  hitLogin() {
    dioClient
        .loginUser(mEmailOrPhone, mPassword, mRestaurantId)
        .then((value) async {
      LoginResponse loginResponse = LoginResponse.fromJson(value);
      if (loginResponse.status == false) {
        Fluttertoast.showToast(
            msg: loginResponse.message.toString(),
            toastLength: Toast.LENGTH_SHORT);
        Navigator.of(context).pop();
      } else {
        mLoginResponse = loginResponse.resultData!;
        saveDriverData(mLoginResponse);
        Fluttertoast.showToast(
            msg: loginResponse.message.toString(),
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          isLoggedIn = true;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => BottomNavigation(1, false)),
              (route) => false);
        });
      }
    });
  }

  getRestaurantList(String resText) {
    dioClient.getRestaurantList(resText).then((value) async {
      RestaurantResponse restaurantResponse =
          RestaurantResponse.fromJson(value);
      if (restaurantResponse.resultData != null) {
        mRestaurantNames.clear();
        mRestaurantList = restaurantResponse.resultData!;
        for (final i in mRestaurantList) {
          mRestaurantNames.add(i.restaurantName.toString());
        }
        setState(() {
          isLoading = true;
        });
/*          Fluttertoast.showToast(
            msg: mRestaurantList[1].restaurantName.toString(),
            toastLength: Toast.LENGTH_SHORT);*/
      }
    });
  }
}

void saveDriverData(LoginResultData mLoginResponse) {
  SharedPreferencesRepository.putString(
      AppConstants.DRIVER_ID, mLoginResponse.driverId.toString());
  SharedPreferencesRepository.putString(
      AppConstants.DRIVER_NAME, mLoginResponse.name.toString());
  SharedPreferencesRepository.putString(
      AppConstants.DRIVER_PHONE, mLoginResponse.mobile.toString());
  SharedPreferencesRepository.putString(AppConstants.DRIVER_EMAIL, "");
  SharedPreferencesRepository.putString(
      AppConstants.DRIVER_ADDRESS, mLoginResponse.address.toString());
  SharedPreferencesRepository.putString(AppConstants.DRIVER_RESTAURANT_NAME,
      mLoginResponse.restaurantName.toString());
  SharedPreferencesRepository.putString(
      AppConstants.DRIVER_RESTAURANT_PHONE, "");
  SharedPreferencesRepository.putString(
      AppConstants.DRIVER_RESTAURANT_ADDRESS, "");
  SharedPreferencesRepository.putBool(AppConstants.IS_LOGIN, true);
}
