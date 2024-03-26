import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';

import '../../../main.dart';

class favouritePage extends StatefulWidget {
  const favouritePage({super.key});

  @override
  State<favouritePage> createState() => _favouritePageState();
}

class _favouritePageState extends State<favouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite",
        style: TextStyle(
          fontWeight: FontWeight.w800,

        ),),
        actions: [
          Container(child: SvgPicture.asset(iconConst.cart)),
          SizedBox(width: scrWidth*0.04,),
          Container(child: SvgPicture.asset(iconConst.notification)),
          SizedBox(width: scrWidth*0.04,),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.all(scrWidth*0.04),
        child: Column(
          children: [
            Container(
              // height: width*0.8,
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: 2,
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
                                image: DecorationImage(image: AssetImage(imageConst.beefcurrycut),fit: BoxFit.fill))
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
                                  Text("Beef Curry Cut(Large.)",
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SvgPicture.asset(iconConst.Favourite,color: colorConst.meroon,),
                            CircleAvatar(
                              radius: 11.5,
                              backgroundColor:colorConst.meroon ,
                              child: Icon(Icons.add,
                                color: colorConst.white,
                                size:scrWidth*0.04 ,),
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
