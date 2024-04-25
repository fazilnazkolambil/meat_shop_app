import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';

import '../../../main.dart';
import '../../ordersPage/screens/cart_page.dart';
import 'meatList.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorConst.white,
      appBar: AppBar(
        backgroundColor: colorConst.white,
        leading: Padding(
          padding:EdgeInsets.all(scrWidth*0.03),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
                backgroundColor: colorConst.grey1,
                child: Center(child: SvgPicture.asset(iconConst.backarrow))),
          ),
        ),
        title: Text('Search',style: TextStyle(
          fontSize: scrWidth*0.05,
          fontWeight: FontWeight.w600
        ),),
          centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            style: TextStyle(
              fontSize: scrWidth * 0.04,
              fontWeight: FontWeight.w400,
            ),
            controller: search_controller,
            decoration: InputDecoration(
              fillColor: colorConst.grey1,
              filled: true,
              constraints: BoxConstraints(
                maxHeight: scrHeight*0.07,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.all(scrWidth*0.029),
                child: SvgPicture.asset(iconConst.search,
                ),
              ),prefixIconConstraints: BoxConstraints(
                maxHeight: scrWidth*0.1,
                maxWidth: scrWidth*0.1
            ),
              hintText: "Search here for anything you want...",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: scrWidth * 0.04,
                  color: colorConst.grey),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(scrWidth * 0.09),
                  borderSide: BorderSide(color: colorConst.grey1)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(scrWidth * 0.09),
                  borderSide: BorderSide(color: colorConst.grey1)),
            ),
          ),
        ],
      ),
    );
  }
}
