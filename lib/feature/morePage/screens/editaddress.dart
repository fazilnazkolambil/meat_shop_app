import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:meat_shop_app/core/constant/color_const.dart';
import 'package:meat_shop_app/core/constant/image_const.dart';
import 'package:meat_shop_app/feature/onboardPage/screens/NavigationPage.dart';
import 'package:meat_shop_app/models/userModel.dart';

import '../../../main.dart';
import '../../../models/addressModel.dart';

class editaddress extends StatefulWidget {
  final String name;
  final String number;
  final String pincode;
  final String street;
  final String town;
  final String buildingName;
  final String deliveryinstruction;
  final String location;
  final int index;
  final String type;
  final List types;

  const editaddress(
      {super.key,
        required this.pincode,
        required this.location,
        required this.deliveryinstruction,
        required this.name,
        required this.number,
        required this.street,
        required this.town,
        required this.buildingName,
        required this.index,
        required this.type,
        required this.types,
      });

  @override
  State<editaddress> createState() => _editaddressState();
}

class _editaddressState extends State<editaddress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();
  TextEditingController otherAddressController = TextEditingController();

  final emailValidation = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final phoneValidation = RegExp(r"[0-9]{10}");
  final pincodeValidation = RegExp(r"[0-9]{6}");

  final formKey = GlobalKey<FormState>();
  var countryCode;
  File? file;
  bool loading = false;
  bool validate = false;
  String newImage = '';
  List userAddress=[];
  UserModel? userModel;
  String location = '';

  editAddress()async{
    addressModel editedAddress=addressModel(
      name: nameController.text,
      number:numberController.text,
      location: location,
      pincode: pincodeController.text,
      deliveryInstruction: instructionsController.text,
      street: streetController.text,
      town: townController.text,
      buildingName: buildingNameController.text,
      type: selectedAddressType ?? otherAddressController.text.trim(),
    );
    await FirebaseFirestore.instance.collection("users").doc(loginId).get().then((value) {
      userModel = UserModel.fromMap(value.data()!);
    });
    userAddress=userModel!.address;
    userAddress.replaceRange(widget.index, widget.index+1, [editedAddress.toMap()]);
    UserModel tempuserModel=userModel!.copyWith(
        address: userAddress
    );
    await FirebaseFirestore.instance.collection("users").doc(loginId).update(tempuserModel.toMap());
  }
  var selectedAddressType;
  bool otherAddress = false;
  List addressTypes = [
    'Home', 'Work', 'Others'
  ];
  @override
  void initState() {
    nameController.text = widget.name;
    numberController.text = widget.number;
    pincodeController.text = widget.pincode;
    streetController.text = widget.street;
    townController.text = widget.town;
    buildingNameController.text = widget.buildingName;
    instructionsController.text = widget.deliveryinstruction;
    if(addressTypes.contains(widget.type)){
      selectedAddressType = widget.type;
    }else{
      otherAddress = true;
      otherAddressController.text = widget.type;
    }

    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorConst.white,
        elevation: 0,
        toolbarHeight: scrHeight * 0.1,
        // leadingWidth: w * 0.03,
        title: Padding(
          padding: EdgeInsets.all(scrWidth * 0.03),
          child: Text("Edit Address",
              style: TextStyle(
                  color: colorConst.black,
                  fontSize: scrWidth * 0.055,
                  fontWeight: FontWeight.w800)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(scrWidth * 0.05),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: EdgeInsets.only(bottom:scrWidth*0.03),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    cursorColor: colorConst.grey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if(nameController.text.isEmpty){
                        return "Name is required";
                      }else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 80),
                        labelText: "Full name *",
                        labelStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            color: colorConst.grey),
                        filled: true,
                        fillColor: colorConst.white,
                        hintText: "Enter your full name",
                        hintStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: colorConst.grey),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: colorConst.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.03),
                            borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.03),
                            borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1)))),
                  ),
                ),
                Padding(
                  padding:EdgeInsets.only(bottom: scrWidth*0.03),
                  child: TextFormField(
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (!phoneValidation.hasMatch(value!)) {
                        return "Enter a valid Phone Number!";
                      } else {
                        return null;
                      }
                    },
                    cursorColor: colorConst.grey,
                    decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 80),
                        prefix: Padding(
                          padding:EdgeInsets.only(right:scrWidth*0.03),
                          child: SizedBox(child: Text("+91"),),
                        ),
                        counterText: "",
                        prefixStyle: TextStyle(color: colorConst.black,fontWeight: FontWeight.w500),
                        labelText: "Phone Number *",
                        labelStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            color: colorConst.grey
                        ),
                        filled: true,
                        fillColor: colorConst.white,
                        hintText: "Enter your Phone Number",
                        hintStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: colorConst.grey),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: colorConst.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.03),
                            borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.03),
                            borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1)))),
                  ),
                ),
                SizedBox(
                  height: scrWidth * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: scrWidth*0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        //height: scrHeight*0.06,
                        width: scrWidth*0.4,
                        child: TextFormField(
                          controller: pincodeController,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.done,
                          style: TextStyle(
                              fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                          cursorColor: colorConst.grey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if(!pincodeValidation.hasMatch(value!)){
                              return "Enter a valid Pincode";
                            }else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              constraints: BoxConstraints(maxHeight: 70),
                              counterText: "",
                              labelText: "Pincode *",
                              labelStyle: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  color: colorConst.grey
                              ),
                              filled: true,
                              fillColor: colorConst.white,
                              hintText: "Enter your Pincode",
                              hintStyle: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: colorConst.grey),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: colorConst.red)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(scrWidth * 0.03),
                                  borderSide: BorderSide(
                                      color: colorConst.black.withOpacity(0.1))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(scrWidth * 0.03),
                                  borderSide: BorderSide(
                                      color: colorConst.black.withOpacity(0.1)))),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          LocationPermission permission = await Geolocator.checkPermission();
                          if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
                            Future.error('Location permissions are denied');
                            LocationPermission ask = await Geolocator.requestPermission();
                          }
                          try{
                            Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
                            // print(currentPosition.latitude);
                            // print(currentPosition.longitude);
                            location = "${currentPosition.latitude},${currentPosition.longitude}";
                            List <Placemark> result = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
                            Placemark first = result.first;
                            print(result);
                            setState(() {
                              pincodeController.text = first.postalCode!;
                              streetController.text = first.subLocality!;
                              townController.text = first.locality!;
                            });
                          }
                          catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load your Location")));
                          }
                        },
                        child: Container(
                          height: scrHeight*0.06,
                          width: scrWidth*0.4,
                          decoration: BoxDecoration(
                            // color: colorConst.meroon.withOpacity(0.3),
                            border: Border.all(color: colorConst.meroon),
                            borderRadius: BorderRadius.circular(scrWidth*0.03),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.my_location_outlined,color: colorConst.meroon,),
                              Text("My Location",style: TextStyle(color: colorConst.meroon),)
                            ],),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: scrWidth*0.03),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          //height: scrHeight*0.06,
                          width: scrWidth*0.4,
                          child: TextFormField(
                            controller: streetController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(
                                fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                            cursorColor: colorConst.grey,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if(streetController.text.isEmpty){
                                return "Street is required";
                              }else{
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                constraints: BoxConstraints(maxHeight: 80),
                                labelText: "Street *",
                                labelStyle: TextStyle(
                                    fontSize: scrWidth * 0.04,
                                    color: colorConst.grey
                                ),
                                filled: true,
                                fillColor: colorConst.white,
                                hintText: "Enter your Street name",
                                hintStyle: TextStyle(
                                    fontSize: scrWidth * 0.04,
                                    fontWeight: FontWeight.w500,
                                    color: colorConst.grey),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: colorConst.red)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(scrWidth * 0.03),
                                    borderSide: BorderSide(
                                        color: colorConst.black.withOpacity(0.1))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(scrWidth * 0.03),
                                    borderSide: BorderSide(
                                        color: colorConst.black.withOpacity(0.1)))),
                          ),
                        ),
                        SizedBox(
                          //height: scrHeight*0.06,
                          width: scrWidth*0.4,
                          child: TextFormField(
                            controller: townController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(
                                fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                            cursorColor: colorConst.grey,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if(townController.text.isEmpty){
                                return "City/Town is required";
                              }else{
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                constraints: BoxConstraints(maxHeight: 80),
                                labelText: "City/Town *",
                                labelStyle: TextStyle(
                                    fontSize: scrWidth * 0.04,
                                    color: colorConst.grey
                                ),
                                filled: true,
                                fillColor: colorConst.white,
                                hintText: "Enter your City/Town name",
                                hintStyle: TextStyle(
                                    fontSize: scrWidth * 0.04,
                                    fontWeight: FontWeight.w500,
                                    color: colorConst.grey),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: colorConst.red)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(scrWidth * 0.03),
                                    borderSide: BorderSide(
                                        color: colorConst.black.withOpacity(0.1))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(scrWidth * 0.03),
                                    borderSide: BorderSide(
                                        color: colorConst.black.withOpacity(0.1)))),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: scrWidth * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:scrWidth*0.03),
                  child: TextFormField(
                    controller: buildingNameController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    cursorColor: colorConst.grey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if(buildingNameController.text.isEmpty){
                        return "Please enter valid address";
                      }else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 80),
                        labelText: "Flat/House number, Building Name *",
                        labelStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            color: colorConst.grey),
                        filled: true,
                        fillColor: colorConst.white,
                        hintText: 'e.g. 12A, Metro Residency',
                        hintStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: colorConst.grey),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: colorConst.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.03),
                            borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.03),
                            borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom:scrWidth*0.03),
                  child: TextFormField(
                    controller: instructionsController,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                        fontSize: scrWidth * 0.04, fontWeight: FontWeight.w600),
                    cursorColor: colorConst.grey,
                    decoration: InputDecoration(
                        constraints: BoxConstraints(maxHeight: 80),
                        labelText: "Delivery Instructions",
                        labelStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            color: colorConst.grey),
                        filled: true,
                        fillColor: colorConst.white,
                        hintText: "e.g. Contact me if the Gate is closed",
                        hintStyle: TextStyle(
                            fontSize: scrWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: colorConst.grey),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: colorConst.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.03),
                            borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(scrWidth * 0.03),
                            borderSide: BorderSide(
                                color: colorConst.black.withOpacity(0.1)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: scrWidth*0.03),
                  child: otherAddress?
                  SizedBox(
                    height: scrWidth*0.1,
                    child: TextField(
                      controller: otherAddressController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          hintText: "Save as",
                          suffixIcon: InkWell(
                              onTap: () {
                                otherAddress = false;
                                selectedAddressType = null;
                                setState(() {

                                });
                              },
                              child: Icon(Icons.close))
                      ),
                      onSubmitted: (value) {
                        if(widget.types.contains(value)){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$value address already exist')));
                          selectedAddressType = null;
                        }else{
                          selectedAddressType = value;
                        }
                        setState(() {

                        });
                      },
                    ),
                  ):
                  SizedBox(
                    height: scrWidth*0.1,
                    child: ListView.separated(
                      itemCount:addressTypes.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Radio(
                              activeColor: colorConst.meroon,
                              value: addressTypes[index],
                              groupValue: selectedAddressType,
                              onChanged: (value) {
                                if(widget.types.contains(value)){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$value address already exist!')));
                                  value = null;
                                }else if(value == "Others"){
                                  otherAddress = true;
                                } else {
                                  selectedAddressType = value;
                                }
                                setState(() {

                                });
                              },
                            ),
                            Text(addressTypes[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: scrWidth*0.035
                              ),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => SizedBox(width: 10,),


                    ),
                  ),
                ),
                SizedBox(height: scrWidth*0.1,),
                InkWell(
                  onTap: () {
                    if(
                    formKey.currentState!.validate() &&
                    selectedAddressType != null || otherAddressController.text.isNotEmpty
                    ){
                      editAddress();
                      Navigator.pop(context);
                    }else{
                      selectedAddressType == null || otherAddressController.text.isEmpty?
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select Address Type!"))):
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Valid details!")));
                    }
                  }
                  ,
                  child: Container(
                      height: scrHeight * 0.06,
                      decoration: BoxDecoration(
                        color: //validate?colorConst.meroon:
                        colorConst.meroon,
                        borderRadius: BorderRadius.circular(scrWidth * 0.07),
                      ),
                      child: Center(
                          child: Text("Update",
                              style: TextStyle(
                                  color: colorConst.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: scrWidth * 0.04)))),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}