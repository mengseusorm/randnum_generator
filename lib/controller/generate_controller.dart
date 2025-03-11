import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math'; 
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GenerateController extends GetxController { 

  RxDouble numberCount = 1.0.obs;
  RxInt allowDuplicateNumber = 0.obs;

  final minMumNumber = TextEditingController(text: "0");
  final maxiMumNumber = TextEditingController(text: "100");  
  final items = <String>[].obs;
  RxInt columnResult = 1.obs;  
  final item_histories = <String>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initBanner();
  }
  
  @override
  void onClose() {
    bannerAd.dispose();
    super.onClose();
  }

  void slider(value){
    numberCount.value = value;
  }
  void currentIndex(index){
    allowDuplicateNumber.value = index; 
  }

  void generate(numberCount,allowDuplicate) {
    if(validateInputNumber(minMumNumber.text,maxiMumNumber.text)){ 
      generateNumber(minMumNumber.text,maxiMumNumber.text,numberCount,allowDuplicate); 
    }

  } 

  bool validateInputNumber(String min, String max){ 
    if(min.isEmpty) {
      minMumNumber.text = "0"; 
    }
    
    if(max.isEmpty){
      maxiMumNumber.text = "100";  
    }

    var minNumber = int.tryParse(min) ?? 0;
    var maxNumber = int.tryParse(max) ?? 100; 
    
    if(minNumber > maxNumber){
      minMumNumber.text = "$maxNumber";
      maxiMumNumber.text = "$minNumber"; 
    } 
    return true;
  }

  void generateNumber(min,max,numberCount,allowDupliate){   
    switch (numberCount) {
      case 1:
          columnResult.value = 1;
          if (items.isNotEmpty) {
            items.clear();
          }
          var rng = (int.parse(min) + Random().nextInt(int.parse(max) - int.parse(min)));
          items.add(rng.toString());
          item_histories.add(rng.toString());
        break;
      case 2:
        columnResult.value = 2;
        if(items.isNotEmpty) {
          items.clear();
        } 
        for (var i = 0; i < numberCount; i++) {
          var rng = (int.parse(min) + Random().nextInt(int.parse(max) - int.parse(min)));
          items.add(rng.toString());
          item_histories.add(rng.toString()); 
        } 
        break;
      case 3:
        columnResult.value = 3;
        if(items.isNotEmpty) {
          items.clear();
        } 
        for (var i = 0; i < numberCount; i++) {
          var rng = (int.parse(min) + Random().nextInt(int.parse(max) - int.parse(min)));
          items.add(rng.toString());
          item_histories.add(rng.toString()); 
        } 
        break;
      default:
        columnResult.value = 3; 
        if(items.isNotEmpty){
          items.clear();
        }
        for (var i = 0; i < numberCount; i++) {
          var rng = (int.parse(min) + Random().nextInt(int.parse(max) - int.parse(min)));
          items.add(rng.toString());
          item_histories.add(rng.toString());  
        } 
    } 
  }

  void clearHistory(){
    item_histories.value = [];
  }
  
  bool copy (value)  { 
    Clipboard.setData(ClipboardData(text: value )); 
    return true;
  }
  //ad
  late BannerAd bannerAd;
  final RxBool isAdLoaded = false.obs;

  void initBanner(){
    bannerAd = BannerAd(
      size: AdSize.banner, 
      adUnitId: "ca-app-pub-1059652645223736/5635260629", 
      listener: BannerAdListener(
        onAdLoaded: (ad){
          print("Ad loaded successfully!");
          isAdLoaded.value = true;
          update();
        },
        onAdFailedToLoad: (ad,err){
          print("Failed to load ad: ${err.message}");
          ad.dispose();
        },
        onAdOpened: (ad) => print("Ad opened"),
        onAdClosed: (ad) => print("Ad closed"),
        onAdImpression: (ad) => print("Ad impression recorded")
      ), 
      request: const AdRequest(),
    );
    bannerAd.load();
  } 

 void reloadAd() {
    bannerAd.dispose();
    initBanner();
  }
}