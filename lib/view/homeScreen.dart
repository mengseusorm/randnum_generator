import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';   
import 'package:randnum_generator/controller/generate_controller.dart';

class Homescreen extends StatelessWidget { 
  final GenerateController generateController = Get.put(GenerateController());  

  @override
  Widget build(BuildContext context) { 
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold( 
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("RandNum Generator",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blueAccent,
        ),
        body: Obx(() => 
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: ListView( 
                    children: [  
                      SizedBox(height: 20),
                      Text(
                        "How many numbers: ${generateController.numberCount.toInt()}",
                      ), 
                      SizedBox(height: 10,),
                      Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30), 
                        color: Color(0xFFe8e8e8)
                      ),child:Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [ 
                              Text("1"),
                              Expanded( 
                                child: CupertinoSlider(
                                  activeColor: Color(0xFF323437),
                                  value: generateController.numberCount.value,
                                  thumbColor: Colors.white,
                                  min: 1,
                                  max: 10, 
                                  divisions: 9,   
                                  onChanged: (value) => {  
                                    generateController.slider(value)
                                  }), 
                              ),
                              Text("10")
                            ],
                          )
                        ),
                      ) , 
                      SizedBox(height: 20,), 
                      Text("Range of numbers"),   
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ 
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),  
                              ),
                              controller: generateController.minMumNumber,
                              textAlign: TextAlign.start, 
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(9) 
                              ],
                            ),
                          ),
                          SizedBox(width: 10,),
                          Center(
                            child: Text(
                              "TO",
                            ),
                          ),
                          SizedBox(width: 10,), 
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder() 
                              ),
                              controller: generateController.maxiMumNumber,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(9)
                              ], 
                            ),
                          ),  
                        ],
                      ), 
                      SizedBox(height: 20),
                      Text(
                        "Result",
                      ),
                      GridView.count(
                        crossAxisCount: generateController.columnResult.value,
                        childAspectRatio: 2.0, 
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 40,
                        shrinkWrap: true, // Important to make GridView work inside other scrollable widgets
                        physics: NeverScrollableScrollPhysics(), // Prevents nested scrolling issues
                        children: List.generate(generateController.items.length, (index) {
                          return Center(
                            child: Text(
                              generateController.items[index],
                              style: TextStyle(
                                fontSize: 
                                  generateController.columnResult.value == 1 ? 70 : 
                                  generateController.columnResult.value == 2 ? 33 :
                                  generateController.columnResult.value == 3 ? 20 : 20
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 15),  
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(  
                        onPressed: () => { 
                          generateController.generate(generateController.numberCount.toInt(),generateController.allowDuplicateNumber.value)
                        },  
                        style: ElevatedButton.styleFrom( 
                          backgroundColor: Colors.blueAccent,   
                        ),
                        child: Text(
                          "Generate",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white
                          ),
                        ),
                      ),), 
                    ],
                  ),
                )
              ),
               Obx(() => generateController.isAdLoaded.value  ? 
                  Container(
                      alignment: Alignment.center,
                      width: generateController.bannerAd.size.width.toDouble(),
                      height: generateController.bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: generateController.bannerAd),
                  ) : Container(),
                ),   
              ]
            ),
        )
    ));
  }
}