class UserModel{
  String? name, email, number, password, confirmPassword, id;
  UserModel({this.name, this.email, this.password, this.confirmPassword, this.number, this.id});

Map <String, dynamic> toMap(){
  return{
    "name" : this.name,
    "email" : this.email,
    "number" : this.number,
    "password" : this.password,
    "confirmPassword" : this.confirmPassword,
    "id" : this.id,
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
  );
 }
UserModel copyWith({
  String? name, email, number, password, confirmPassword, id
}){
  return UserModel(
    name: name ?? this.name,
    email: email ?? this.email,
    number: number ?? this.number,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
    id: id ?? this.id,
  );
}

}