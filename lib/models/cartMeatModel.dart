import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartMeatModel {
  final String name;
  final String image;
  final String description;
  final String category;
  final String id;
  final String ingredients;
  final String type;
  final double quantity;
  final double qty;
  final double rate;
  CartMeatModel({
    required this.name,
    required this.image,
    required this.description,
    required this.category,
    required this.id,
    required this.ingredients,
    required this.type,
    required this.quantity,
    required this.qty,
    required this.rate,
});
  Map <String,dynamic> toMap(){
    return {
      "name" : this.name,
      "image" : this.image,
      "description" : this.description,
      "category" : this.category,
      "id" : this.id,
      "ingredients" : this.ingredients,
      "type" : this.type,
      "quantity" : this.quantity,
      "qty" : this.qty,
      "rate" : this.rate,
    };
  }
  factory CartMeatModel.fromMap (Map <String,dynamic> map){
    return CartMeatModel(
        name: map['name'] ?? '',
        image: map['image'] ?? '',
        description: map['description'] ?? '',
        category: map['category'] ?? '',
        id: map['id'] ?? '',
        ingredients: map['ingredients'] ?? '',
        type: map['type'] ?? '',
        quantity: map['quantity'].toDouble() ?? 0.0,
        qty: map['qty'].toDouble() ?? 0.0,
        rate: map['rate'].toDouble() ?? 0.0
    );
  }
  CartMeatModel copyWith({
    String? name, image, description, category, id, ingredients, type,
    double? quantity, qty, rate,
}){
    return CartMeatModel(
        name: name ?? this.name,
        image: image ?? this.image,
        description: description ?? this.description,
        category: category ?? this.category,
        id: id ?? this.id,
        ingredients: ingredients ?? this.ingredients,
        type: type ?? this.type,
        quantity: quantity ?? this.quantity,
        qty: qty ?? this.qty,
        rate: rate ?? this.rate
    );
  }
}

class CartMeatNotifier extends StateNotifier <CartMeatModel> {
  CartMeatNotifier(super.state);

void update(CartMeatModel cartmeat){
  state=state.copyWith(
      qty: cartmeat.qty,
      type: cartmeat.type,
      category: cartmeat.category,
      name: cartmeat.name,
      image: cartmeat.image,
      id: cartmeat.id,
      description: cartmeat.description,
      ingredients: cartmeat.ingredients,
      quantity: cartmeat.quantity,
      rate: cartmeat.rate
  );
}
  void updatecount(double count){
    state=state.copyWith(qty: count);
  }
}