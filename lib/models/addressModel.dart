class addressModel{
  String? name, number, location, pincode, deliveryInstruction, buildingName, street, town, type;
  addressModel({
    required this.name,
    required this.number,
    required this.location,
    required this.pincode,
    required this.deliveryInstruction,
    required this.buildingName,
    required this.street,
    required this.town,
    required this.type,
  });

  Map <String, dynamic> toMap(){
    return{
      "name" : this.name,
      "number" : this.number,
      "location" : this.location,
      "pincode" : this.pincode,
      "deliveryInstruction" : this.deliveryInstruction,
      "buildingName":this.buildingName,
      "street":this.street,
      "town":this.town,
      "type":this.type,
    };
  }
  factory addressModel.fromMap (Map <String, dynamic> map){
    return addressModel (
        name : map["name"] ?? "",
        number : map["number"]??"",
        location : map["location"] ?? "",
        pincode: map["pincode"]??"",
        deliveryInstruction: map["deliveryInstruction"]??"",
      buildingName: map['buildingName']?? '',
      street: map['street']?? '',
      town: map['town']?? '',
      type: map['type']?? '',
    );
  }
  addressModel copyWith({
    String? name,number,landmark,houseno,pincode,deliveryInstruction,buildingName,street,town, type,

  }){
    return addressModel(
      name: name ?? this.name,
      number: number ?? this.number,
      location: location ?? this.location,
      pincode: pincode ?? this.pincode,
      deliveryInstruction: deliveryInstruction ?? this.deliveryInstruction,
      buildingName: buildingName ?? this.buildingName,
      street: street ?? this.street,
      town: town ?? this.town,
      type: type ?? this.type,
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