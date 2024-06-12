import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constant/color_const.dart';
import '../../../core/constant/image_const.dart';
import '../../../main.dart';

class ordertracking extends StatefulWidget {
  final List data;
  const ordertracking({super.key, required this.data});

  @override
  State<ordertracking> createState() => _ordertrackingState();
}

class _ordertrackingState extends State<ordertracking> {
  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Order Placed",
        ),
        subtitle: StepperText("Your order has been placed"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_one, color: Colors.white),
        )),
    StepperData(
        title: StepperText("Order shipped"),
        subtitle: StepperText("Your order is being prepared"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_two, color: Colors.white),
        )),
    StepperData(
        title: StepperText("On the way"),
        subtitle: StepperText(
            "Our delivery executive is on the way to deliver your item"),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_3, color: Colors.white),
        )),
    StepperData(
        title: StepperText("Delivered",
            // textStyle: const TextStyle(color: Colors.grey)
        ),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.looks_4, color: Colors.white),

        )),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding:  EdgeInsets.all(scrWidth*0.03),
          child: InkWell(
            onTap: () {
              // print(widget.data);
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
        title: Text("Order Tracking",
          style: TextStyle(
              fontWeight: FontWeight.w600
          ),),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: scrWidth*1.2,
              width: scrWidth*0.9,
              // color: colorConst.grey,
              child: AnotherStepper(
                stepperList: stepperData,
                stepperDirection: Axis.vertical,
                iconWidth: 40,
                iconHeight: 40,
                activeBarColor: Colors.green,
                inActiveBarColor: Colors.grey,
                inverted: false,
                verticalGap: 30,
                activeIndex: 1,
                barThickness: 6,
              ),
              )
              ),
    ],
      ),

    );
  }
}
