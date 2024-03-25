import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'main.dart';

class cartPage extends StatefulWidget {
  const cartPage({super.key});

  @override
  State<cartPage> createState() => _CartPageState();
}

class _CartPageState extends State<cartPage> {
  TextEditingController textController=TextEditingController();
  int count=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding:  EdgeInsets.all(w*0.03),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(w*0.08)
              ),
              child: Center(child: SvgPicture.asset("assets/icons/arrow.svg"))
          ),
        ),
        title: Text("My Cart",
        style: TextStyle(
          fontWeight: FontWeight.w800
        ),),
      ),
      body: Padding(
        padding:  EdgeInsets.all(w*0.028),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: width*0.8,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        height: w*0.35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                          borderRadius: BorderRadius.circular(w*0.04),
                          border: Border.all(width: w*0.0003),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(2, 4),
                                spreadRadius:1
                            )
                          ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(width: w*0.02,),
                            Container(
                              height: w*0.27,
                              width: w*0.27,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(w*0.04),
                                border: Border.all(width:w*0.0003),
                                image: DecorationImage(image: AssetImage("assets/images/beefcurrycut.png"),fit: BoxFit.fill))
                              ),
                            SizedBox(width: w*0.02,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: w*0.4,
                                  child: Column(
                                    children: [
                                      Text("Beef Curry Cut(Large.)",
                                        style: TextStyle(
                                            fontSize: w*0.04,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black
                                        ),),
                                      Text("Chuck, short ribs, skirt, flank"),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text("1 KG - ",
                                      style: TextStyle(
                                          fontSize: w*0.04,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black
                                      ),),
                                    Text("₹ 200",
                                      style: TextStyle(
                                          fontSize: w*0.04,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.brown
                                      ),),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: w*0.1,
                                  width: w*0.1,
                                     decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(w*0.05),
                                       boxShadow: [
                                         BoxShadow(
                                             color: Colors.grey,
                                             blurRadius: 2,
                                           offset: Offset(0, 4)
                                         )
                                       ]
                                     ),
                                     child: Center(child: SvgPicture.asset("assets/icons/trash.svg"))
                      ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        count++;
                                        setState(() {
          
                                        });
                                      },
                                      child: Container(
                                        height:w*0.07,
                                        width:w*0.07,
                                        decoration: BoxDecoration(
                                            color:Colors.black12,
                                            borderRadius: BorderRadius.circular(w*0.06),
                                            border: Border.all(width: w*0.0003)
                                        ),
                                        child:Icon(Icons.remove),
                                      ),
                                    ),
                                    SizedBox(width: w*0.015,),
                                    Text(count.toString(),
                                      style: TextStyle(
                                        fontSize: w*0.04,
                                        fontWeight: FontWeight.w600
                                      ),),
                                    SizedBox(width: w*0.015,),
                                    InkWell(
                                      onTap: () {
                                        count<=0? 0:count--;
                                        setState(() {
          
                                        });
                                      },
                                      child: Container(
                                          height:w*0.07,
                                          width:w*0.07,
                                          decoration: BoxDecoration(
                                            color:Colors.black12,
                                            borderRadius: BorderRadius.circular(w*0.06),
                                            border: Border.all(width: w*0.0003)
                                          ),
                                        child:Center(child: Icon(Icons.add)),
                                          ),
                                    )
                                  ],
          
                                ),
                              ],
                            ),
                            SizedBox(width: w*0.02,),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: w*0.05,);
                    },
                    ),
              ),
              Text("Order Summary",
                style:TextStyle(
                  fontSize:w*0.06,
                  fontWeight:FontWeight.w700,
                  color: Colors.brown
                ),),
              Text("Additional Note",
                style:TextStyle(
                  fontSize:w*0.05,
                  fontWeight:FontWeight.w700,
                  color: Colors.black
                ),),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(w*0.04),
                  border: Border.all(width: w*0.003)
                ),
                child: TextFormField(
                  controller: textController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    labelText: "Any instruction regarding cuts",
                    // border: OutlineInputBorder(
                    //     borderSide: B),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
