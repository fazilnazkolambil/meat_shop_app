class UserModel{
  String? name, email, number, password, confirmPassword, id;
  List? address, favourites;
  UserModel({this.name, this.email, this.password, this.confirmPassword, this.number, this.id, this.address, this.favourites});

Map <String, dynamic> toMap(){
  return{
    "name" : this.name,
    "email" : this.email,
    "number" : this.number,
    "password" : this.password,
    "confirmPassword" : this.confirmPassword,
    "id" : this.id,
    "address" : this.address,
    "favourites" : this.favourites,
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
    address: map["address"] ?? [],
    favourites: map["favourites"] ?? [],
  );
 }
UserModel copyWith({
  String? name, email, number, password, confirmPassword, id,
  List? homeAddress, favourites
}){
  return UserModel(
    name: name ?? this.name,
    email: email ?? this.email,
    number: number ?? this.number,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
    id: id ?? this.id,
    address: address ?? this.address,
    favourites: favourites ?? this.favourites,
  );
}

}