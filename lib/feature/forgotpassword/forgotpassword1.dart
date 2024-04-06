import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/forgotpassword/forgotpassword2.dart';
import 'package:meat_shop_app/main.dart';

class forgotpasswordpage1 extends StatefulWidget {
  final String number;
  const forgotpasswordpage1({super.key, required this.number});
  static String verify="";

  @override
  State<forgotpasswordpage1> createState() => _forgotpasswordpage1State();
}

class _forgotpasswordpage1State extends State<forgotpasswordpage1> {
  bool border1=false;
  bool border2=false;
  String? email,num;
  String countrycode="+91";
  getData() async {
    var data = await FirebaseFirestore.instance.collection("users").where("number",isEqualTo: widget.number).get();
    print("kkkk${data.docs.first.data()}");
    print("oooooooo${data.docs[0]["number"]}");
    if(data.docs[0]["number"]==widget.number){
      num=data.docs[0]["number"];
      email=data.docs[0]["email"];
    };
    print(num);
    print(email);
    setState(() {

    });
  }
  @override
  void initState() {
    print("iiiii ${widget.number}");
    getData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding:  EdgeInsets.all(scrWidth*0.03),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: colorConst.grey1,
                    borderRadius: BorderRadius.circular(scrWidth*0.08)
                ),
                child: Center(child: SvgPicture.asset(iconConst.backarrow))
            ),
          ),
        ),
        title: Text("Forgot password",
          style: TextStyle(
              fontWeight: FontWeight.w800,
            fontSize: scrWidth*0.045
          ),),
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
                    backgroundColor: colorConst.grey1,
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
                        child: Text("via SMS:",style: TextStyle(color: colorConst.grey,fontWeight: FontWeight.w600),),
                      ),
                      Text(" ${num.toString()}",style: TextStyle(color: colorConst.black,fontWeight: FontWeight.w400),),
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
                    backgroundColor: colorConst.grey1,
                    radius: scrWidth*0.07,
                    child: Icon(Icons.mail_outline_outlined,color: colorConst.meroon,),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:EdgeInsets.only(right: scrWidth*0.33),
                        child: Text("via Email:",style: TextStyle(color: colorConst.grey,fontWeight: FontWeight.w600),),
                      ),
                      Padding(
                        padding:EdgeInsets.only(right: scrWidth*0.17),
                        child: Text(" $email",style: TextStyle(color: colorConst.black,fontWeight: FontWeight.w400),),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.verifyPhoneNumber(
                // phoneNumber: "+916235149087",
                phoneNumber: "${countrycode+num.toString()}",
                verificationCompleted: (PhoneAuthCredential credential){},
                verificationFailed: (FirebaseAuthException e){},
                codeSent: (String verificationId,int? resentToken){
                  forgotpasswordpage1.verify=verificationId;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const forgotpasswordpage2(),));
                },
                codeAutoRetrievalTimeout: (String verificationId){},
              );
              // Navigator.push(context, MaterialPageRoute(builder: (context) => otppage(),));
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
