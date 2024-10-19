import 'package:appyfooddelivery/config/const/constant.dart';
import 'package:appyfooddelivery/network/responseclient/response_client.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioClient {
  final Dio dio = Dio();
  var logger = Logger();

  //Restaurant List
  Future<dynamic> getRestaurantList(String resText) async {
    var response = await dio.get(ApiEndPoints.restaurantList,
        queryParameters: {ApiConstants.resText: resText});
    return ResponseClient().getApiResponse(response);
  }

  //Login User
  Future<dynamic> loginUser(
      String email, String password, String restaurantId) async {
    var response = await dio.post(ApiEndPoints.login, data: {
      ApiConstants.email: email,
      ApiConstants.password: password,
      ApiConstants.restaurantId: restaurantId
    });
    return ResponseClient().getApiResponse(response);
  }

  //Dashboard
  Future<dynamic> getDashboardDetails(String driverID) async {
    var response = await dio.get(ApiEndPoints.dashBoard,
        queryParameters: {ApiConstants.driverId: driverID});
    return ResponseClient().getApiResponse(response);
  }

  //Unsuccessful Reasons
  Future<dynamic> getUnsuccessfulReasons() async {
    var response =
        await dio.get(ApiEndPoints.UnsuccessfulReasons, queryParameters: {});
    return ResponseClient().getApiResponse(response);
  }

  //Recent Orders
  Future<dynamic> getRecentOrders(String driverID, String restaurantId,
      String statDate, String endDate) async {
    var response = await dio.get(ApiEndPoints.recentOrder, queryParameters: {
      ApiConstants.driverId: driverID,
      ApiConstants.restaurantId: restaurantId,
      ApiConstants.startDate: statDate,
      ApiConstants.endDate: endDate
    });
    return ResponseClient().getApiResponse(response);
  }

  //OrderDetails
  Future<dynamic> getOrderDetails(String driverId, String orderId) async {
    var response = await dio.get(ApiEndPoints.orderDetails, queryParameters: {
      ApiConstants.orderId: orderId,
      ApiConstants.driverId: driverId
    });
    return ResponseClient().getApiResponse(response);
  }

  //NewOrders
  Future<dynamic> getNewOrders(String driverId) async {
    var response = await dio.get(ApiEndPoints.newOrders,
        queryParameters: {ApiConstants.driverId: driverId});
    return ResponseClient().getApiResponse(response);
  }

  //ProcessingOrderListOrders
  Future<dynamic> getProcessingOrders(String driverId, String orderid) async {
    var response = await dio.get(ApiEndPoints.processingOrders,
        queryParameters: {
          ApiConstants.driverId: driverId,
          ApiConstants.orderId: orderid
        });
    return ResponseClient().getApiResponse(response);
  }

  //UpdateOrder Status
  Future<dynamic> updateOrderStatus(String statusId, String orderId) async {
    var response = await dio.get(ApiEndPoints.updateOrderStatus,
        queryParameters: {
          ApiConstants.statusId: statusId,
          ApiConstants.orderId: orderId
        });
    return ResponseClient().getApiResponse(response);
  }

  //Submit Reason Status
  Future<dynamic> submitReasonStatus(
    String driverId,
    String orderId,
    String restaurantId,
    String statusId,
    String message,
  ) async {
    var response =
        await dio.get(ApiEndPoints.submitReasonStatus, queryParameters: {
      ApiConstants.driverId: driverId,
      ApiConstants.orderId: statusId,
      ApiConstants.restaurantId: orderId,
      ApiConstants.statusId: statusId,
      ApiConstants.message: message
    });
    return ResponseClient().getApiResponse(response);
  }

  //Send Driver Let Lang
  Future<dynamic> sendDriverLetLang(
      String driverId, String latitude, String longitude) async {
    var response = await dio.post(ApiEndPoints.sendDriverLetLang, data: {
      ApiConstants.driverId: driverId,
      ApiConstants.latitude: latitude,
      ApiConstants.longitude: longitude
    });
    return ResponseClient().getApiResponse(response);
  }

  //Check Driver Availability
  Future<dynamic> checkDriverAvailability(
    String driverId,
  ) async {
    var response =
        await dio.get(ApiEndPoints.checkDriverAvailability, queryParameters: {
      ApiConstants.driverId: driverId,
    });
    return ResponseClient().getApiResponse(response);
  }
}
