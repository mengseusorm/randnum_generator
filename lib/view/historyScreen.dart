import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randnum_generator/controller/generate_controller.dart'; 

class Historyscreen extends StatelessWidget { 
  final GenerateController generateController = Get.put(GenerateController());
  @override
  Widget build(BuildContext context) {
    return  Obx(() =>  Scaffold(
      backgroundColor: Color(0xFF323437),
      appBar: AppBar(
        title: Text("History",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF323437),
        actions: [  
          generateController.item_histories.isNotEmpty ? 
          IconButton(
              onPressed: () {
                generateController.clearHistory();
              },
              icon: Icon(Icons.delete),
              color: Color(0xFFd1d0c5),) : Text("")  
        ],
      ),
      body:
        generateController.item_histories.isNotEmpty ? ListView.builder(
          itemCount: generateController.item_histories.length,
          itemBuilder: (context,index) {
            return Padding(
                padding:EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      generateController.item_histories[index],
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFd1d0c5)
                      )
                    ),
                    ElevatedButton.icon(
                      onPressed: ()  => {
                        generateController.copy(generateController.item_histories[index])
                      }, 
                      label: Text("copy"),
                      icon: Icon(Icons.copy),
                      style: ElevatedButton.styleFrom( 
                        elevation: 0, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    )
                  ],  
                ) 
            );
          }
        ) : Center(
          child: Text(
            "No Numbers Generated",
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFFd1d0c5)
            ),
          ),
        )
    ));
  }
}