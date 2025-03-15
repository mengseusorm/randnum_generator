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
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text("RandNum Generator",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue,
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
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ), 
                      SizedBox(height: 10,),
                      Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30), 
                        color: Colors.white
                      ),child:Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [ 
                              Text("1"),
                              Expanded( 
                                child: CupertinoSlider(
                                  activeColor: Colors.blue,
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
                      Text(
                        "Range of numbers",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),   
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [  
                          Expanded( 
                            child: Card( 
                              margin: EdgeInsets.zero,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: TextField(  
                                  controller: generateController.minMumNumber,
                                  decoration: InputDecoration(
                                     border: InputBorder.none, 
                                  ),
                                  textAlign: TextAlign.center, 
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(9) 
                                  ],
                                  style: TextStyle(
                                    fontSize: 20, 
                                  ), 
                                ), 
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Center(
                            child: Card( 
                              color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30), // Add border radius
                                ),
                              child: Padding(
                                padding: EdgeInsets.all(10), 
                                child: Text(
                                  "TO",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,), 
                          Expanded(
                              child: Card( 
                              margin: EdgeInsets.zero,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none 
                                  ),
                                  controller: generateController.maxiMumNumber,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(9)
                                  ], 
                                  style: TextStyle(
                                    fontSize: 20,
                                  ), 
                                ), 
                              ),
                            )
                          ), 
                        ],
                      ), 
                      SizedBox(height: 20),
                      Text(
                        "Result",
                        style: TextStyle(
                          color: Colors.white
                        ),
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
                                  generateController.columnResult.value == 3 ? 20 : 20,
                                color:Colors.white 
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
                          backgroundColor: Colors.white,   
                        ),
                        child: Text(
                          "Generate",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.blue
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