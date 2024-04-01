import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/main.dart';

class CamelList extends StatefulWidget {
  const CamelList({super.key});

  @override
  State<CamelList> createState() => _CamelListState();
}

class _CamelListState extends State<CamelList> {
  int selectIndex=0;
  int count=1;
  List camelmeat=[
    "Camel cut", "Boneless ", "Liver","Leg cut"
  ];
  List camel=[
    {
      "image":"assets/images/camelfrycut.jpg",
      "name":"Camel Fry Cut ( Larg.",
      "price":"₹ 350"
    },
    {
      "image":"assets/images/camelbigpiece.jpg",
      "name":" Camel Big Pice",
      "price":"₹ 500"
    },
    {
      "image":"assets/images/camel mince.jpg",
      "name":" Camel Mince",
      "price":"₹ 500"
    },
    {
      "image":"assets/images/camelmediumcut.jpg",
      "name":"Camel Medium Pice",
      "price":"₹ 630"
    },
    {
      "image":"assets/images/camelbiriyanicut.jpeg",
      "name":"Biriyani Cut",
      "price":"₹ 600"
    },
  ];
  List favourite=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding:  EdgeInsets.all(scrWidth*0.05),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Camel",
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
                    itemCount:camelmeat.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectIndex=index;
                          });
                        },
                        child: Container(
                          height: scrHeight*0.05,
                          padding: EdgeInsets.only(left: scrWidth*0.04,right: scrWidth*0.04),
                          child: Center(
                            child: Text(camelmeat[index],
                              style: TextStyle(
                                  color: selectIndex==index? colorConst.black:colorConst.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w600
                              ),),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(scrWidth*0.05),
                              color: selectIndex==index? colorConst.yellow:colorConst.white,
                              border: Border.all(
                                color: selectIndex==index? colorConst.yellow:colorConst.black.withOpacity(0.5),
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
              Container(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: camel.length,
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
                                  image: DecorationImage(image: AssetImage(camel[index]["image"]),fit: BoxFit.cover))
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
                                    Text(camel[index]["name"],
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
                                  Text(camel[index]["price"],
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
                                valueChanged: (_) {

                                },
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
                                                          image: DecorationImage(image: AssetImage(imageConst.camelfrycut),fit: BoxFit.fill))
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: scrWidth*0.37,
                                                        child: Column(
                                                          children: [
                                                            Text("camel fry Cut (Large piece)",
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
                                                          Text("₹ 350",
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
                                                  Text("₹  350.00",
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
                                              Container(
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
                  separatorBuilder: (context, index) {
                    return SizedBox(height: scrWidth*0.03,);
                  },
                ),
              ),






            ],
          ),
        ),
      ),

    );
  }
}
