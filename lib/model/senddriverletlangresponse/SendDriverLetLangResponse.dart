import 'dart:convert';
/// Status : true
/// Message : "success"
/// ResultData : {"DriverlocationId":0,"Message":"Location updated successfully"}

SendDriverLetLangResponse sendDriverLetLangResponseFromJson(String str) => SendDriverLetLangResponse.fromJson(json.decode(str));
String sendDriverLetLangResponseToJson(SendDriverLetLangResponse data) => json.encode(data.toJson());
class SendDriverLetLangResponse {
  SendDriverLetLangResponse({
      bool? status, 
      String? message, 
      SendDriverLetLang? resultData,}){
    _status = status;
    _message = message;
    _resultData = resultData;
}

  SendDriverLetLangResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    _resultData = json['ResultData'] != null ? SendDriverLetLang.fromJson(json['ResultData']) : null;
  }
  bool? _status;
  String? _message;
  SendDriverLetLang? _resultData;

  bool? get status => _status;
  String? get message => _message;
  SendDriverLetLang? get resultData => _resultData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    if (_resultData != null) {
      map['ResultData'] = _resultData?.toJson();
    }
    return map;
  }

}

/// DriverlocationId : 0
/// Message : "Location updated successfully"

SendDriverLetLang resultDataFromJson(String str) => SendDriverLetLang.fromJson(json.decode(str));
String resultDataToJson(SendDriverLetLang data) => json.encode(data.toJson());
class SendDriverLetLang {
  SendDriverLetLang({
      int? driverlocationId, 
      String? message,}){
    _driverlocationId = driverlocationId;
    _message = message;
}

  SendDriverLetLang.fromJson(dynamic json) {
    _driverlocationId = json['DriverlocationId'];
    _message = json['Message'];
  }
  int? _driverlocationId;
  String? _message;

  int? get driverlocationId => _driverlocationId;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['DriverlocationId'] = _driverlocationId;
    map['Message'] = _message;
    return map;
  }

}