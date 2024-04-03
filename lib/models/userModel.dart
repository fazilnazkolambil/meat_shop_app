class UserModel{
  String? name, email, number, password;
  List? address, favourites;
  UserModel({required this.name,required this.email,required this.password,required this.number,required this.address,required this.favourites});

Map <String, dynamic> toMap(){
  return{
    "name" : this.name,
    "email" : this.email,
    "number" : this.number,
    "password" : this.password,
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
    address: address ?? this.address,
    favourites: favourites ?? this.favourites,
  );
}

}