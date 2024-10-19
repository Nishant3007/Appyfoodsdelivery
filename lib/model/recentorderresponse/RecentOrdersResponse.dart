import 'dart:convert';
/// Status : true
/// Message : "success"
/// ResultData : [{"OrderId":2,"Name":"","Address":"TESTING ADDRESS, Test Address, Medway City Estate, Anthonys Way, ME2 4NP","Orderdate":"3/11/2022 6:37:55 AM","Totalamount":"16.98","PaymentStatus":6,"mobile":"1234567890","Orderno":"3AEED49B73","DeliveryStatusName":"","Restaurantlatidude":"51.39792213426347","RestaurantLongitude":"0.5155688524246216","DeliveryLatidude":"","DeliveryLongitude":"","DeliveryNote":"","Totalitem":1,"PaymentType_Name":"Cash Paid"},{"OrderId":12,"Name":"","Address":"TEST ADDRESSS, Medway City Estate TEST, Anthonys Way TEST, ME2 4NP","Orderdate":"3/11/2022 11:01:01 AM","Totalamount":"14.99","PaymentStatus":6,"mobile":"1234567890","Orderno":"055737162D","DeliveryStatusName":"","Restaurantlatidude":"51.39792213426347","RestaurantLongitude":"0.5155688524246216","DeliveryLatidude":"","DeliveryLongitude":"","DeliveryNote":"","Totalitem":1,"PaymentType_Name":"Cash Paid"}]

RecentOrdersResponse recentOrdersResponseFromJson(String str) => RecentOrdersResponse.fromJson(json.decode(str));
String recentOrdersResponseToJson(RecentOrdersResponse data) => json.encode(data.toJson());
class RecentOrdersResponse {
  RecentOrdersResponse({
      bool? status, 
      String? message, 
      List<RecentOrdersResultData>? resultData,}){
    _status = status;
    _message = message;
    _resultData = resultData;
}

  RecentOrdersResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    if (json['ResultData'] != null) {
      _resultData = [];
      json['ResultData'].forEach((v) {
        _resultData?.add(RecentOrdersResultData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<RecentOrdersResultData>? _resultData;

  bool? get status => _status;
  String? get message => _message;
  List<RecentOrdersResultData>? get resultData => _resultData;

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

/// OrderId : 2
/// Name : ""
/// Address : "TESTING ADDRESS, Test Address, Medway City Estate, Anthonys Way, ME2 4NP"
/// Orderdate : "3/11/2022 6:37:55 AM"
/// Totalamount : "16.98"
/// PaymentStatus : 6
/// mobile : "1234567890"
/// Orderno : "3AEED49B73"
/// DeliveryStatusName : ""
/// Restaurantlatidude : "51.39792213426347"
/// RestaurantLongitude : "0.5155688524246216"
/// DeliveryLatidude : ""
/// DeliveryLongitude : ""
/// DeliveryNote : ""
/// Totalitem : 1
/// PaymentType_Name : "Cash Paid"

RecentOrdersResultData resultDataFromJson(String str) => RecentOrdersResultData.fromJson(json.decode(str));
String resultDataToJson(RecentOrdersResultData data) => json.encode(data.toJson());
class RecentOrdersResultData {
  RecentOrdersResultData({
      int? orderId, 
      String? name, 
      String? address, 
      String? orderdate, 
      String? totalamount, 
      int? paymentStatus, 
      String? mobile, 
      String? orderno, 
      String? deliveryStatusName, 
      String? restaurantlatidude, 
      String? restaurantLongitude, 
      String? deliveryLatidude, 
      String? deliveryLongitude, 
      String? deliveryNote, 
      int? totalitem, 
      String? paymentTypeName,}){
    _orderId = orderId;
    _name = name;
    _address = address;
    _orderdate = orderdate;
    _totalamount = totalamount;
    _paymentStatus = paymentStatus;
    _mobile = mobile;
    _orderno = orderno;
    _deliveryStatusName = deliveryStatusName;
    _restaurantlatidude = restaurantlatidude;
    _restaurantLongitude = restaurantLongitude;
    _deliveryLatidude = deliveryLatidude;
    _deliveryLongitude = deliveryLongitude;
    _deliveryNote = deliveryNote;
    _totalitem = totalitem;
    _paymentTypeName = paymentTypeName;
}

  RecentOrdersResultData.fromJson(dynamic json) {
    _orderId = json['OrderId'];
    _name = json['Name'];
    _address = json['Address'];
    _orderdate = json['Orderdate'];
    _totalamount = json['Totalamount'];
    _paymentStatus = json['PaymentStatus'];
    _mobile = json['mobile'];
    _orderno = json['Orderno'];
    _deliveryStatusName = json['DeliveryStatusName'];
    _restaurantlatidude = json['Restaurantlatidude'];
    _restaurantLongitude = json['RestaurantLongitude'];
    _deliveryLatidude = json['DeliveryLatidude'];
    _deliveryLongitude = json['DeliveryLongitude'];
    _deliveryNote = json['DeliveryNote'];
    _totalitem = json['Totalitem'];
    _paymentTypeName = json['PaymentType_Name'];
  }
  int? _orderId;
  String? _name;
  String? _address;
  String? _orderdate;
  String? _totalamount;
  int? _paymentStatus;
  String? _mobile;
  String? _orderno;
  String? _deliveryStatusName;
  String? _restaurantlatidude;
  String? _restaurantLongitude;
  String? _deliveryLatidude;
  String? _deliveryLongitude;
  String? _deliveryNote;
  int? _totalitem;
  String? _paymentTypeName;

  int? get orderId => _orderId;
  String? get name => _name;
  String? get address => _address;
  String? get orderdate => _orderdate;
  String? get totalamount => _totalamount;
  int? get paymentStatus => _paymentStatus;
  String? get mobile => _mobile;
  String? get orderno => _orderno;
  String? get deliveryStatusName => _deliveryStatusName;
  String? get restaurantlatidude => _restaurantlatidude;
  String? get restaurantLongitude => _restaurantLongitude;
  String? get deliveryLatidude => _deliveryLatidude;
  String? get deliveryLongitude => _deliveryLongitude;
  String? get deliveryNote => _deliveryNote;
  int? get totalitem => _totalitem;
  String? get paymentTypeName => _paymentTypeName;

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
    map['Restaurantlatidude'] = _restaurantlatidude;
    map['RestaurantLongitude'] = _restaurantLongitude;
    map['DeliveryLatidude'] = _deliveryLatidude;
    map['DeliveryLongitude'] = _deliveryLongitude;
    map['DeliveryNote'] = _deliveryNote;
    map['Totalitem'] = _totalitem;
    map['PaymentType_Name'] = _paymentTypeName;
    return map;
  }

}