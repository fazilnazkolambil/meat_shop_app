import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool gotIn = false;
List introTexts = [];
List introImages = [];

getBannerCollections ()async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  gotIn = prefs.getBool("gotIn") ?? false;
  var banner = await FirebaseFirestore.instance.collection('banner').doc('adds').get();
  introTexts = banner['introTexts'];
  introImages = banner['images'];
}

List meatTypes = [];
int meatTypesLength = 0;
getMeatCollection () async {
  var meats = await FirebaseFirestore.instance.collection('meatTypes').get();
  meatTypesLength = meats.docs.length;
  for (int i = 0; i < meats.docs.length; i++){
    meatTypes.add({
      'name' : meats.docs[i]['type'],
      'image' : meats.docs[i]['mainImage']
    });
  }
}