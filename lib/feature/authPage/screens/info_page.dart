import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';

import '../../../main.dart';

class infoPage extends StatefulWidget {
  const infoPage({Key? key}) : super(key: key);

  @override
  State<infoPage> createState() => _infoPageState();
}

class _infoPageState extends State<infoPage> {
  TextEditingController phoneController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();

  bool visibility=true;
  bool check=false;
  final emailValidation=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final passwordValidation=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  final formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                height: scrWidth*0.2,
                width: scrWidth*0.2,
                padding: EdgeInsets.only(left: scrWidth*0.07),
                decoration: BoxDecoration(
                  image:DecorationImage(image: AssetImage(imageConst.mainIcon),fit: BoxFit.fill),
                ),
        
              ),
            ),
            Text("Meet Shop",
              style:TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: scrWidth*0.05,
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
                      Text("Sign up",
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
                        child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                              fontSize: scrWidth*0.04,
                              fontWeight: FontWeight.w500
                          ),
                          cursorColor: colorConst.grey,
                          decoration:
                          InputDecoration(
                            prefixIcon: Padding(
                              padding:  EdgeInsets.all(scrWidth*0.04),
                              child: Container(
                                height: scrWidth*0.07,
                                width: scrWidth*0.07,
                                child: SvgPicture.asset(iconConst.profile,color: colorConst.grey,),),
                            ),
                              labelText: "Enter your full name",
                              labelStyle: TextStyle(
                                  fontSize: scrWidth*0.04,
                                  fontWeight: FontWeight.w600,
                                  color: colorConst.grey
                              ),
                              filled: true,
                              fillColor: colorConst.white,
                              hintText: "Enter your full name",
                              hintStyle: TextStyle(
                                  fontSize: scrWidth*0.04,
                                  fontWeight: FontWeight.w700,
                                color: colorConst.grey
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
                          cursorColor: colorConst.grey,
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
                                  fontWeight: FontWeight.w700,
                                color: colorConst.grey
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
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                              fontSize: scrWidth*0.04,
                              fontWeight: FontWeight.w500
                          ),
                          cursorColor: colorConst.grey,
                          decoration:
                          InputDecoration(
                              prefixIcon: Padding(
                                padding:  EdgeInsets.all(scrWidth*0.04),
                                child: Container(child: SvgPicture.asset(iconConst.email,),),
                              ),
                              labelText: "Enter Your Email",
                              labelStyle: TextStyle(
                                  fontSize: scrWidth*0.04,
                                  fontWeight: FontWeight.w600,
                                  color: colorConst.grey
                              ),
                              filled: true,
                              fillColor: colorConst.white,
                              hintText: "Enter your Email Address",
                              hintStyle: TextStyle(
                                  fontSize: scrWidth*0.04,
                                  fontWeight: FontWeight.w700,
                                color: colorConst.grey
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
                          cursorColor: colorConst.grey,
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
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  fontSize: scrWidth*0.04,
                                  fontWeight: FontWeight.w600,
                                  color: colorConst.grey
                              ),
                              hintText: "Please Enter your Password",
                              hintStyle: TextStyle(
                                  fontSize: scrWidth*0.04,
                                  fontWeight: FontWeight.w700,
                                color: colorConst.grey
                              ),
                              border:OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: colorConst.red,
                                  ),
                                borderRadius: BorderRadius.circular(scrWidth*0.03),
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
                          controller: confirmPasswordController,
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
                          cursorColor: colorConst.grey,
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
                              labelText: "confirm Password",
                              labelStyle: TextStyle(
                                  fontSize: scrWidth*0.04,
                                  fontWeight: FontWeight.w600,
                                  color: colorConst.grey
                              ),
                              hintText: "Please Enter your confirm Password",
                              hintStyle: TextStyle(
                                  fontSize: scrWidth*0.04,
                                  fontWeight: FontWeight.w700,
                                color: colorConst.grey
                              ),
                              border:OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: colorConst.red
                                  ),
                                borderRadius: BorderRadius.circular(scrWidth*0.03),
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
                                SizedBox(width: scrWidth*0.04,),
                                Padding(
                                  padding:  EdgeInsets.only(top:scrWidth*0.05),
                                  child: Column(
                                    children: [
                                      Text("* By login I Agree with all the",
                                        style: TextStyle(
                                            fontSize: scrWidth*0.034,
                                            fontWeight: FontWeight.w500,
                                            color: colorConst.grey

                                        ),),
                                      InkWell(
                                        onTap: (){
                                          // Navigator.push(context, MaterialPageRoute(builder: (context) => (),));
                                        },
                                        child: Text(" Terms & Conditions",
                                          style: TextStyle(
                                              fontSize: scrWidth*0.034,
                                              fontWeight: FontWeight.w700,
                                              color: colorConst.meroon
                                          ),),
                                      )
                                    ],
                                  ),
                                )

                              ],
                            ),
                          ),

                        ],
                      ),

                      SizedBox(height: scrWidth*0.03,),
                      InkWell(
                        onTap: (){
                          if(
                                  nameController.text!=""&&
                                  phoneController.text!=""&&
                                  emailController.text!=""&&
                                      passwordController.text!=""&&
                                  confirmPasswordController.text!=""&&
                                      // valueChoose!=null

                              formkey.currentState!.validate()
                          ){
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => (),));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("submitted Successfully")));
                          }else{
                            nameController.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please enter your name"))):
                            phoneController.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please enter your phone number"))):
                            emailController.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please enter your email"))):
                            passwordController.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please enter your password"))):
                            confirmPasswordController.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please enter your confirm password"))):
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
                            child: Text("Sign up",
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
                          Text("Already have account",
                            style: TextStyle(
                              fontSize: scrWidth*0.04,
                                fontWeight: FontWeight.w500,
                                color: colorConst.grey
        
                            ),),
                          SizedBox(width: scrWidth*0.02,),
                          InkWell(
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => (),));
                            },
                            child: Text("Sign In",
                              style: TextStyle(
                                  fontSize: scrWidth*0.047,
                                  fontWeight: FontWeight.w800,
                                  color: colorConst.meroon
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
