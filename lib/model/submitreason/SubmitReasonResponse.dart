import 'dart:convert';
/// Status : true
/// Message : "success"
/// ResultData : {"Id":0,"ReasonName":"Status Updated successfully"}

SubmitReasonResponse submitReasonResponseFromJson(String str) => SubmitReasonResponse.fromJson(json.decode(str));
String submitReasonResponseToJson(SubmitReasonResponse data) => json.encode(data.toJson());
class SubmitReasonResponse {
  SubmitReasonResponse({
      bool? status, 
      String? message, 
      SubmitReasonResultData? resultData,}){
    _status = status;
    _message = message;
    _resultData = resultData;
}

  SubmitReasonResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    _resultData = json['ResultData'] != null ? SubmitReasonResultData.fromJson(json['ResultData']) : null;
  }
  bool? _status;
  String? _message;
  SubmitReasonResultData? _resultData;

  bool? get status => _status;
  String? get message => _message;
  SubmitReasonResultData? get resultData => _resultData;

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

/// Id : 0
/// ReasonName : "Status Updated successfully"

SubmitReasonResultData resultDataFromJson(String str) => SubmitReasonResultData.fromJson(json.decode(str));
String resultDataToJson(SubmitReasonResultData data) => json.encode(data.toJson());
class SubmitReasonResultData {
  SubmitReasonResultData({
      int? id, 
      String? reasonName,}){
    _id = id;
    _reasonName = reasonName;
}

  SubmitReasonResultData.fromJson(dynamic json) {
    _id = json['Id'];
    _reasonName = json['ReasonName'];
  }
  int? _id;
  String? _reasonName;

  int? get id => _id;
  String? get reasonName => _reasonName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = _id;
    map['ReasonName'] = _reasonName;
    return map;
  }

}