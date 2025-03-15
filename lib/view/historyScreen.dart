import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:randnum_generator/controller/generate_controller.dart'; 

class Historyscreen extends StatelessWidget { 
  final GenerateController generateController = Get.put(GenerateController());
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("History", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [  
          if (generateController.item_histories.isNotEmpty)
            IconButton(
              onPressed: () {
                generateController.clearHistory();
              },
              icon: Icon(Icons.delete),
              color: Colors.white,
            )
        ],
      ),
      body: Obx(() => 
        Column(
          children: [
            Expanded(
              child: generateController.item_histories.isNotEmpty 
                ? ListView.builder(
                    itemCount: generateController.item_histories.length,
                    itemBuilder: (context, index) { 
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              generateController.item_histories[index],
                              style: TextStyle(
                                fontSize: 20,
                              )
                            ),
                            ElevatedButton.icon(
                              onPressed: () => {
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
                  ) 
                : Center(
                    child: Text(
                      "No Numbers Generated",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  )
            ),
            Container(
              child: generateController.isAdLoaded.value ? Container(
                alignment: Alignment.center,
                  width: generateController.bannerAd.size.width.toDouble(),
                  height: generateController.bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: generateController.bannerAd),
              ) : Container(),
            ), 
          ],
        )
      )  
    );
  }
}