import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';

import '../../../main.dart';

class MuttonList extends StatefulWidget {
  const MuttonList({super.key});

  @override
  State<MuttonList> createState() => _MuttonListState();
}

class _MuttonListState extends State<MuttonList> {
  List muttonMeet = ["Mutton Cut", "Boneless Mutton", "Liver", "Bottie"];
  int selectIndex = 0;
  String selectCategory = '';
  int count=1;
  List mutton=[
    {
      "image":"assets/images/muttoncurrycut.jpg",
      "name":"Mutton Curry Cut(Large.)",
      "price":"₹ 750"
    },
    {
      "image":"assets/images/muttonfrycut.jpg",
      "name":"Mutton Fry Cut ( Larg.",
      "price":"₹ 780"
    },
    {
      "image":"assets/images/muttonbigpiece.jpg",
      "name":"Mutton Big Pice",
      "price":"₹ 760"
    },
    {
      "image":"assets/images/muttonmedium.jpg",
      "name":"Mutton Medium Pice",
      "price":"₹ 730"
    },
    {
      "image":"assets/images/lambbiriyanicut.jpg",
      "name":"Biriyani Cut",
      "price":"₹ 250"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConst.white,
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
        padding: EdgeInsets.all(scrWidth*0.05),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mutton Meat",
              style: TextStyle(
                  fontSize: scrWidth*0.07,
                  fontWeight: FontWeight.w700,
                  color:Colors.black
              ),),
            Container(
                height: scrHeight * 0.08,
                width: scrWidth * 1,
                child: ListView.builder(
                  itemCount: muttonMeet.length,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        selectIndex = index;
                        selectCategory=muttonMeet[index];
                        // if(selectCategory=="All"){
                        //   selectCategory="";
                        // }
                        setState(() {});
                      },
                      child: Container(
                          height: scrHeight * 0.07,
                          // width: width*0.35,
                          // color: Colors.red,
                          padding: EdgeInsets.only(
                              left: scrWidth * 0.02,
                              right: scrWidth * 0.02),
                          margin: EdgeInsets.all(scrWidth * 0.02),
                          decoration: BoxDecoration(
                              color: selectIndex == index
                                  ? colorConst.yellow
                                  : Colors.white,
                              border: Border.all(
                                  color: selectIndex==index?colorConst.yellow: colorConst.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(
                                  scrWidth * 0.07)),
                          child: Center(
                              child: Text(

                                muttonMeet[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                    fontSize: scrWidth*0.04,
                                    color: selectIndex == index
                                        ? colorConst.black
                                        : colorConst.textgrey
                                ),
                              )
                          )
                      ),
                    );
                  },
                )
            ),
            SizedBox(height: scrWidth*0.05,),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: mutton.length,
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
                                image: DecorationImage(image: AssetImage(mutton[index]["image"]),fit: BoxFit.fill)
                            )
                        ),
                        SizedBox(width: scrWidth*0.02,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: scrWidth*0.4,
                              child: Column(
                                children: [
                                  Text(mutton[index]["name"],
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
                                Text(mutton[index]["price"],
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
                            SvgPicture.asset(iconConst.Favourite1,),
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
                                                        image: DecorationImage(image: AssetImage(imageConst.muttoncurrycut),fit: BoxFit.fill))
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: scrWidth*0.37,
                                                      child: Column(
                                                        children: [
                                                          Text("Mutton Curry Cut (Large piece)",
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
                                                        Text("₹ 750",
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
                                                Text("₹  750.00",
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
    );
  }
}
