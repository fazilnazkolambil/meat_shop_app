class OrderDetailsModel{
  String userId,paymentStatus,orderStatus;
  List items,address,orderHistory;


  OrderDetailsModel({
    required this.userId,
    required this.paymentStatus,
    required this.orderStatus,
    required this.items,
    required this.address,
    required this.orderHistory,

  });

  Map <String, dynamic> toMap(){
    return{
      "userId" : this.userId,
      "paymentStatus" : this.paymentStatus,
      "orderStatus" : this.orderStatus,
      "items" : this.items,
      "address" : this.address,
      "orderHistory":this.orderHistory
    };
  }
  factory OrderDetailsModel.fromMap (Map <String, dynamic> map){
    return OrderDetailsModel (
      userId: map["userId"]??"",
      paymentStatus: map["paymentStatus"]??"",
      orderStatus: map["orderStatus"]??"",
      items: map["items"]??[],
      address: map["address"]??[],
      orderHistory: map["orderHistory"]??[],
    );
  }
  OrderDetailsModel copyWith({
    String?  userId, paymentStatus,orderStatus,
    List? items,address,orderHistory,
  }){
    return OrderDetailsModel(
      userId: userId ?? this.userId,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      items: items ?? this.items,
      address: address ?? this.address,
      orderHistory: orderHistory ?? this.orderHistory,
    );
  }

}
