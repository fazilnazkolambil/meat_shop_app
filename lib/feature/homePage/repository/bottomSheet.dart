// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:meat_shop_app/feature/ordersPage/screens/cart_page.dart';
// import 'package:meat_shop_app/main.dart';
// import 'package:meat_shop_app/core/constant/color_const.dart';
//
// import '../screens/meatList.dart';
//
//
// class BottomSheetPage extends StatefulWidget {
//   final List<QueryDocumentSnapshot<Map<String, dynamic>>> data;
//   final int index;
//   const BottomSheetPage({super.key, required this.data, required this.index});
//
//   @override
//   State<BottomSheetPage> createState() => _BottomSheetPageState();
// }
//
// class _BottomSheetPageState extends State<BottomSheetPage> {
//   List<QueryDocumentSnapshot<Map<String, dynamic>>> data =[];
//   int index = 0;
//
//   @override
//   void initState() {
//     data = widget.data;
//     index = widget.index;
//
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return    Padding(
//       padding: EdgeInsets.all(scrWidth * 0.06),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                   height: scrWidth * 0.34,
//                   width: scrWidth * 0.34,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(scrWidth * 0.04),
//                       border: Border.all(
//                           width: scrWidth * 0.0003,
//                           color: colorConst.black.withOpacity(0.38)),
//                       image: DecorationImage(
//                           image: NetworkImage(data[index]["Image"]), fit: BoxFit.fill))),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     data[index]["name"],
//                     style: TextStyle(
//                         fontSize: scrWidth * 0.04,
//                         fontWeight: FontWeight.w700,
//                         color: colorConst.black),
//                   ),
//                   Row(
//
//                     children: [
//                       Text(
//                         "1 KG - ", style: TextStyle(
//                           fontSize: scrWidth * 0.04,
//                           fontWeight: FontWeight.w700,
//                           color: colorConst.black),
//                       ),
//                       Text(
//                         "₹ ${data[index]["rate"]}", style: TextStyle(
//                           fontSize: scrWidth * 0.04,
//                           fontWeight: FontWeight.w700,
//                           color: colorConst.meroon),
//                       ),
//                     ],
//                   ),
//
//                 ],
//               ),
//
//             ],
//           ),
//           Text(
//             data[index]["description"],
//             style: TextStyle(
//                 color: colorConst.black
//                     .withOpacity(0.4)),
//           ),
//           Divider(),
//           addCart.contains(data[index]["id"])?
//           InkWell(
//             onTap: () {
//               setState(() {
//
//               });
//               // Navigator.push(context, MaterialPageRoute(builder: (context) => cartPage(),));
//             },
//             child: Container(
//               height: scrWidth*0.15,
//               width: scrWidth*0.9,
//               decoration: BoxDecoration(
//                 color: colorConst.meroon,
//                 borderRadius: BorderRadius.circular(scrWidth*0.05),
//               ),
//               child: Center(child: Text("Go to Cart",
//                 style: TextStyle(
//                     color: colorConst.white
//                 ),)),
//             ),
//           )
//               :Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 height: scrHeight*0.05,
//                 width: scrWidth*0.4,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(scrWidth*0.03),
//                     border: Border.all(color: colorConst.meroon)
//                 ),
//                 child: Center(child: Text("Buy Now"),),
//               ),
//               InkWell(
//                 onTap: () {
//                   if(addCart.contains(data[index]["id"])){
//                     addCart.remove(data[index]["id"]);
//                     meatDetailCollection.remove(meatDetailCollection[index]);
//                   }else{
//                     addCart.add(data[index]["id"]);
//                     meatDetailCollection.add({
//                       "Image" : data[index]["Image"],
//                       "name" : data[index]["name"],
//                       "ingredients" : data[index]["ingredients"],
//                       "rate" : data[index]["rate"],
//                       "quantity" : 1
//                     });
//                   }
//                   setState(() {
//
//                   });
//                 },
//                 child: Container(
//                   height: scrHeight*0.05,
//                   width: scrWidth*0.4,
//                   decoration: BoxDecoration(
//                       color: colorConst.meroon,
//                       borderRadius: BorderRadius.circular(scrWidth*0.03),
//                       border: Border.all(color: colorConst.meroon)
//                   ),
//                   child: Center(child: Text("Add to Cart",style: TextStyle(
//                       color: colorConst.white
//                   ),),),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//
//   }
// }
