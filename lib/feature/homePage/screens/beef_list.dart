import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/checkoutpage.dart';

import '../../../main.dart';

class BeefList extends StatefulWidget {
  const BeefList({super.key});

  @override
  State<BeefList> createState() => _BeefListState();
}

class _BeefListState extends State<BeefList> {
  int selectIndex=0;
  int count=1;
  List cart=[];
  List favourite=[];
  List beefmeat=[
    "Beef cut", "Boneless Beef", "Liver", "Botti"
  ];
  List beef=[
    {
      "image":"assets/images/beefcurrycut.png",
      "name":"Beef Curry Cut(Large.)",
      "price":"₹ 250"
    },
    {
      "image":"assets/images/beeffrycut.png",
      "name":"Beef Fry Cut ( Larg.",
      "price":"₹ 280"
    },
    {
      "image":"assets/images/beefbigpiece.png",
      "name":"Beef Big Pice",
      "price":"₹ 280"
    },
    {
      "image":"assets/images/beefmediumpiece.png",
      "name":"Beef Medium Pice",
      "price":"₹ 230"
    },
    {
      "image":"assets/images/beefbiriyanicut.png",
      "name":"Biriyani Cut",
      "price":"₹ 250"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding:  EdgeInsets.all(scrWidth*0.03),
            child: Container(
                decoration: BoxDecoration(
                    color: colorConst.grey1,
                    borderRadius: BorderRadius.circular(scrWidth*0.08)
                ),
                child: Center(child: SvgPicture.asset(iconConst.backarrow))
            ),
          ),
          title: Row(
            children: [
              SvgPicture.asset(iconConst.location),
              SizedBox(width: scrWidth*0.02,),
              Text("Kuwait City, Kuwait",
              style: TextStyle(
                fontSize: scrWidth*0.04,
                color: colorConst.black
              ),)
            ],
          ),
          actions: [
            SvgPicture.asset(iconConst.cart),
            SizedBox(width: scrWidth*0.04,),
            SvgPicture.asset(iconConst.notification),
            SizedBox(width: scrWidth*0.03,),
          ],
        ),
          bottomNavigationBar:cart.isNotEmpty? Container(
            height: scrWidth*0.37,
            decoration: BoxDecoration(
                color: colorConst.white,
                borderRadius: BorderRadius.circular(scrWidth*0.07),
                boxShadow: [
                  BoxShadow(
                      color: colorConst.black.withOpacity(0.2),
                      blurRadius: 54,
                      offset: Offset(0, -16),
                      spreadRadius: 0
                  )
                ]
            ),
            child: Padding(
              padding:  EdgeInsets.all(scrWidth*0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal",
                        style: TextStyle(
                            color: colorConst.black,
                            fontSize: scrWidth*0.05,
                            fontWeight: FontWeight.w700
                        ),),
                      Text("₹ 300.00",
                        style: TextStyle(
                            color: colorConst.meroon,
                            fontSize: scrWidth*0.05,
                            fontWeight: FontWeight.w700
                        ),)
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => checkoutpage(),));
                    },
                    child: Container(
                      height: scrWidth*0.15,
                      width: scrWidth*0.9,
                      decoration: BoxDecoration(
                        color: colorConst.meroon,
                        borderRadius: BorderRadius.circular(scrWidth*0.05),
                      ),
                      child: Center(child: Text("Proceed  To checkout",
                        style: TextStyle(
                            color: colorConst.white
                        ),)),
                    ),
                  )
                ],
              ),
            ),
          ) :SizedBox(),
          body:Padding(
            padding:  EdgeInsets.all(scrWidth*0.05),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Beef",
                    style: TextStyle(
                        fontSize: scrWidth*0.07,
                        fontWeight: FontWeight.w700,
                        color:Colors.black
                    ),),
                  SizedBox(height: scrWidth*0.02,),
                  SizedBox(
                      height: scrHeight*0.05,
                      width: scrWidth*1,
                      child:ListView.separated(
                        itemCount:beefmeat.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectIndex=index;
                              });
                            },
                            child: Container(
                              height: scrHeight*0.05,
                              padding: EdgeInsets.only(left: scrWidth*0.04,right: scrWidth*0.04),
                              child: Center(
                                child: Text(beefmeat[index],
                                  style: TextStyle(
                                      color: selectIndex==index? colorConst.white:colorConst.black.withOpacity(0.5),
                                      fontWeight: FontWeight.w600
                                  ),),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(scrWidth*0.05),
                                  color: selectIndex==index? colorConst.meroon:colorConst.white,
                                  border: Border.all(
                                      color: selectIndex==index? colorConst.meroon:colorConst.black.withOpacity(0.5),
                                  )
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: scrWidth*0.02,
                          );
                        },
              
                      )
                  ),
                  SizedBox(height: scrWidth*0.05,),
                 selectIndex == 0? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: beef.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: scrWidth*0.33,
                        decoration: BoxDecoration(
                            color: colorConst.white,
                            borderRadius: BorderRadius.circular(scrWidth*0.04),
                            border: Border.all(
                                width: scrWidth*0.0003,
                                color: colorConst.black.withOpacity(0.38)),
                            boxShadow: [
                              BoxShadow(
                                  color: colorConst.black.withOpacity(0.1),
                                  blurRadius: 14,
                                  offset: Offset(0, 4),
                                  spreadRadius:0
                              )
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(width: scrWidth*0.02,),
                            Container(
                                height: scrWidth*0.27,
                                width: scrWidth*0.27,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(scrWidth*0.04),
                                    border: Border.all(
                                        width: scrWidth*0.0003,
                                        color: colorConst.black.withOpacity(0.38)),
                                    image: DecorationImage(image: AssetImage(beef[index]["image"]),fit: BoxFit.fill))
                            ),
                            SizedBox(width: scrWidth*0.02,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: scrWidth*0.4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(beef[index]["name"],
                                        style: TextStyle(
                                            fontSize: scrWidth*0.04,
                                            fontWeight: FontWeight.w700,
                                            color: colorConst.black
                                        ),),
                                      Text("Chuck, short ribs, skirt, flank"),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("1 KG - ",
                                      style: TextStyle(
                                          fontSize: scrWidth*0.04,
                                          fontWeight: FontWeight.w700,
                                          color: colorConst.black
                                      ),),
                                    Text(beef[index]["price"],
                                      style: TextStyle(
                                          fontSize: scrWidth*0.04,
                                          fontWeight: FontWeight.w700,
                                          color: colorConst.meroon
                                      ),),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FavoriteButton(
                                  valueChanged: (isFavorite) {
                                    if(isFavorite){
                                      favourite.add(beef[index]);
                                      print(favourite);
                                    }else{
                                      favourite.remove(beef[index]);
                                    }
                                  },
                                  isFavorite: false,
                                  iconSize: 39,
                                  iconColor: colorConst.meroon,
                                ),
                                // SvgPicture.asset(iconConst.Favourite,color: favourite.contains(index)?colorConst.meroon:colorConst.grey,),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: colorConst.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(scrWidth*0.07),
                                            topRight: Radius.circular(scrWidth*0.07),
                                          )
                                      ),
                                      builder: (context) {
                                        return Padding(
                                          padding:  EdgeInsets.all(scrWidth*0.06),
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Container(
                                                        height: scrWidth*0.34,
                                                        width: scrWidth*0.34,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(scrWidth*0.04),
                                                            border: Border.all(
                                                                width: scrWidth*0.0003,
                                                                color: colorConst.black.withOpacity(0.38)),
                                                            image: DecorationImage(image: AssetImage(imageConst.beefcurrycut),fit: BoxFit.fill))
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: scrWidth*0.37,
                                                          child: Column(
                                                            children: [
                                                              Text("Beef Curry Cut (Large piece)",
                                                                style: TextStyle(
                                                                    fontSize: scrWidth*0.04,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: colorConst.black
                                                                ),),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(height: scrWidth*0.02,),
                                                        Row(
                                                          children: [
                                                            Text("1 KG - ",
                                                              style: TextStyle(
                                                                  fontSize: scrWidth*0.04,
                                                                  fontWeight: FontWeight.w700,
                                                                  color: colorConst.black
                                                              ),),
                                                            Text("₹ 250",
                                                              style: TextStyle(
                                                                  fontSize: scrWidth*0.04,
                                                                  fontWeight: FontWeight.w700,
                                                                  color: colorConst.meroon
                                                              ),),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Text("Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Nullam quis risus eget urna mollis ornare vel eu leo.",
                                                  style: TextStyle(
                                                      color: colorConst.black.withOpacity(0.4)
                                                  ),),
                                                Divider(),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("₹  250.00",
                                                      style: TextStyle(
                                                          fontSize: scrWidth*0.04,
                                                          fontWeight: FontWeight.w700,
                                                          color: colorConst.meroon
                                                      ),),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            count<=0? 0:count--;
                                                            setState(() {

                                                            });
                                                          },
                                                          child: Container(
                                                            height:scrWidth*0.065,
                                                            width:scrWidth*0.065,
                                                            decoration: BoxDecoration(
                                                                color:colorConst.grey1,
                                                                borderRadius: BorderRadius.circular(scrWidth*0.06),
                                                                border: Border.all(
                                                                    width: scrWidth*0.0003,
                                                                    color: colorConst.black.withOpacity(0.38)
                                                                )
                                                            ),
                                                            child:Icon(Icons.remove,
                                                                size:scrWidth*0.04),
                                                          ),
                                                        ),
                                                        SizedBox(width: scrWidth*0.015,),
                                                        Text(count.toString(),
                                                          style: TextStyle(
                                                              fontSize: scrWidth*0.04,
                                                              fontWeight: FontWeight.w600
                                                          ),),
                                                        SizedBox(width: scrWidth*0.015,),
                                                        InkWell(
                                                          onTap: () {
                                                            count++;
                                                            setState(() {

                                                            });
                                                          },
                                                          child: Container(
                                                            height:scrWidth*0.065,
                                                            width:scrWidth*0.065,
                                                            decoration: BoxDecoration(
                                                                color:colorConst.grey1,
                                                                borderRadius: BorderRadius.circular(scrWidth*0.06),
                                                                border: Border.all(
                                                                    width: scrWidth*0.0003,
                                                                    color: colorConst.black.withOpacity(0.38)
                                                                )
                                                            ),
                                                            child:Center(child: Icon(Icons.add,
                                                                size:scrWidth*0.04)),
                                                          ),
                                                        )
                                                      ],

                                                    ),

                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    cart.add(beef[index]);
                                                    Navigator.pop(context);
                                                    print(cart);
                                                  },
                                                  child: Container(
                                                    height: scrHeight*0.07,
                                                    width: scrWidth*0.9,
                                                    decoration: BoxDecoration(
                                                        color: colorConst.meroon,
                                                        borderRadius: BorderRadius.circular(scrWidth*0.05)
                                                    ),
                                                    child: Center(
                                                      child: Text("Add To Cart",
                                                        style: TextStyle(
                                                          color: colorConst.white,

                                                        ),),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },);
                                  },
                                  child: CircleAvatar(
                                    radius: 11.5,
                                    backgroundColor:colorConst.meroon ,
                                    child: Icon(Icons.add,
                                      color: colorConst.white,
                                      size:scrWidth*0.04 ,),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: scrWidth*0.02,),
                          ],
                        ),
                      );
                    },
                  )
                     :selectIndex == 1?SizedBox(
                   child: Text("2"),
                 )
                     :selectIndex == 2?SizedBox(
                   child: Text("3"),
                 )
                     :SizedBox(
                   child: Text("4"),
                 )
                ],
              ),
            ),
          )
      ),
    );
  }
}
