import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class BeefList extends StatefulWidget {
  const BeefList({super.key});

  @override
  State<BeefList> createState() => _BeefListState();
}

class _BeefListState extends State<BeefList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(),
          body:Padding(
            padding:  EdgeInsets.all(w*0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Meat",
                  style: TextStyle(
                      fontSize: w*0.07,
                      fontWeight: FontWeight.w700,
                      color:Colors.black
                  ),),


      
              ],
            ),
          )
      ),
    );
  }
}
