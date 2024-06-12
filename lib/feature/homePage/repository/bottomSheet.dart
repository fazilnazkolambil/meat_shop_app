import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/models/cartMeatModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../authPage/screens/info_page.dart';
import '../../authPage/screens/signin_page.dart';
import '../../ordersPage/screens/cart_page.dart';
import '../../ordersPage/screens/checkoutpage.dart';
import '../screens/meatList.dart';

 final counterProvider = StateNotifierProvider <CartMeatNotifier, CartMeatModel> ((ref) => CartMeatNotifier(CartMeatModel(
     name: '',
     image: '',
     description: '',
     category: '',
     id: '',
     ingredients: '',
     type: '',
     quantity: 0.0,
     qty: 0.0,
     rate: 0.0
 )));

final discount=0;
final shippingCharge=50;

class BottomSheetPage extends ConsumerWidget {
  final List data;
  final int index;
  final List meatDetailCollection;
  const BottomSheetPage({super.key,
    required this.data,
    required this.index,
    required this.meatDetailCollection,
  });
  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(meatDetailCollection);
    String jsonString2 = json.encode(addCart);
    prefs.setString("cart", jsonString);
    prefs.setString("cart2", jsonString2);
  }

  getSelectedMeat(){

    double meatQty = double.parse(data[index]['rate']);
    print(meatQty);
    // double meatmodel = CartMeatModel.fromMap(data[index]).qty;
    // print(meatmodel);
    // CartMeatModel CartMeatModel(
    //     name: data[index]['name'],
    //     image: data[index]['Image'],
    //     description: data[index]['description'],
    //     category: data[index]['category'],
    //     id: data[index]['id'],
    //     ingredients: data[index]['ingredients'],
    //     type: data[index]['type'],
    //     quantity: data[index]['quantity'],
    //     qty: data[index]['qty'],
    //     rate: data[index]['rate']
    // ).toMap();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

     final count = ref.watch(counterProvider);
     num meatRate = data[index]['rate'];
    return BottomSheet(
      onClosing: () {  },
      builder: (BuildContext context) {

        return Padding(
          padding: EdgeInsets.all(scrWidth*0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: scrWidth * 0.35,
                      width: scrWidth * 0.35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(scrWidth * 0.04),
                          border: Border.all(
                              width: scrWidth * 0.0003,
                              color: colorConst.black.withOpacity(0.38)),
                          image: DecorationImage(
                              image: NetworkImage(data[index]["Image"]),
                              fit: BoxFit.fill))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index]["name"],
                        style: TextStyle(
                            fontSize: scrWidth * 0.04,
                            fontWeight: FontWeight.w700,
                            color: colorConst.black),
                      ),
                      Row(
                        children: [
                          Text(
                            "1 KG - ",
                            style: TextStyle(fontSize: scrWidth * 0.04,
                                fontWeight: FontWeight.w700,
                                color: colorConst.black),
                          ),
                          Text(
                            "₹ ${data[index]["rate"]}",
                            style: TextStyle(
                                fontSize: scrWidth * 0.04,
                                fontWeight: FontWeight.w700,
                                color: colorConst.meroon),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                data[index]["description"],
                style: TextStyle(
                    color: colorConst.black.withOpacity(0.4)),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Total - ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorConst.black,
                                fontSize: scrWidth*0.05
                            ),
                          ),
                          TextSpan(
                              text:" ₹ ${meatRate * count.qty}/-",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: colorConst.meroon,
                                  fontSize: scrWidth*0.05
                              ))
                        ]
                    )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            count.qty <= 0.5 ? 0.5:
                            ref.read(counterProvider.notifier).updatecount(count.qty - 0.5);
                          },
                          child: CircleAvatar(
                            backgroundColor: colorConst.meroon,
                            radius: 15,
                            child: Icon(Icons.remove, size: 15,color: colorConst.white),
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: scrWidth*0.02),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                  //'',
                                  count.qty.toString(),
                                style: TextStyle(
                                    fontSize: scrWidth*0.05,
                                    fontWeight: FontWeight.bold,
                                    color: colorConst.black
                                ),
                              ),
                              TextSpan(
                                  text: " kg",
                                style: TextStyle(color: colorConst.black,fontSize: scrWidth*0.035)
                              )
                            ]
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                             ref.read(counterProvider.notifier).updatecount(count.qty + 0.5);
                          },
                          child: CircleAvatar(
                            backgroundColor: colorConst.meroon,
                            radius: 15,
                            child: Icon(Icons.add, size: 15,color: colorConst.white),
                          )),
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage(
                        price: meatRate * count.qty,
                        discount: discount.toDouble(),
                        shippingCharge: shippingCharge.toDouble(),
                        subtotal:(meatRate * count.qty)+shippingCharge.toDouble(),
                        cartMeat:[CartMeatModel(
                          name: data[index]["name"],
                              image: data[index]['Image'],
                              description: data[index]["description"],
                              category: data[index]['category'],
                              id: data[index]['id'],
                              ingredients: data[index]['ingredients'],
                              type: data[index]['type'],
                              quantity: count.quantity,
                              qty: count.qty,
                              rate: meatRate * count.qty
                        ).toMap()],
                        notes: '',
                      )));
                    },
                    child: Container(
                      height: scrHeight * 0.05,
                      width: scrWidth * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(scrWidth * 0.03),
                          border: Border.all(color: colorConst.meroon)),
                      child: Center(child: Text("Buy Now"),
                      ),
                    ),
                  ),
                  addCart.contains(data[index]["id"]) ?
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => cartPage()));
                    },
                    child:
                    Container(
                      height: scrHeight * 0.05,
                      width: scrWidth * 0.4,
                      decoration: BoxDecoration(
                          color: colorConst.meroon,
                          borderRadius: BorderRadius.circular(scrWidth * 0.03),
                          border: Border.all(color: colorConst.meroon)),
                      child: Center(
                        child: Text("Go to Cart", style: TextStyle(
                              color: colorConst.white),
                        ),
                      ),
                    ),
                  )
                      : InkWell(
                    onTap: () {
                      if (addCart.contains(data[index]["id"])) {
                        addCart.remove(data[index]["id"]);
                        meatDetailCollection.removeWhere((element) => element["id"] == data[index]["id"]);
                        saveData();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item removed from the Cart!")));
                      } else {
                        addCart.add(data[index]["id"]);
                        meatDetailCollection.add({
                          // "category": selectedCategory == "" ? categoryCollection[0]["category"]
                          //     : selectedCategory,
                          'category' : data[index]['category'],
                          "type": data[index]['type'],
                          "id": data[index]["id"],
                        });
                        saveData();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item added to the Cart!")));
                      }
                      Navigator.pop(context);
                    },
                    child:
                    Container(
                      height: scrHeight * 0.05,
                      width: scrWidth * 0.4,
                      decoration: BoxDecoration(
                          color: colorConst.meroon,
                          borderRadius: BorderRadius.circular(scrWidth * 0.03),
                          border: Border.all(color: colorConst.meroon)),
                      child: Center(
                          child: Text("Add to Cart",
                              style: TextStyle(color: colorConst.white))),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

