import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../main.dart';
import 'createnewpswrd.dart';

class forgotpasswordpage2 extends StatefulWidget {
  const forgotpasswordpage2({super.key});

  @override
  State<forgotpasswordpage2> createState() => _forgotpasswordpage2State();
}

class _forgotpasswordpage2State extends State<forgotpasswordpage2> {
  final FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var code="";
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
          Center(child: Image(image: AssetImage(imageConst.protect),)),
          Center(child: Text("Code has been sent to +234111******99",style: TextStyle(fontWeight: FontWeight.w500,fontSize: scrWidth*0.04),)),
          FractionallySizedBox(
            child: Pinput(
              closeKeyboardWhenCompleted: true,
              androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Resend code in "),
              Countdown(
                seconds: 60,
                build: (p0, p1) {
                  return Text("$p1");
                },),
              Text("s"),
            ],
          ),
          InkWell(
            onTap: () async {
              try{
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    // verificationId: forgotpasswordpage1.verify,
                    smsCode: code,
                    verificationId: ''

                );
                await auth.signInWithCredential(credential);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => createnewpswrd(),), (route) => false);
              }
              catch(e){
                print(e.toString());
              }
              // Navigator.push(context, MaterialPageRoute(builder: (context) => createnewpswrd(),));
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
              child: Center(child: Text("Verify",style: TextStyle(color: colorConst.white,fontWeight: FontWeight.w600),)),
            ),
          ),
        ],
      ),
    );
  }
}
