class addressModel{
  String? address,name,number,landmark,houseno,pincode;
  addressModel({
    required this.name,
    required this.number,
    required this.address,
    required this.landmark,
    required this.houseno,
    required this.pincode});

  Map <String, dynamic> toMap(){
    return{
      "address" : this.address,
      "name" : this.name,
      "number" : this.number,
      "landmark" : this.landmark,
      "houseno" : this.houseno,
      "pincode" : this.pincode,
    };
  }
  factory addressModel.fromMap (Map <String, dynamic> map){
    return addressModel (
        address : map["address"] ?? "",
        name : map["name"] ?? "",
        number : map["number"]??"",
        landmark : map["landmark"] ?? "",
        houseno: map["houseno"] ?? "",
        pincode: map["pincode"]??""
    );
  }
  addressModel copyWith({
    String? address,name,number,landmark,houseno,pincode
  }){
    return addressModel(
      address: address ?? this.address,
      name: name ?? this.name,
      number: number ?? this.number,
      landmark: landmark ?? this.landmark,
      houseno: houseno ?? this.houseno,
      pincode: pincode ?? this.pincode,
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