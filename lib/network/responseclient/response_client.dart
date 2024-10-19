import 'package:appyfooddelivery/utils/utils.dart';
import 'package:dio/dio.dart';

import '../../config/const/constant.dart';

class ResponseClient {
  getApiResponse(Response<dynamic> response) {
    Map map = response.data;
    try {
      MyUtils().logger.i("API_RESPONSE: " + response.data.toString());
      if (response.statusCode == ApiStatusCode.successCode) {
        map = response.data;
        return map;
      }
    } on DioError catch (e) {
      MyUtils().logger.e("Status Code: ${e.response?.statusCode.toString()}");
      MyUtils().logger.e("Status: ${e.response?.toString()}");
      throw Exception("FAILED TO CALL API ");
    }
  }
}
