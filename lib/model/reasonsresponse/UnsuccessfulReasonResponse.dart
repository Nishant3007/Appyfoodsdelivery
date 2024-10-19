import 'dart:convert';

/// Status : true
/// Message : ""
/// ResultData : [{"Id":1,"ReasonName":"Wrong delivery address"},{"Id":2,"ReasonName":"Concerned person not available"},{"Id":3,"ReasonName":"Wrong delivery address"},{"Id":4,"ReasonName":"Call was not delivery"},{"Id":5,"ReasonName":"Other"}]

UnsuccessfulReasonResponse unsuccessfulReasonResponseFromJson(String str) =>
    UnsuccessfulReasonResponse.fromJson(json.decode(str));

String unsuccessfulReasonResponseToJson(UnsuccessfulReasonResponse data) =>
    json.encode(data.toJson());

class UnsuccessfulReasonResponse {
  UnsuccessfulReasonResponse({
    bool? status,
    String? message,
    List<UnsuccessfulResonsResultData>? resultData,
  }) {
    _status = status;
    _message = message;
    _resultData = resultData;
  }

  UnsuccessfulReasonResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    if (json['ResultData'] != null) {
      _resultData = [];
      json['ResultData'].forEach((v) {
        _resultData?.add(UnsuccessfulResonsResultData.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<UnsuccessfulResonsResultData>? _resultData;

  bool? get status => _status;

  String? get message => _message;

  List<UnsuccessfulResonsResultData>? get resultData => _resultData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['Message'] = _message;
    if (_resultData != null) {
      map['ResultData'] = _resultData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// Id : 1
/// ReasonName : "Wrong delivery address"

UnsuccessfulResonsResultData resultDataFromJson(String str) =>
    UnsuccessfulResonsResultData.fromJson(json.decode(str));

String resultDataToJson(UnsuccessfulResonsResultData data) =>
    json.encode(data.toJson());

class UnsuccessfulResonsResultData {
  UnsuccessfulResonsResultData({
    int? id,
    String? reasonName,
  }) {
    _id = id;
    _reasonName = reasonName;
  }

  UnsuccessfulResonsResultData.fromJson(dynamic json) {
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
