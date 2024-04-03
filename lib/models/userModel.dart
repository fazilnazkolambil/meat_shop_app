class UserModel{
  String? name, email, number, password, confirmPassword, id;
  List? homeAddress, officeAddress;
  UserModel({this.name, this.email, this.password, this.confirmPassword, this.number, this.id, this.homeAddress, this.officeAddress});

Map <String, dynamic> toMap(){
  return{
    "name" : this.name,
    "email" : this.email,
    "number" : this.number,
    "password" : this.password,
    "confirmPassword" : this.confirmPassword,
    "id" : this.id,
    "homeAddress" : this.homeAddress,
    "officeAddress" : this.officeAddress,
  };
}
 factory UserModel.fromMap (Map <String, dynamic> map){
  return UserModel (
    name : map["name"] ?? "",
    email : map["email"] ?? "",
    number : map["number"] ?? "",
    password : map["password"] ?? "",
    confirmPassword : map["confirmPassword"] ?? "",
    id : map["id"] ?? "",
    homeAddress: map["homeAddress"] ?? [],
    officeAddress: map["officeAddress"] ?? [],
  );
 }
UserModel copyWith({
  String? name, email, number, password, confirmPassword, id,
  List? homeAddress, officeAddress
}){
  return UserModel(
    name: name ?? this.name,
    email: email ?? this.email,
    number: number ?? this.number,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
    id: id ?? this.id,
    homeAddress: homeAddress ?? this.homeAddress,
    officeAddress: officeAddress ?? this.officeAddress,
  );
}

}