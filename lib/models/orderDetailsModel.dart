class OrderDetailsModel{
  String userId,orderId,paymentStatus,orderStatus,selectedTime,notes;
  double totalPrice, shippingCharge, itemPrice, discount;
  List items;
  Map deliveryAddress;


  OrderDetailsModel({
    required this.userId,
    required this.orderId,
    required this.paymentStatus,
    required this.orderStatus,
    required this.selectedTime,
    required this.totalPrice,
    required this.items,
    required this.notes,
    required this.deliveryAddress,
    required this.shippingCharge,
    required this.itemPrice,
    required this.discount,

  });

  Map <String, dynamic> toMap(){
    return{
      "userId" : this.userId,
      "orderId" : this.orderId,
      "paymentStatus" : this.paymentStatus,
      "orderStatus" : this.orderStatus,
      "selectedTime" : this.selectedTime,
      "totalPrice" : this.totalPrice,
      "items" : this.items,
      "notes" : this.notes,
      "deliveryAddress" : this.deliveryAddress,
      "shippingCharge" : this.shippingCharge,
      "itemPrice" : this.itemPrice,
      "discount" : this.discount,

    };
  }
  factory OrderDetailsModel.fromMap (Map <String, dynamic> map){
    return OrderDetailsModel (
      userId: map["userId"]??"",
      orderId: map["orderId"]??"",
      paymentStatus: map["paymentStatus"]??"",
      orderStatus: map["orderStatus"]??"",
      selectedTime: map["selectedTime"]??"",
      totalPrice: map["totalPrice"]??"",
      items: map["items"]??[],
      notes: map["notes"]??[],
      deliveryAddress: map["deliveryAddress"] ?? {},
      shippingCharge: map["shippingCharge"] ?? 0,
      itemPrice: map["itemPrice"] ?? 0,
      discount: map["discount"] ?? 0,
    );
  }
  OrderDetailsModel copyWith({
    String?  userId,orderId, paymentStatus,orderStatus,selectedTime,notes,
    double? totalPrice,shippingCharge, itemPrice, discount,
    List? items,
    Map? deliveryAddress,
  }){
    return OrderDetailsModel(
      userId: userId ?? this.userId,
      orderId: userId ?? this.orderId,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      selectedTime: selectedTime ?? this.selectedTime,
      totalPrice: totalPrice ?? this.totalPrice,
      items: items ?? this.items,
      notes: notes ?? this.notes,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      shippingCharge: shippingCharge ?? this.shippingCharge,
      itemPrice: itemPrice ?? this.itemPrice,
      discount: discount ?? this.discount,
    );
  }
}
