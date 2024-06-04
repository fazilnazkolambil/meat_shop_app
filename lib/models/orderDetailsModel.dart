class OrderDetailsModel{
  String userId,orderId,paymentStatus,orderStatus,orderDate,orderTime,notes;
  double totalPrice;
  List items;
  Map deliveryAddress;


  OrderDetailsModel({
    required this.userId,
    required this.orderId,
    required this.paymentStatus,
    required this.orderStatus,
    required this.orderDate,
    required this.orderTime,
    required this.totalPrice,
    required this.items,
    required this.notes,
    required this.deliveryAddress

  });

  Map <String, dynamic> toMap(){
    return{
      "userId" : this.userId,
      "orderId" : this.orderId,
      "paymentStatus" : this.paymentStatus,
      "orderStatus" : this.orderStatus,
      "orderDate" : this.orderDate,
      "orderTime" : this.orderTime,
      "totalPrice" : this.totalPrice,
      "items" : this.items,
      "notes" : this.notes,
      "deliveryAddress" : this.deliveryAddress,

    };
  }
  factory OrderDetailsModel.fromMap (Map <String, dynamic> map){
    return OrderDetailsModel (
      userId: map["userId"]??"",
      orderId: map["orderId"]??"",
      paymentStatus: map["paymentStatus"]??"",
      orderStatus: map["orderStatus"]??"",
      orderDate: map["orderDate"]??"",
      orderTime: map["orderTime"]??"",
      totalPrice: map["totalPrice"]??"",
      items: map["items"]??[],
      notes: map["notes"]??[],
      deliveryAddress: map["deliveryAddress"] ?? {},
    );
  }
  OrderDetailsModel copyWith({
    String?  userId,orderId, paymentStatus,orderStatus,orderDate,orderTime,notes,
    double? totalPrice,
    List? items,
    Map? deliveryAddress,
  }){
    return OrderDetailsModel(
      userId: userId ?? this.userId,
      orderId: userId ?? this.orderId,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      orderDate: orderDate ?? this.orderDate,
      orderTime: orderTime ?? this.orderTime,
      totalPrice: totalPrice ?? this.totalPrice,
      items: items ?? this.items,
      notes: notes ?? this.notes,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
    );
  }
}
