import 'dart:convert';
/// Status : true
/// Message : "success"
/// ResultData : {"IsdriverAvailability":true}

CheckDriverAvailabilityResponse checkDriverAvailabilityResponseFromJson(String str) => CheckDriverAvailabilityResponse.fromJson(json.decode(str));
String checkDriverAvailabilityResponseToJson(CheckDriverAvailabilityResponse data) => json.encode(data.toJson());
class CheckDriverAvailabilityResponse {
  CheckDriverAvailabilityResponse({
      bool? status, 
      String? message, 
      CheckDriverAvailabilityResultData? resultData,}){
    _status = status;
    _message = message;
    _resultData = resultData;
}

  CheckDriverAvailabilityResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    _resultData = json['ResultData'] != null ? CheckDriverAvailabilityResultData.fromJson(json['ResultData']) : null;
  }
  bool? _status;
  String? _message;
  CheckDriverAvailabilityResultData? _resultData;

  bool? get status => _status;
  String? get message => _message;
  CheckDriverAvailabilityResultData? get resultData => _resultData;

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

/// IsdriverAvailability : true

CheckDriverAvailabilityResultData resultDataFromJson(String str) => CheckDriverAvailabilityResultData.fromJson(json.decode(str));
String resultDataToJson(CheckDriverAvailabilityResultData data) => json.encode(data.toJson());
class CheckDriverAvailabilityResultData {
  CheckDriverAvailabilityResultData({
      bool? isdriverAvailability,}){
    _isdriverAvailability = isdriverAvailability;
}

  CheckDriverAvailabilityResultData.fromJson(dynamic json) {
    _isdriverAvailability = json['IsdriverAvailability'];
  }
  bool? _isdriverAvailability;

  bool? get isdriverAvailability => _isdriverAvailability;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IsdriverAvailability'] = _isdriverAvailability;
    return map;
  }

}