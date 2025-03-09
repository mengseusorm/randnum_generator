import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:math';
class GenerateController extends GetxController { 

  RxDouble numberCount = 1.0.obs;
  final minMumNumber = TextEditingController(text: "0");
  final maxiMumNumber = TextEditingController(text: "100");  
  final items = <String>[].obs;
  RxInt columnResult = 1.obs;  

  void slider(value){
    numberCount.value = value;
  }

  void generate(numberCount) {     
    if(validateInputNumber(minMumNumber.text,maxiMumNumber.text)){ 
      generateNumber(minMumNumber.text,maxiMumNumber.text,numberCount); 
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

  void generateNumber(min,max,numberCount){  
    switch (numberCount) {
      case 1:
        columnResult.value = 1;
        if (items.isNotEmpty) {
          items.clear();
        }
        items.add((int.parse(min) + Random().nextInt(int.parse(max) - int.parse(min))).toString());
        break;
      case 2:
        columnResult.value = 2;
        if(items.isNotEmpty) {
          items.clear();
        } 
        for (var i = 0; i < numberCount; i++) {
          items.add((int.parse(min) + Random().nextInt(int.parse(max) - int.parse(min))).toString()); 
        } 
        break;
      case 3:
        columnResult.value = 3;
        if(items.isNotEmpty) {
          items.clear();
        } 
        for (var i = 0; i < numberCount; i++) {
          items.add((int.parse(min) + Random().nextInt(int.parse(max) - int.parse(min))).toString()); 
        } 
        break;
      default:
        columnResult.value = 3; 
        if(items.isNotEmpty){
          items.clear();
        }
        for (var i = 0; i < numberCount; i++) {
          items.add((int.parse(min) + Random().nextInt(int.parse(max) - int.parse(min))).toString()); 
        } 
    } 
  }


}