class addressModel{
  String? address,name,number,location,pincode,deliveryinsruction;
  addressModel({
    required this.name,
    required this.number,
    required this.address,
    required this.location,
    required this.pincode,
    required this.deliveryinsruction
  });

  Map <String, dynamic> toMap(){
    return{
      "address" : this.address,
      "name" : this.name,
      "number" : this.number,
      "location" : this.location,
      "pincode" : this.pincode,
      "deliveryinsruction":this.deliveryinsruction
    };
  }
  factory addressModel.fromMap (Map <String, dynamic> map){
    return addressModel (
        address : map["address"] ?? "",
        name : map["name"] ?? "",
        number : map["number"]??"",
        location : map["location"] ?? "",
        pincode: map["pincode"]??"",
        deliveryinsruction: map["deliveryinsruction"]??""
    );
  }
  addressModel copyWith({
    String? address,name,number,landmark,houseno,pincode,deliveryinsruction
  }){
    return addressModel(
      address: address ?? this.address,
      name: name ?? this.name,
      number: number ?? this.number,
      location: location ?? this.location,
      pincode: pincode ?? this.pincode,
      deliveryinsruction:  deliveryinsruction ?? this.deliveryinsruction,
    );
  }

}


class addModel{
  List? address;
  addModel({required this.address});

  Map <String, dynamic> toMap(){
    return{
      "address" : this.address,
    };
  }
  factory addModel.fromMap (Map <String, dynamic> map){
    return addModel (
        address: map["address"] ?? [],
    );
  }
  addModel copyWith({
    List? address
  }){
    return addModel(
      address: address ?? this.address,
    );
  }

}