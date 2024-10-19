import 'dart:convert';

/// Status : true
/// Message : "success"
/// ResultData : {"OrderId":0,"Name":null,"Address":null,"Orderdate":null,"Totalamount":null,"PaymentStatus":null,"mobile":null,"Orderno":null,"DeliveryStatusName":"Accepted","DeliveryNote":null,"Totalitem":0}

UpdateOrderStatusResponse updateOrderStatusResponseFromJson(String str) =>
    UpdateOrderStatusResponse.fromJson(json.decode(str));

String updateOrderStatusResponseToJson(UpdateOrderStatusResponse data) =>
    json.encode(data.toJson());

class UpdateOrderStatusResponse {
  UpdateOrderStatusResponse({
    bool? status,
    String? message,
    ResultData? resultData,
  }) {
    _status = status;
    _message = message;
    _resultData = resultData;
  }

  UpdateOrderStatusResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    _resultData = json['ResultData'] != null
        ? ResultData.fromJson(json['ResultData'])
        : null;
  }

  bool? _status;
  String? _message;
  ResultData? _resultData;

  bool? get status => _status;

  String? get message => _message;

  ResultData? get resultData => _resultData;

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

/// OrderId : 0
/// Name : null
/// Address : null
/// Orderdate : null
/// Totalamount : null
/// PaymentStatus : null
/// mobile : null
/// Orderno : null
/// DeliveryStatusName : "Accepted"
/// DeliveryNote : null
/// Totalitem : 0

ResultData resultDataFromJson(String str) =>
    ResultData.fromJson(json.decode(str));

String resultDataToJson(ResultData data) => json.encode(data.toJson());

class ResultData {
  ResultData({
    int? orderId,
    dynamic name,
    dynamic address,
    dynamic orderdate,
    dynamic totalamount,
    dynamic paymentStatus,
    dynamic mobile,
    dynamic orderno,
    String? deliveryStatusName,
    dynamic deliveryNote,
    int? totalitem,
  }) {
    _orderId = orderId;
    _name = name;
    _address = address;
    _orderdate = orderdate;
    _totalamount = totalamount;
    _paymentStatus = paymentStatus;
    _mobile = mobile;
    _orderno = orderno;
    _deliveryStatusName = deliveryStatusName;
    _deliveryNote = deliveryNote;
    _totalitem = totalitem;
  }

  ResultData.fromJson(dynamic json) {
    _orderId = json['OrderId'];
    _name = json['Name'];
    _address = json['Address'];
    _orderdate = json['Orderdate'];
    _totalamount = json['Totalamount'];
    _paymentStatus = json['PaymentStatus'];
    _mobile = json['mobile'];
    _orderno = json['Orderno'];
    _deliveryStatusName = json['DeliveryStatusName'];
    _deliveryNote = json['DeliveryNote'];
    _totalitem = json['Totalitem'];
  }

  int? _orderId;
  dynamic _name;
  dynamic _address;
  dynamic _orderdate;
  dynamic _totalamount;
  dynamic _paymentStatus;
  dynamic _mobile;
  dynamic _orderno;
  String? _deliveryStatusName;
  dynamic _deliveryNote;
  int? _totalitem;

  int? get orderId => _orderId;

  dynamic get name => _name;

  dynamic get address => _address;

  dynamic get orderdate => _orderdate;

  dynamic get totalamount => _totalamount;

  dynamic get paymentStatus => _paymentStatus;

  dynamic get mobile => _mobile;

  dynamic get orderno => _orderno;

  String? get deliveryStatusName => _deliveryStatusName;

  dynamic get deliveryNote => _deliveryNote;

  int? get totalitem => _totalitem;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrderId'] = _orderId;
    map['Name'] = _name;
    map['Address'] = _address;
    map['Orderdate'] = _orderdate;
    map['Totalamount'] = _totalamount;
    map['PaymentStatus'] = _paymentStatus;
    map['mobile'] = _mobile;
    map['Orderno'] = _orderno;
    map['DeliveryStatusName'] = _deliveryStatusName;
    map['DeliveryNote'] = _deliveryNote;
    map['Totalitem'] = _totalitem;
    return map;
  }
}
