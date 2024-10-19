import 'package:appyfooddelivery/config/const/color_config.dart';
import 'package:appyfooddelivery/config/const/constant.dart';
import 'package:appyfooddelivery/core/Order%20Detail/view/order_detail_screen.dart';
import 'package:appyfooddelivery/databse/MySharedPreferences.dart';
import 'package:appyfooddelivery/model/dashboardresponse/DashboardResponse.dart';
import 'package:appyfooddelivery/model/recentorderresponse/RecentOrdersResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../network/dioclient/dio_client.dart';
import '../../../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOffline = false;
  late DioClient dioClient;
  DashboardResultData mDashboardResultData = DashboardResultData();
  List<RecentOrdersResultData> mRecentOrdersList = [];
  String mDriverId = "";
  bool isLoading = true;
  String mTodayDate = "";
  late int mRecentItemPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dioClient = DioClient();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      getDashboardDataApi();
      getTodayDate();
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(children: [
          Container(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(
                          SharedPreferencesRepository.getString(
                              AppConstants.DRIVER_NAME),
                          style: TextStyle(
                              color: ColorConfig.redColor,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      SizedBox(
                        height:height * 0.02,
                      ),
                      Text("Total orders assigned to you till now : ${mDashboardResultData.totalOrder.toString()}",
                        style: TextStyle(
                            color: ColorConfig.redColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Visibility(
                        child: Switch(
                            activeColor: ColorConfig.redColor,
                            value: isOffline,
                            onChanged: (value) {
                              setState(() {
                                isOffline = value;
                              });
                            }),
                        visible: false,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                gridList(),
                SizedBox(
                  height: height * 0.04,
                ),
                Text(
                  "Recent Orders",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorConfig.redColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                if (mRecentOrdersList.isNotEmpty) recentOrderList(),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ),
          ),
          Center(child: isLoading ? CircularProgressIndicator() : null),
        ]),
      ),
    );
  }

  Widget gridList() {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //childAspectRatio: 1.5,
            crossAxisCount: 2,
            crossAxisSpacing: 30,
            mainAxisSpacing: 20,
            mainAxisExtent: 110),
        children: [
          gridContainer(
              "Total Delivered",
              mDashboardResultData.totalDelivered == null
                  ? "0"
                  : mDashboardResultData.totalDelivered.toString()),
          gridContainer(
              "Not Delivered",
              mDashboardResultData.notDelivery == null
                  ? "0"
                  : mDashboardResultData.notDelivery.toString()),
          gridContainer(
              "Card Orders",
              mDashboardResultData.carhOrder == null
                  ? "0"
                  : mDashboardResultData.carhOrder.toString()),
          gridContainer(
              "Cash Orders",
              mDashboardResultData.cashOrder == null
                  ? "0"
                  : mDashboardResultData.cashOrder.toString()),
          gridContainer(
              "Web Orders",
              mDashboardResultData.webOrder == null
                  ? "0"
                  : mDashboardResultData.webOrder.toString()),
          gridContainer(
              "Epos Orders",
              mDashboardResultData.eposOrder == null
                  ? "0"
                  : mDashboardResultData.eposOrder.toString()),
        ],
      ),
    );
  }

  Widget gridContainer(String text, String number) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade100, offset: Offset(4, 4))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$text",
            style: TextStyle(
                color: ColorConfig.redColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          CircleAvatar(
            radius: 25.r,
            backgroundColor: ColorConfig.redColor,
            child: Center(
              child: Text(
                "$number",
                style: TextStyle(fontSize: 20.sp, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget recentOrdersContainer(RecentOrdersResultData recentOrdersData) {
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
                "Orders #${recentOrdersData.orderId}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              )),
              Expanded(
                  child: Text(
                recentOrdersData.orderdate.toString(),
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
                        recentOrdersData.name.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        recentOrdersData.address.toString(),
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
                            text: "£ ${recentOrdersData.totalamount}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                          TextSpan(text: "\t\t"),
                          TextSpan(
                            text: recentOrdersData.paymentTypeName.toString(),
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
                        "Total Items: ${4}",
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
            "Order Note : Do Not ring bell",
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
        mRecentItemPosition = index;
        var recentOrdersData = mRecentOrdersList[index];
        return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => OrderDetailScreen(
                          mRecentOrdersList[index].orderId.toString(),
                          AppConstants.FROM_DELIVERED)));
            },
            child: recentOrdersContainer(recentOrdersData));
      },
    );
  }

  getTodayDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    MyUtils().logger.d(formatted); //
    mTodayDate = formatted;
  }

  getDashboardDataApi() {
    mDriverId = SharedPreferencesRepository.getString(AppConstants.DRIVER_ID);
    MyUtils().logger.i("DRIVER_ID: " + mDriverId.toString());
    dioClient.getDashboardDetails(mDriverId).then((value) async {
      DashboardResponse dashboardResponse = DashboardResponse.fromJson(value);
      if (dashboardResponse.resultData != null) {
        mDashboardResultData = dashboardResponse.resultData!;
      }
      getRecentOrdersApi();
    });
  }

  getRecentOrdersApi() {
    mDriverId = SharedPreferencesRepository.getString(AppConstants.DRIVER_ID);
    dioClient.getRecentOrders(mDriverId, "1", "", "").then((value) async {
      RecentOrdersResponse recentOrders = RecentOrdersResponse.fromJson(value);
      if (recentOrders.resultData != null) {
        mRecentOrdersList.clear();
        mRecentOrdersList.addAll(recentOrders.resultData!);
        setState(() {
          isLoading = false;
        });
      }
    });
  }
}
