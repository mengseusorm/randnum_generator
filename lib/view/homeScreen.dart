import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';   
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
        backgroundColor: Color(0xFF323437),
        appBar: AppBar(
          title: Text("RandNum Generator",style: TextStyle(color: Colors.white),),
          backgroundColor: Color(0xFF323437),
        ),
        body: Obx(() =>  Padding(
          padding: EdgeInsets.all(20),
          child: ListView( 
            children: [ 
              SizedBox(height: 20),
              Text(
                "Number Count: ${generateController.numberCount.toInt()}",
                style: TextStyle(color: Color(0xFFd1d0c5)) 
              ),
              SizedBox(height: 5,), 
              Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), 
                color: Color(0xFFe2b714)
              ),child:Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [ 
                      Text("1"),
                      Expanded( 
                        child: CupertinoSlider(
                          activeColor: Color(0xFF323437),
                          value: generateController.numberCount.value,
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
              Text("How many number?",style: TextStyle(color: Color(0xFFd1d0c5)),),   
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Color(0xFFd1d0c5)), 
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
                      style: TextStyle(
                        color: Color(0xFFd1d0c5)
                      ),
                    ),
                  ),
                  SizedBox(width: 10,), 
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Color(0xFFd1d0c5)),
                      decoration: InputDecoration(
                        // labelText: "Maximum Number",
                        labelStyle: TextStyle(color: Color(0xFFd1d0c5)),
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
              SizedBox(height: 10,),  
              Text(
                "Result",
                style: TextStyle(color: Color(0xFFd1d0c5)),
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
                        color: Color(0xFFd1d0c5),
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
                  backgroundColor: Color(0xFFe2b714),   
                ),
                child: Text(
                  "Generate",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17
                  ),
                ),
              ),)
            ],
          ),
        ))
      ));
  }
}