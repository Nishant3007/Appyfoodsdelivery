class DeliveryUnsccessfullModel {
  int id;
  String reasonMsg;

  DeliveryUnsccessfullModel({required this.id, required this.reasonMsg});

  static List<DeliveryUnsccessfullModel> deliveryUnsuccessfullReasonList = [
    DeliveryUnsccessfullModel(id: 0, reasonMsg: "Wrong delivery address"),
    DeliveryUnsccessfullModel(
        id: 1, reasonMsg: "Concerned person not available"),
    DeliveryUnsccessfullModel(
      id: 2,
      reasonMsg: "Wrong delivery address",
    ),
    DeliveryUnsccessfullModel(id: 3, reasonMsg: "Call was not picked"),
    DeliveryUnsccessfullModel(id: 4, reasonMsg: "Others"),
  ];
}
