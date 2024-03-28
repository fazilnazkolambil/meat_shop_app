import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/main.dart';

import '../onboardPage/screens/NavigationPage.dart';

class createnewpswrd extends StatefulWidget {
  const createnewpswrd({super.key});

  @override
  State<createnewpswrd> createState() => _createnewpswrdState();
}

class _createnewpswrdState extends State<createnewpswrd> {
  final passwordvalidaation=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final formKey=GlobalKey<FormState>();
  TextEditingController password1Controller=TextEditingController();
  TextEditingController password2Controller=TextEditingController();
  bool remember=false;
  bool hide1=true;
  bool hide2=true;
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
        title: Text("Create New Password",
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: scrWidth*0.045
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: scrWidth*0.68,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Create Your New Password",style: TextStyle(fontWeight: FontWeight.w500,color: colorConst.grey1),),
                ],
              ),
              SizedBox(
                height: scrWidth*0.02,
              ),
              Container(
                height: scrWidth*0.8025,
                width: scrWidth*1,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        controller: password1Controller,
                        // textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        maxLength: 8,
                        obscureText: hide1?true:false,
                        style: TextStyle(
                            fontSize: scrWidth*0.04,
                            fontWeight: FontWeight.w500
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if(!passwordvalidaation.hasMatch(value!)){
                            return
                              "Password must contains eight characters, inclu\n"
                                  "ding at least one number and includes both lo\n"
                                  "wer and uppercase letters and special charac\n"
                                  "ters, for example @, #, ?, !.\n";
                          }
                        },

                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                hide1=!hide1;
                                setState(() {

                                });
                              },
                              child: Icon(hide1?Icons.visibility_off_outlined:Icons.visibility_outlined)),

                          labelText: "Enter New Password",
                          labelStyle: TextStyle(
                              fontSize: scrWidth*0.043,
                              fontWeight: FontWeight.w500,
                              color: colorConst.black
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: scrWidth*0.04
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: colorConst.grey1,
                                  width: scrWidth*0.005
                              ),
                              borderRadius: BorderRadius.circular(scrWidth*0.03)
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: password2Controller,
                        // textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        maxLength: 8,
                        // maxLines: 5,
                        // minLines: 3,
                        obscureText:hide2? true:false,
                        // obscuringCharacter: "*",

                        style: TextStyle(
                            fontSize: scrWidth*0.04,
                            fontWeight: FontWeight.w500
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if(password2Controller.text!=password1Controller.text){
                            return "Password doesn't match";
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                hide2=!hide2;
                                setState(() {

                                });
                              },
                              child: Icon(hide2?Icons.visibility_off_outlined:Icons.visibility_outlined)),
                          // suffixText: "fff",
                          labelText: " Confirm New Password",
                          labelStyle: TextStyle(
                              fontSize: scrWidth*0.043,
                              fontWeight: FontWeight.w500,
                              color: colorConst.black
                          ),
                          hintText: "Confirm New Password",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: scrWidth*0.04
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: colorConst.grey1,
                                  width: scrWidth*0.005
                              ),
                              borderRadius: BorderRadius.circular(scrWidth*0.03)
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Checkbox(
                              value: remember,
                              onChanged: (value) {
                                setState(() {
                                  remember=value!;
                                });
                              },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(scrWidth*0.018)),activeColor: colorConst.meroon,
                            ),

                          ),
                          Text("Remember me",style: TextStyle(fontWeight: FontWeight.w500),),
                        ],

                      ),
                      SizedBox(
                        height: scrWidth*0.008,
                      )
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  if(password1Controller.text!=""&&
                      password2Controller.text!=""&&
                      password2Controller.text==password1Controller.text&&
                      formKey.currentState!.validate()
                  ){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationPage(),));
                  }else{
                    password1Controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your password"))):
                    password2Controller.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please confirm your password"))):
                    password2Controller.text!=password1Controller.text?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("password doesn't match"))):
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your valid details")));
                  }
                  setState(() {

                  });
                },
                child: Container(
                  height: scrWidth*0.18,
                  width: scrWidth*1,
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
        ),
      ),

    );
  }
}
