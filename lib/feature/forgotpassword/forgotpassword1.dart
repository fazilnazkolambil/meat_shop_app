import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/forgotpassword/forgotpassword2.dart';
import 'package:meat_shop_app/main.dart';

class forgotpasswordpage1 extends StatefulWidget {
  const forgotpasswordpage1({super.key});

  @override
  State<forgotpasswordpage1> createState() => _forgotpasswordpage1State();
}

class _forgotpasswordpage1State extends State<forgotpasswordpage1> {
  bool border1=false;
  bool border2=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(child: SvgPicture.asset(iconConst.backarrow,height: scrWidth*0.1,width: scrWidth*0.1,))),
        title: Text("Forgot password",style: TextStyle(fontWeight: FontWeight.w700,color: colorConst.black,fontSize: scrWidth*0.05),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(child: Image(image: AssetImage(imageConst.padlock),)),
          Padding(
            padding: EdgeInsets.only(left: scrWidth*0.045),
            child: Text("Select which contact details should we use to reset your password",style: TextStyle(fontWeight: FontWeight.w500,fontSize: scrWidth*0.04),),
          ),
          InkWell(
            onTap: () {
              border1=true;
              border2=false;

              setState(() {

              });
            },
            child: Container(
              height: scrWidth*0.24,
              width: scrWidth*0.87,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(scrWidth*0.04),
                  border: Border.all(
                      color:border1==true?colorConst.meroon:colorConst.grey,
                      width: border1==true?scrWidth*0.006:scrWidth*0.003
                  )
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: scrWidth*0.06,
                  ),
                  CircleAvatar(
                    backgroundColor: colorConst.grey,
                    radius: scrWidth*0.07,
                    child: Icon(Icons.sms,color: colorConst.meroon,),
                  ),
                  SizedBox(
                    width: scrWidth*0.06,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: scrWidth*0.1),
                        child: Text("via SMS:",style: TextStyle(color: colorConst.grey1,fontWeight: FontWeight.w600),),
                      ),
                      Text("+234111******99",style: TextStyle(color: colorConst.black,fontWeight: FontWeight.w400),),
                    ],
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              border1=false;
              border2=true;
              setState(() {

              });
            },
            child: Container(
              height: scrWidth*0.24,
              width: scrWidth*0.87,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(scrWidth*0.04),
                  border: Border.all(
                      color:border2==true?colorConst.meroon:colorConst.grey,
                      width: border2==true?scrWidth*0.006:scrWidth*0.003
                  )
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: colorConst.grey,
                    radius: scrWidth*0.07,
                    child: Icon(Icons.mail_outline_outlined,color: colorConst.meroon,),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:EdgeInsets.only(right: scrWidth*0.33),
                        child: Text("via Email:",style: TextStyle(color: colorConst.grey1,fontWeight: FontWeight.w600),),
                      ),
                      Text("kez***9@your domain.com",style: TextStyle(color: colorConst.black,fontWeight: FontWeight.w400),),
                    ],
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => forgotpasswordpage2(),));
            },
            child: Container(
              height: scrWidth*0.18,
              width: scrWidth*0.88,
              decoration: BoxDecoration(
                color: colorConst.meroon,
                borderRadius: BorderRadius.circular(scrWidth*0.2),
                boxShadow:[
                  BoxShadow(
                    color: colorConst.black.withOpacity(0.25),
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                  )
                ],

              ),
              child: Center(child: Text("Continue",style: TextStyle(color: colorConst.white,fontWeight: FontWeight.w600),)),
            ),
          ),
        ],
      ),
    );
  }
}
