import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart'; 
import 'package:randnum_generator/view/historyScreen.dart';
import 'package:randnum_generator/view/homeScreen.dart';
import 'controller/navigation_controller.dart'; 
void main() async {  
  WidgetsFlutterBinding.ensureInitialized(); 
  unawaited(MobileAds.instance.initialize());
  runApp(RandnumGenerator());
}

class RandnumGenerator extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      home: MainScreen(), 
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  final NavigationController navController = NavigationController(); 
  
  final List<Widget> screens = [
    Homescreen(),
    Historyscreen()
  ];
 
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: Obx(() => screens[navController.selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        currentIndex: navController.selectedIndex.value,
        onTap: navController.changePage,
        selectedItemColor: Colors.white, 
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home) ,label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history),label: 'History')
        ], 
      )),
    );
  }
}