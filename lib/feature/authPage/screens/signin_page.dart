import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';

import '../../../main.dart';

class signinPage extends StatefulWidget {
  const signinPage({Key? key}) : super(key: key);

  @override
  State<signinPage> createState() => _signinPageState();
}

class _signinPageState extends State<signinPage> {
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  bool visibility=true;
  bool check=false;
  final passwordValidation=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
 backgroundColor: colorConst.white,
appBar: AppBar(
  elevation: 0,
  backgroundColor: Colors.white,
  leading: InkWell(
    onTap: (){

    },
    child: Padding(
      padding:  EdgeInsets.all(scrWidth*0.03),
      child: Container(
          decoration: BoxDecoration(
              color: colorConst.grey1,
              borderRadius: BorderRadius.circular(scrWidth*0.08)
          ),
          child: Center(child: SvgPicture.asset(iconConst.backarrow))
      ),
    ),
  ),
),
      body: SingleChildScrollView(
        child: Column(
        children: [
          Center(
            child: Container(
        height: scrWidth*0.25,
        width: scrWidth*0.25,
        padding: EdgeInsets.only(left: scrWidth*0.07),
        decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage(imageConst.mainIcon),fit: BoxFit.fill),
        ),
        
            ),
          ),
          Text("Meet Shop",
            style:TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: scrWidth*0.06,
        color: colorConst.black ) ,),
          Form(
            key: formkey,
        child:Padding(
          padding:  EdgeInsets.all(scrWidth*0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: scrWidth*0.03,),
              Text("Sign In",
              style: TextStyle(
                fontSize: scrWidth*0.045,
                fontWeight: FontWeight.w700,
                color: colorConst.meroon
              ),),
              SizedBox(height: scrWidth*0.03,),
              Container(
                decoration: BoxDecoration(
                    color: colorConst.white,
                    borderRadius: BorderRadius.circular(scrWidth*0.04),
                    border: Border.all(
                        width: scrWidth*0.0003,
                        color: colorConst.black.withOpacity(0.38)
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: colorConst.black.withOpacity(0.1),
                          blurRadius: 14,
                          offset: Offset(0, 4),
                          spreadRadius: 0
                      )
                    ]
                ),
                child:TextFormField(
                  controller: phoneController,
                  keyboardType:  TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                      fontSize: scrWidth*0.04,
                      fontWeight: FontWeight.w500
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      counterText: "",
                      prefixIcon: CountryCodePicker(
                        initialSelection: "IN",
                      ),
                      labelText: "Enter Your Phone Number",
                      labelStyle: TextStyle(
                          fontSize: scrWidth*0.04,
                          fontWeight: FontWeight.w600,
                          color: colorConst.grey
                      ),
                      filled: true,
                      fillColor: colorConst.white,
                      hintText: "Enter your Phone Number",
                      hintStyle: TextStyle(
                          fontSize: scrWidth*0.04,
                          fontWeight: FontWeight.w700
                      ),
                      border:OutlineInputBorder(
                          borderSide: BorderSide(
                              color: colorConst.red
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(scrWidth*0.03),
                          borderSide: BorderSide(
                            color: colorConst.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(scrWidth*0.03),
                          borderSide: BorderSide(
                              color: colorConst.grey
                          )
                      )
                  ),
                ),
              ),
        
              SizedBox(height: scrWidth*0.04,),
              Container(
                decoration: BoxDecoration(
                    color: colorConst.white,
                    borderRadius: BorderRadius.circular(scrWidth*0.04),
                    border: Border.all(
                        width: scrWidth*0.0003,
                        color: colorConst.black.withOpacity(0.38)
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: colorConst.black.withOpacity(0.1),
                          blurRadius: 14,
                          offset: Offset(0, 4),
                          spreadRadius: 0
                      )
                    ]
                ),
                child:   TextFormField(
                  onChanged: (value){
                    setState(() {
        
                    });
        
                  },
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: visibility?true:false,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: scrWidth*0.05
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(
                    !passwordValidation.hasMatch(value!)){
                      return "Password must contain at least 8 characters with \n one lowercae(a-z),one uppercase(A-Z)";
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: colorConst.white,
                      suffixIcon: InkWell(
                        onTap: (){
                          visibility=!visibility;
                          setState(() {

                          });
                        },
                        child: Icon(visibility==true?Icons.visibility_off:Icons.visibility,color: colorConst.grey,),

                      ),
                      prefixIcon: Padding(
                        padding:  EdgeInsets.all(scrWidth*0.038),
                        child: Container(child: SvgPicture.asset(iconConst.password)),
                      ),
                      labelText: "Enter Your Password",
                      labelStyle: TextStyle(
                          fontSize: scrWidth*0.04,
                          fontWeight: FontWeight.w600,
                          color: colorConst.grey
                      ),
                      hintText: "Please Enter your Password",
                      hintStyle: TextStyle(
                          fontSize: scrWidth*0.04,
                          fontWeight: FontWeight.w700
                      ),
                      border:OutlineInputBorder(
                          borderSide: BorderSide(
                              color: colorConst.red
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(scrWidth*0.03),
                          borderSide: BorderSide(
                            color: colorConst.grey,
                          )
                      ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(scrWidth*0.03),
                      borderSide: BorderSide(
                        color: colorConst.grey
                      )
                    )
                  ),
                ),
              ),
        
              SizedBox(height: scrWidth*0.06),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                         height: scrWidth*0.05,
                         width: scrWidth*0.05,
                          decoration: BoxDecoration(
                              color: colorConst.white,
                              borderRadius: BorderRadius.circular(scrWidth*0.01),
                              border: Border.all(
                                  width: scrWidth*0.0003,
                                  color: colorConst.black.withOpacity(0.38)
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: colorConst.black.withOpacity(0.1),
                                    blurRadius: 14,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0
                                )
                              ]
                          ),
                          child: Checkbox(
                            value: check,
                            activeColor: colorConst.meroon,
                            side: BorderSide(
                                color: colorConst.grey
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(scrWidth*0.01)
                            ),
                            onChanged: (value){
                              setState(() {
                                check=value!;
                              });
                            },
                          ),

                        ),
                        SizedBox(width: scrWidth*0.03,),
                        Text("Remember me",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: scrWidth*0.04
                          ),)

                      ],
                    ),
                  ),
                  SizedBox(width: scrWidth*0.04,),
                  InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => (),));
                    },
                    child: Text("Forget password",
                      style: TextStyle(
                          color: colorConst.meroon
                      ),),
                  ),
                ],
              ),
              SizedBox(height: scrHeight*0.07,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("* By login I Agree with all the",
                    style: TextStyle(
                      fontSize: scrWidth*0.035,
                        fontWeight: FontWeight.w500,
                        color: colorConst.grey
        
                    ),),
                  InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => (),));
                    },
                    child: Text(" Terms & Conditions",
                      style: TextStyle(
                          fontSize: scrWidth*0.035,
                          fontWeight: FontWeight.w700,
                          color: colorConst.meroon
                      ),),
                  )
                ],),
              SizedBox(height: scrWidth*0.03,),
              InkWell(
                onTap: (){
                  if(
                  phoneController.text!=""&&
                      formkey.currentState!.validate()
                  ){
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => (),));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("submitted Successfully")));
                  }else{
                    phoneController.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please enter your phone number"))):
                    passwordController.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please enter your password"))):
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please enter your valid details")));
                  }
                },
                child: Container(
                  height: scrWidth*0.17,
                  width: scrWidth*0.9,
                  decoration: BoxDecoration(
                      color: colorConst.meroon,
                      borderRadius: BorderRadius.circular(scrWidth*0.07),
        
                  ),
                  child: Center(
                    child: Text("Sign in",
                      style: TextStyle(
                          color: colorConst.white,
                          fontWeight: FontWeight.w600,
                          fontSize: scrWidth*0.04
                      ),),
                  ),
                ),
              ),
        
              SizedBox(height: scrWidth*0.15,),
        
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: colorConst.grey
        
                    ),),
                  InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => (),));
                    },
                    child: Text("Sign up",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: colorConst.meroon
                      ),),
                  )
                ],),
              SizedBox(height: scrWidth*0.07,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Continue as ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: colorConst.grey
        
                    ),),
                  InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => (),));
                    },
                    child: Text("Guest",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: colorConst.black
                      ),),
                  )
                ],),
        
            ],),
        ))
        ],
        ),
      ),


    );
  }
}