import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/constant/color_const.dart';
import 'package:meat_shop_app/constant/image_const.dart';

import 'main.dart';

class orderconfirm extends StatefulWidget {
  const orderconfirm({super.key});

  @override
  State<orderconfirm> createState() => _orderconfirmState();
}

class _orderconfirmState extends State<orderconfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: w*1.3,
          width: w*0.88,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Image(image: AssetImage("assets/images/image 3.png")),
              Lottie.asset(gifs.tickGif),
              Text("You Place The OrderSuccessfully",style: TextStyle(fontWeight: FontWeight.bold,fontSize: w*0.035),),
              Text("You order placed successfully. We start our delivery proces and you will receive your meat soon."
                ,style: TextStyle(fontWeight: FontWeight.normal,fontSize: w*0.035,)
                ,textAlign: TextAlign.center,),
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => mainpage(),));
                },
                child: Container(
                  height: w*0.13,
                  width: w*0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w*0.04),
                      color: colorConst.meroon
                  ),
                  child: Center(child: Text("Back To Home",style: TextStyle(color: colorConst.white,fontWeight: FontWeight.bold,fontSize: w*0.035),)),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
