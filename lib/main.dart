import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randnum_generator/view/historyScreen.dart';
import 'package:randnum_generator/view/homeScreen.dart';
import 'controller/navigation_controller.dart';
void main() {
  runApp(RandnumGenerator());
}

class RandnumGenerator extends StatelessWidget {
  const RandnumGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
      title: "Flutter GetX BottomNav",
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
        currentIndex: navController.selectedIndex.value,
        onTap: navController.changePage,
        selectedItemColor: Colors.blueAccent, 
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined) ,label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history),label: 'History')
        ], 
      )),
    );
  }
}