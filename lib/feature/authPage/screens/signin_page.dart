import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/authPage/screens/info_page.dart';
import 'package:meat_shop_app/feature/forgotpassword/forgotpassword1.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/feature/ordersPage/screens/checkoutpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../../models/orderDetailsModel.dart';

class signinPage extends StatefulWidget {
  final String path;
  const signinPage({Key? key,
    required this.path
  }) : super(key: key);

  @override
  State<signinPage> createState() => _signinPageState();
}

class _signinPageState extends State<signinPage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  bool visibility=true;
  bool check=false;
  final emailValidation=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final passwordValidation=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
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
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                  backgroundColor: colorConst.grey1,
                  child: Center(child: SvgPicture.asset(iconConst.backarrow))
              ),
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
                  fontWeight: FontWeight.w800,
                  fontSize: scrWidth*0.07,
                  color: colorConst.black ) ,),
            Padding(
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
                            color: colorConst.black.withOpacity(0.1)
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
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                          fontSize: scrWidth*0.04,
                          fontWeight: FontWeight.w600
                      ),
                      cursorColor: colorConst.grey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value){
                        if(!emailValidation.hasMatch(value!)){
                          return "enter valid email";
                        }
                        else{
                          return null;
                        }
                      },
                      decoration:
                      InputDecoration(
                          prefixIcon: Padding(
                            padding:  EdgeInsets.all(scrWidth*0.04),
                            child: SvgPicture.asset(iconConst.email,),
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
                                  color: colorConst.black.withOpacity(0.1)
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(scrWidth*0.03),
                              borderSide: BorderSide(
                                  color: colorConst.black.withOpacity(0.1)
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
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              ),
                            borderRadius: BorderRadius.circular(scrWidth*0.03),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(scrWidth*0.03),
                              borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1)
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(scrWidth*0.03),
                              borderSide: BorderSide(
                                  color: colorConst.black.withOpacity(0.1)
                              )
                          )
                      ),
                    ),
                  ),

                  SizedBox(height: scrWidth*0.06),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                                  color: colorConst.black.withOpacity(0.1)
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
                                fontWeight: FontWeight.w600,
                                fontSize: scrWidth*0.04
                            ),)

                        ],
                      ),
                      SizedBox(width: scrWidth*0.04,),
                      InkWell(
                        onTap: () async {
                          if(emailController.text!='') {
                            // var data = await FirebaseFirestore.instance.collection("users").where("number",isEqualTo: phoneController.text).get();
                            // print("ii ${data.docs.first.data()}");
                            // print(data);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => (forgotpasswordpage1(number: '',)),));

                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your phone number")));
                          }
                        },
                        child: Text("Forgot password",
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
                    ],),
                  SizedBox(height: scrWidth*0.03,),
                  InkWell(
                    onTap: (){
                      if(
                      emailController.text != ""&&
                      passwordController.text != ""
                      ){
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text
                        ).then((value) async {
                          var data = await FirebaseFirestore.instance.collection("users").where("email",isEqualTo: emailController.text).get();
                          var password = data.docs[0]["password"];
                          if(password == passwordController.text){
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setBool("LoggedIn", true);
                            prefs.setString("loginUserId", data.docs[0]["id"]);
                            prefs.setBool("gotIn", true);
                            // loginUserId = data.docs[0]["id"];
                            if(widget.path == "cartPage"){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => checkoutpage(
                                price: '',
                                discount: '',
                                shippingCharge: '',
                                subtotal: '',
                                orderdetailsdata: OrderDetailsModel(userId: '', paymentStatus: '', items: [], address: [], orderHistory: [], orderStatus: ''),
                                // cartMeat: [],
                              )));
                            }else{
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationPage(),));
                            }
                          }
                        }).catchError((onError){
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(onError.code == "invalid-credential" ? "Incorrect Password!" : "Login Error")));
                        });
                      }else{
                        emailController.text==""?ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your email!"))):
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your password!")));
                      }
                    },
                    child: Container(
                      height: scrWidth*0.17,
                      width: scrWidth*0.9,
                      decoration: BoxDecoration(
                        color: colorConst.meroon,
                        borderRadius: BorderRadius.circular(scrWidth*0.06),

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
                           Navigator.push(context, MaterialPageRoute(builder: (context) => infoPage(path: '',),));
                        },
                        child: Text("Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
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
            )
          ],
        ),
      ),


    );
  }
}

