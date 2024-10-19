import 'dart:convert';

/// Status : true
/// Message : ""
/// ResultData : {"Total_Order":14,"Cash_order":15,"Carh_order":17,"Web_Order":20,"Epos_order":6,"Total_Delivered":12,"Not_Delivery":10}

DashboardResponse dashboardResponseFromJson(String str) =>
    DashboardResponse.fromJson(json.decode(str));

String dashboardResponseToJson(DashboardResponse data) =>
    json.encode(data.toJson());

class DashboardResponse {
  DashboardResponse({
    bool? status,
    String? message,
    DashboardResultData? resultData,
  }) {
    _status = status;
    _message = message;
    _resultData = resultData;
  }

  DashboardResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    _resultData = json['ResultData'] != null
        ? DashboardResultData.fromJson(json['ResultData'])
        : null;
  }

  bool? _status;
  String? _message;
  DashboardResultData? _resultData;

  bool? get status => _status;

  String? get message => _message;

  DashboardResultData? get resultData => _resultData;

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

/// Total_Order : 14
/// Cash_order : 15
/// Carh_order : 17
/// Web_Order : 20
/// Epos_order : 6
/// Total_Delivered : 12
/// Not_Delivery : 10

DashboardResultData resultDataFromJson(String str) =>
    DashboardResultData.fromJson(json.decode(str));

String resultDataToJson(DashboardResultData data) => json.encode(data.toJson());

class DashboardResultData {
  DashboardResultData({
    int? totalOrder,
    int? cashOrder,
    int? carhOrder,
    int? webOrder,
    int? eposOrder,
    int? totalDelivered,
    int? notDelivery,
  }) {
    _totalOrder = totalOrder;
    _cashOrder = cashOrder;
    _carhOrder = carhOrder;
    _webOrder = webOrder;
    _eposOrder = eposOrder;
    _totalDelivered = totalDelivered;
    _notDelivery = notDelivery;
  }

  DashboardResultData.fromJson(dynamic json) {
    _totalOrder = json['Total_Order'];
    _cashOrder = json['Cash_order'];
    _carhOrder = json['Carh_order'];
    _webOrder = json['Web_Order'];
    _eposOrder = json['Epos_order'];
    _totalDelivered = json['Total_Delivered'];
    _notDelivery = json['Not_Delivery'];
  }

  int? _totalOrder;
  int? _cashOrder;
  int? _carhOrder;
  int? _webOrder;
  int? _eposOrder;
  int? _totalDelivered;
  int? _notDelivery;

  int? get totalOrder => _totalOrder;

  int? get cashOrder => _cashOrder;

  int? get carhOrder => _carhOrder;

  int? get webOrder => _webOrder;

  int? get eposOrder => _eposOrder;

  int? get totalDelivered => _totalDelivered;

  int? get notDelivery => _notDelivery;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Total_Order'] = _totalOrder;
    map['Cash_order'] = _cashOrder;
    map['Carh_order'] = _carhOrder;
    map['Web_Order'] = _webOrder;
    map['Epos_order'] = _eposOrder;
    map['Total_Delivered'] = _totalDelivered;
    map['Not_Delivery'] = _notDelivery;
    return map;
  }
}
