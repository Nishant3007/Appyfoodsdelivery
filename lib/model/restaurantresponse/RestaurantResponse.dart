import 'dart:convert';

/// Status : true
/// Message : ""
/// ResultData : [{"RestaurantId":1,"RestaurantName":"Flamers Pizza (ME2 4NP)"},{"RestaurantId":7,"RestaurantName":"New Master Cheff (IG8 8AA)"},{"RestaurantId":8,"RestaurantName":"Morello Pizza (ME1 1EH)"},{"RestaurantId":9,"RestaurantName":"Marina Fish bar (ME15 6HE)"},{"RestaurantId":11,"RestaurantName":"Pearls silver (ME2 4NP)"},{"RestaurantId":12,"RestaurantName":"Star Restro (LL28 5TS)"},{"RestaurantId":13,"RestaurantName":"Manisha Indian Restaurant (ME2 4AP)"},{"RestaurantId":14,"RestaurantName":"Frindsbury Grill (ME2 4JB)"},{"RestaurantId":18,"RestaurantName":"Sony fast food (LL35 0ED)"}]

RestaurantResponse restaurantResponseFromJson(String str) =>
    RestaurantResponse.fromJson(json.decode(str));

String restaurantResponseToJson(RestaurantResponse data) =>
    json.encode(data.toJson());

class RestaurantResponse {
  RestaurantResponse({
    bool? status,
    String? message,
    List<RestaurantListData>? resultData,
  }) {
    _status = status;
    _message = message;
    _resultData = resultData;
  }

  RestaurantResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    if (json['ResultData'] != null) {
      _resultData = [];
      json['ResultData'].forEach((v) {
        _resultData?.add(RestaurantListData.fromJson(v));
      });
    }
  }

  bool? _status;
  String? _message;
  List<RestaurantListData>? _resultData;

  bool? get status => _status;

  String? get message => _message;

  List<RestaurantListData>? get resultData => _resultData;

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

/// RestaurantId : 1
/// RestaurantName : "Flamers Pizza (ME2 4NP)"

RestaurantListData resultDataFromJson(String str) =>
    RestaurantListData.fromJson(json.decode(str));

String resultDataToJson(RestaurantListData data) => json.encode(data.toJson());

class RestaurantListData {
  ResultData({
    int? restaurantId,
    String? restaurantName,
  }) {
    _restaurantId = restaurantId;
    _restaurantName = restaurantName;
  }

  RestaurantListData.fromJson(dynamic json) {
    _restaurantId = json['RestaurantId'];
    _restaurantName = json['RestaurantName'];
  }

  int? _restaurantId;
  String? _restaurantName;

  int? get restaurantId => _restaurantId;

  String? get restaurantName => _restaurantName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RestaurantId'] = _restaurantId;
    map['RestaurantName'] = _restaurantName;
    return map;
  }
}
