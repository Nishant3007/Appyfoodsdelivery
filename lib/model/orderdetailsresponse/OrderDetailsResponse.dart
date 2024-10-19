import 'dart:convert';
/// Status : true
/// Message : "success"
/// ResultData : {"OrderId":2,"RestaurantId":1,"CustomerName":"Puneet Sharma","CFirstName":"Puneet","CLastName":"Sharma","CustomerAddress":"a","customerMobile":"9992229180","customerpostcode":"ME5 8JD","DeliveryLatidude":"","DeliveryLongitude":"","customerarea":"n","RestaurantName":"Flamers Pizza","RestaurantPhoneno":"+441634711511","RestaurantAddress":"Unit C3, Spectrum Business Centre, Anthony's Way, Medway City Estate, Strood, ME2 4NP","Restaurantwebsite":"www.theflamerspizza.co.uk","Restaurantlatidude":"51.39792213426347","RestaurantLongitude":"0.5155688524246216","DeliveryAddress":"TESTING ADDRESS, Test Address, Medway City Estate, Anthonys Way, ME2 4NP","DeliveryPhone":"","Discount":"0.00","ServiceTax":"0.00","Deliveryfee":"0.00","Subtotal":"16.98","Totalamount":"16.98","Orderno":"3AEED49B73","Orderdate":"3/11/2022 6:37:55 AM","Deliverydate":"","PaymentType":6,"OrderSourceType":"","PaymentType_Name":"Cash Paid","EstimatedTime":"50","Note":"","DeliveryStatus":"14","listofitems":[{"ItemName":"Chinese Pizza","Quanitity":1,"ItemPrice":"14.99"}]}

OrderDetailsResponse orderDetailsResponseFromJson(String str) => OrderDetailsResponse.fromJson(json.decode(str));
String orderDetailsResponseToJson(OrderDetailsResponse data) => json.encode(data.toJson());
class OrderDetailsResponse {
  OrderDetailsResponse({
      bool? status, 
      String? message, 
      OrderDetailsResultData? resultData,}){
    _status = status;
    _message = message;
    _resultData = resultData;
}

  OrderDetailsResponse.fromJson(dynamic json) {
    _status = json['Status'];
    _message = json['Message'];
    _resultData = json['ResultData'] != null ? OrderDetailsResultData.fromJson(json['ResultData']) : null;
  }
  bool? _status;
  String? _message;
  OrderDetailsResultData? _resultData;

  bool? get status => _status;
  String? get message => _message;
  OrderDetailsResultData? get resultData => _resultData;

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

/// OrderId : 2
/// RestaurantId : 1
/// CustomerName : "Puneet Sharma"
/// CFirstName : "Puneet"
/// CLastName : "Sharma"
/// CustomerAddress : "a"
/// customerMobile : "9992229180"
/// customerpostcode : "ME5 8JD"
/// DeliveryLatidude : ""
/// DeliveryLongitude : ""
/// customerarea : "n"
/// RestaurantName : "Flamers Pizza"
/// RestaurantPhoneno : "+441634711511"
/// RestaurantAddress : "Unit C3, Spectrum Business Centre, Anthony's Way, Medway City Estate, Strood, ME2 4NP"
/// Restaurantwebsite : "www.theflamerspizza.co.uk"
/// Restaurantlatidude : "51.39792213426347"
/// RestaurantLongitude : "0.5155688524246216"
/// DeliveryAddress : "TESTING ADDRESS, Test Address, Medway City Estate, Anthonys Way, ME2 4NP"
/// DeliveryPhone : ""
/// Discount : "0.00"
/// ServiceTax : "0.00"
/// Deliveryfee : "0.00"
/// Subtotal : "16.98"
/// Totalamount : "16.98"
/// Orderno : "3AEED49B73"
/// Orderdate : "3/11/2022 6:37:55 AM"
/// Deliverydate : ""
/// PaymentType : 6
/// OrderSourceType : ""
/// PaymentType_Name : "Cash Paid"
/// EstimatedTime : "50"
/// Note : ""
/// DeliveryStatus : "14"
/// listofitems : [{"ItemName":"Chinese Pizza","Quanitity":1,"ItemPrice":"14.99"}]

OrderDetailsResultData resultDataFromJson(String str) => OrderDetailsResultData.fromJson(json.decode(str));
String resultDataToJson(OrderDetailsResultData data) => json.encode(data.toJson());
class OrderDetailsResultData {
  OrderDetailsResultData({
      int? orderId, 
      int? restaurantId, 
      String? customerName, 
      String? cFirstName, 
      String? cLastName, 
      String? customerAddress, 
      String? customerMobile, 
      String? customerpostcode, 
      String? deliveryLatidude, 
      String? deliveryLongitude, 
      String? customerarea, 
      String? restaurantName, 
      String? restaurantPhoneno, 
      String? restaurantAddress, 
      String? restaurantwebsite, 
      String? restaurantlatidude, 
      String? restaurantLongitude, 
      String? deliveryAddress, 
      String? deliveryPhone, 
      String? discount, 
      String? serviceTax, 
      String? deliveryfee, 
      String? subtotal, 
      String? totalamount, 
      String? orderno, 
      String? orderdate, 
      String? deliverydate, 
      int? paymentType, 
      String? orderSourceType, 
      String? paymentTypeName, 
      String? estimatedTime, 
      String? note, 
      String? deliveryStatus, 
      List<Listofitems>? listofitems,}){
    _orderId = orderId;
    _restaurantId = restaurantId;
    _customerName = customerName;
    _cFirstName = cFirstName;
    _cLastName = cLastName;
    _customerAddress = customerAddress;
    _customerMobile = customerMobile;
    _customerpostcode = customerpostcode;
    _deliveryLatidude = deliveryLatidude;
    _deliveryLongitude = deliveryLongitude;
    _customerarea = customerarea;
    _restaurantName = restaurantName;
    _restaurantPhoneno = restaurantPhoneno;
    _restaurantAddress = restaurantAddress;
    _restaurantwebsite = restaurantwebsite;
    _restaurantlatidude = restaurantlatidude;
    _restaurantLongitude = restaurantLongitude;
    _deliveryAddress = deliveryAddress;
    _deliveryPhone = deliveryPhone;
    _discount = discount;
    _serviceTax = serviceTax;
    _deliveryfee = deliveryfee;
    _subtotal = subtotal;
    _totalamount = totalamount;
    _orderno = orderno;
    _orderdate = orderdate;
    _deliverydate = deliverydate;
    _paymentType = paymentType;
    _orderSourceType = orderSourceType;
    _paymentTypeName = paymentTypeName;
    _estimatedTime = estimatedTime;
    _note = note;
    _deliveryStatus = deliveryStatus;
    _listofitems = listofitems;
}

  OrderDetailsResultData.fromJson(dynamic json) {
    _orderId = json['OrderId'];
    _restaurantId = json['RestaurantId'];
    _customerName = json['CustomerName'];
    _cFirstName = json['CFirstName'];
    _cLastName = json['CLastName'];
    _customerAddress = json['CustomerAddress'];
    _customerMobile = json['customerMobile'];
    _customerpostcode = json['customerpostcode'];
    _deliveryLatidude = json['DeliveryLatidude'];
    _deliveryLongitude = json['DeliveryLongitude'];
    _customerarea = json['customerarea'];
    _restaurantName = json['RestaurantName'];
    _restaurantPhoneno = json['RestaurantPhoneno'];
    _restaurantAddress = json['RestaurantAddress'];
    _restaurantwebsite = json['Restaurantwebsite'];
    _restaurantlatidude = json['Restaurantlatidude'];
    _restaurantLongitude = json['RestaurantLongitude'];
    _deliveryAddress = json['DeliveryAddress'];
    _deliveryPhone = json['DeliveryPhone'];
    _discount = json['Discount'];
    _serviceTax = json['ServiceTax'];
    _deliveryfee = json['Deliveryfee'];
    _subtotal = json['Subtotal'];
    _totalamount = json['Totalamount'];
    _orderno = json['Orderno'];
    _orderdate = json['Orderdate'];
    _deliverydate = json['Deliverydate'];
    _paymentType = json['PaymentType'];
    _orderSourceType = json['OrderSourceType'];
    _paymentTypeName = json['PaymentType_Name'];
    _estimatedTime = json['EstimatedTime'];
    _note = json['Note'];
    _deliveryStatus = json['DeliveryStatus'];
    if (json['listofitems'] != null) {
      _listofitems = [];
      json['listofitems'].forEach((v) {
        _listofitems?.add(Listofitems.fromJson(v));
      });
    }
  }
  int? _orderId;
  int? _restaurantId;
  String? _customerName;
  String? _cFirstName;
  String? _cLastName;
  String? _customerAddress;
  String? _customerMobile;
  String? _customerpostcode;
  String? _deliveryLatidude;
  String? _deliveryLongitude;
  String? _customerarea;
  String? _restaurantName;
  String? _restaurantPhoneno;
  String? _restaurantAddress;
  String? _restaurantwebsite;
  String? _restaurantlatidude;
  String? _restaurantLongitude;
  String? _deliveryAddress;
  String? _deliveryPhone;
  String? _discount;
  String? _serviceTax;
  String? _deliveryfee;
  String? _subtotal;
  String? _totalamount;
  String? _orderno;
  String? _orderdate;
  String? _deliverydate;
  int? _paymentType;
  String? _orderSourceType;
  String? _paymentTypeName;
  String? _estimatedTime;
  String? _note;
  String? _deliveryStatus;
  List<Listofitems>? _listofitems;

  int? get orderId => _orderId;
  int? get restaurantId => _restaurantId;
  String? get customerName => _customerName;
  String? get cFirstName => _cFirstName;
  String? get cLastName => _cLastName;
  String? get customerAddress => _customerAddress;
  String? get customerMobile => _customerMobile;
  String? get customerpostcode => _customerpostcode;
  String? get deliveryLatidude => _deliveryLatidude;
  String? get deliveryLongitude => _deliveryLongitude;
  String? get customerarea => _customerarea;
  String? get restaurantName => _restaurantName;
  String? get restaurantPhoneno => _restaurantPhoneno;
  String? get restaurantAddress => _restaurantAddress;
  String? get restaurantwebsite => _restaurantwebsite;
  String? get restaurantlatidude => _restaurantlatidude;
  String? get restaurantLongitude => _restaurantLongitude;
  String? get deliveryAddress => _deliveryAddress;
  String? get deliveryPhone => _deliveryPhone;
  String? get discount => _discount;
  String? get serviceTax => _serviceTax;
  String? get deliveryfee => _deliveryfee;
  String? get subtotal => _subtotal;
  String? get totalamount => _totalamount;
  String? get orderno => _orderno;
  String? get orderdate => _orderdate;
  String? get deliverydate => _deliverydate;
  int? get paymentType => _paymentType;
  String? get orderSourceType => _orderSourceType;
  String? get paymentTypeName => _paymentTypeName;
  String? get estimatedTime => _estimatedTime;
  String? get note => _note;
  String? get deliveryStatus => _deliveryStatus;
  List<Listofitems>? get listofitems => _listofitems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['OrderId'] = _orderId;
    map['RestaurantId'] = _restaurantId;
    map['CustomerName'] = _customerName;
    map['CFirstName'] = _cFirstName;
    map['CLastName'] = _cLastName;
    map['CustomerAddress'] = _customerAddress;
    map['customerMobile'] = _customerMobile;
    map['customerpostcode'] = _customerpostcode;
    map['DeliveryLatidude'] = _deliveryLatidude;
    map['DeliveryLongitude'] = _deliveryLongitude;
    map['customerarea'] = _customerarea;
    map['RestaurantName'] = _restaurantName;
    map['RestaurantPhoneno'] = _restaurantPhoneno;
    map['RestaurantAddress'] = _restaurantAddress;
    map['Restaurantwebsite'] = _restaurantwebsite;
    map['Restaurantlatidude'] = _restaurantlatidude;
    map['RestaurantLongitude'] = _restaurantLongitude;
    map['DeliveryAddress'] = _deliveryAddress;
    map['DeliveryPhone'] = _deliveryPhone;
    map['Discount'] = _discount;
    map['ServiceTax'] = _serviceTax;
    map['Deliveryfee'] = _deliveryfee;
    map['Subtotal'] = _subtotal;
    map['Totalamount'] = _totalamount;
    map['Orderno'] = _orderno;
    map['Orderdate'] = _orderdate;
    map['Deliverydate'] = _deliverydate;
    map['PaymentType'] = _paymentType;
    map['OrderSourceType'] = _orderSourceType;
    map['PaymentType_Name'] = _paymentTypeName;
    map['EstimatedTime'] = _estimatedTime;
    map['Note'] = _note;
    map['DeliveryStatus'] = _deliveryStatus;
    if (_listofitems != null) {
      map['listofitems'] = _listofitems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// ItemName : "Chinese Pizza"
/// Quanitity : 1
/// ItemPrice : "14.99"

Listofitems listofitemsFromJson(String str) => Listofitems.fromJson(json.decode(str));
String listofitemsToJson(Listofitems data) => json.encode(data.toJson());
class Listofitems {
  Listofitems({
      String? itemName, 
      int? quanitity, 
      String? itemPrice,}){
    _itemName = itemName;
    _quanitity = quanitity;
    _itemPrice = itemPrice;
}

  Listofitems.fromJson(dynamic json) {
    _itemName = json['ItemName'];
    _quanitity = json['Quanitity'];
    _itemPrice = json['ItemPrice'];
  }
  String? _itemName;
  int? _quanitity;
  String? _itemPrice;

  String? get itemName => _itemName;
  int? get quanitity => _quanitity;
  String? get itemPrice => _itemPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ItemName'] = _itemName;
    map['Quanitity'] = _quanitity;
    map['ItemPrice'] = _itemPrice;
    return map;
  }

}