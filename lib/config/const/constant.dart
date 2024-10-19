class AppConstants {
  static const String API_KEY = "AIzaSyAXPotDG8Z1xC01LYrQegsZpGoM1KRicm8";
  static const String DRIVER_ID = "driver_id";
  static const String IS_LOGIN = "is_login";
  static const String DRIVER_NAME = "driver_name";
  static const String DRIVER_EMAIL = "driver_email";
  static const String DRIVER_PHONE = "driver_phone";
  static const String DRIVER_ADDRESS = "driver_address";
  static const String DRIVER_RESTAURANT_NAME = "driver_restaurant_name";
  static const String DRIVER_RESTAURANT_ADDRESS = "driver_restaurant_address";
  static const String DRIVER_RESTAURANT_PHONE = "driver_restaurant_phone";
  static const String FROM_HOME = "from_home";
  static const String FROM_NEW = "from_new";
  static const String FROM_PROCESSING = "from_processing";
  static const String FROM_DELIVERED = "from_delivered";
  static const int ORDER_STARED = 1;
  static const int ORDER_DELIVERED = 2;
  static const int ORDER_NOT_DELIVERED = 3;
}

class ApiEndPoints {
  static const baseUrl = "https://delivery.appyfoods.co.uk/api/";
  static const restaurantList = "${baseUrl}Delivery/GetRestaurantList";
  static const login = "${baseUrl}Delivery/DeliveryLogin";
  static const UnsuccessfulReasons =
      "${baseUrl}Delivery/Get_Unsuccessful_reason_list";
  static const recentOrder = "${baseUrl}Delivery/Get_ResentOrder_List";
  static const orderDetails = "${baseUrl}Delivery/GetOrderDetail";
  static const dashBoard = "${baseUrl}Delivery/DeliveryDashboard";
  static const newOrders = "${baseUrl}Delivery/NewOrderlist";
  static const processingOrders = "${baseUrl}Delivery/ProcessingOrderList";
  static const updateOrderStatus = "${baseUrl}Delivery/UpdateOrderSataus";
  static const submitReasonStatus =
      "${baseUrl}Delivery/Submit_Unsuccessful_Reason";
  static const sendDriverLetLang =
      "${baseUrl}Delivery/Driverlocation";

  static const checkDriverAvailability=
      "${baseUrl}Delivery/CheckDriverAvailability";
}

class ApiConstants {
  static const resText = "ResText";
  static const email = "Email";
  static const password = "Password";
  static const restaurantId = "RestaurantId";
  static const driverId = "DriverId";
  static const startDate = "Startdate";
  static const endDate = "Enddate";
  static const orderId = "OrderId";
  static const statusId = "StatusId";
  static const message = "Message";
  static const latitude = "latitude";
  static const longitude = "longitude";
}

class OrderUpdateStatusCode {
  static const startOrder = "15";
  static const notDelivered = "17";
  static const delivered = "16";
}

class ApiStatusCode {
  static const successCode = 200;
}
