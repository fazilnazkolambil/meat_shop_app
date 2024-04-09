import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/main.dart';

class LambPage extends StatefulWidget {
  final String type;
  const LambPage({super.key, required this.type});

  @override
  State<LambPage> createState() => _LambPageState();
}

class _LambPageState extends State<LambPage> {
  List categoryCollection = [];
  getMeats() async {
    var meats = await FirebaseFirestore.instance.collection("meatTypes").doc(widget.type).collection(widget.type).get();
    categoryCollection = meats.docs;
    setState(() {

    });
  }
  int selectedIndex = 0;
  @override
  void initState() {
    getMeats();
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.all(scrWidth*0.04),
            child: CircleAvatar(
              backgroundColor: colorConst.grey1,
              child: Icon(CupertinoIcons.back,size: scrWidth*0.04,),
            ),
          ),
          title: Row(
            children: [
              SvgPicture.asset(iconConst.location),
              SizedBox(width: scrWidth*0.02,),
              Text("kuwait City, Kuwait",style: TextStyle(
                fontSize: scrWidth*0.04
              ),),
            ],
          ),
          actions: [
            SvgPicture.asset(iconConst.cart),
            SizedBox(width: scrWidth*0.04,),
            SvgPicture.asset(iconConst.notification),
            SizedBox(width: scrWidth*0.04,),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(scrWidth*0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.type,style: TextStyle(
                fontSize: scrWidth*0.05,
                fontWeight: FontWeight.w700
              ),),
              SizedBox(
                height: scrHeight*0.04,
                width: scrWidth*1,
                child: ListView.separated(
                  itemCount: categoryCollection.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                      },
                      child: Container(
                        height: scrHeight*0.05,
                        padding: EdgeInsets.only(left: scrWidth*0.04,right: scrWidth*0.04),
                        child: Center(
                          child: Text(categoryCollection[index]["category"],
                            style: TextStyle(
                                color:colorConst.white,
                                fontWeight: FontWeight.w600
                            ),),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(scrWidth*0.05),
                            color: colorConst.meroon,
                            border: Border.all(
                              color:colorConst.meroon,
                            )
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: scrWidth*0.03,
                    );
                  },

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
