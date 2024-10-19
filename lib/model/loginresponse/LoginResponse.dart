import 'dart:convert';
/// Status : true
/// Message : "success"
/// ResultData : {"DriverId":4,"RestaurantId":1,"Name":"A verma","email":"a@appyfoods.com","RestaurantName":"Flamers Pizza","mobile":"1234567890","address":"Testing Address","Token":"NTg1ZjRhYTAtY2Y5Mi00MmJjLTlkOWYtMTk2Y2Q1YTg4YTcwLzQ=","Password":"Ze37nXN7V2I=","IsActive":true}
/// Token : null
/// UserId : 0
/// Username : null
/// StatusCode : null

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));
String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());
class LoginResponse {
  LoginResponse({
      bool? status, 
      String? message, 
      LoginResultData? resultData,
      dynamic token, 
      int? userId, 
      dynamic username, 
      dynamic statusCode,}){
    _status = status;
    _message = message;
    _resultData = resultData;
    _token = token;
    _userId = userId;
    _username = username;
    _statusCode = statusCode;
}

  LoginResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    _resultData = json['ResultData'] != null ? LoginResultData.fromJson(json['ResultData']) : null;
    _token = json['Token'];
    _userId = json['UserId'];
    _username = json['Username'];
    _statusCode = json['StatusCode'];
  }
  bool? _status;
  String? _message;
  LoginResultData? _resultData;
  dynamic _token;
  int? _userId;
  dynamic _username;
  dynamic _statusCode;

  bool? get status => _status;
  String? get message => _message;
  LoginResultData? get resultData => _resultData;
  dynamic get token => _token;
  int? get userId => _userId;
  dynamic get username => _username;
  dynamic get statusCode => _statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    if (_resultData != null) {
      map['ResultData'] = _resultData?.toJson();
    }
    map['Token'] = _token;
    map['UserId'] = _userId;
    map['Username'] = _username;
    map['StatusCode'] = _statusCode;
    return map;
  }

}

/// DriverId : 4
/// RestaurantId : 1
/// Name : "A verma"
/// email : "a@appyfoods.com"
/// RestaurantName : "Flamers Pizza"
/// mobile : "1234567890"
/// address : "Testing Address"
/// Token : "NTg1ZjRhYTAtY2Y5Mi00MmJjLTlkOWYtMTk2Y2Q1YTg4YTcwLzQ="
/// Password : "Ze37nXN7V2I="
/// IsActive : true

LoginResultData resultDataFromJson(String str) => LoginResultData.fromJson(json.decode(str));
String resultDataToJson(LoginResultData data) => json.encode(data.toJson());
class LoginResultData {
  LoginResultData({
      int? driverId, 
      int? restaurantId, 
      String? name, 
      String? email, 
      String? restaurantName, 
      String? mobile, 
      String? address, 
      String? token, 
      String? password, 
      bool? isActive,}){
    _driverId = driverId;
    _restaurantId = restaurantId;
    _name = name;
    _email = email;
    _restaurantName = restaurantName;
    _mobile = mobile;
    _address = address;
    _token = token;
    _password = password;
    _isActive = isActive;
}

  LoginResultData.fromJson(dynamic json) {
    _driverId = json['DriverId'];
    _restaurantId = json['RestaurantId'];
    _name = json['Name'];
    _email = json['email'];
    _restaurantName = json['RestaurantName'];
    _mobile = json['mobile'];
    _address = json['address'];
    _token = json['Token'];
    _password = json['Password'];
    _isActive = json['IsActive'];
  }
  int? _driverId;
  int? _restaurantId;
  String? _name;
  String? _email;
  String? _restaurantName;
  String? _mobile;
  String? _address;
  String? _token;
  String? _password;
  bool? _isActive;

  int? get driverId => _driverId;
  int? get restaurantId => _restaurantId;
  String? get name => _name;
  String? get email => _email;
  String? get restaurantName => _restaurantName;
  String? get mobile => _mobile;
  String? get address => _address;
  String? get token => _token;
  String? get password => _password;
  bool? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['DriverId'] = _driverId;
    map['RestaurantId'] = _restaurantId;
    map['Name'] = _name;
    map['email'] = _email;
    map['RestaurantName'] = _restaurantName;
    map['mobile'] = _mobile;
    map['address'] = _address;
    map['Token'] = _token;
    map['Password'] = _password;
    map['IsActive'] = _isActive;
    return map;
  }

}