import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';  
import 'package:toggle_switch/toggle_switch.dart'; 
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
        appBar: AppBar(
          title: Text("RandNum Generator",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blueAccent,
        ),
        body: Obx(() =>   Padding(
          padding: EdgeInsets.all(10),
          child: ListView( 
            children: [ 
              Text(
                "Number Count: ${generateController.numberCount.toInt()}", 
              ),
              Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), 
                color: Colors.amber
              ),child:Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [ 
                      Text("1"),
                      Expanded( 
                        child: CupertinoSlider(
                          activeColor: CupertinoColors.activeBlue,
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
              SizedBox(height: 20),
              Text("No duplicate number"),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), 
                    color: Colors.amber
                  ),child:Padding(
                  padding: EdgeInsets.all(5),
                  child: ToggleSwitch( 
                    minWidth: double.infinity, 
                    cornerRadius: 20.0,
                    // initialLabelIndex: toggleController.currentIndexToggle.value,
                    inactiveBgColor: Colors.white,
                    activeBgColor: [Colors.blueAccent],
                    totalSwitches: 2, 
                    labels: ['Duplicate', 'None'],
                    onToggle: (index) {
                      // toggleController.currentIndex(index); 
                    },
                  ),
                ) ,
              ),
              SizedBox(height: 20,), 
              Text("How many number?"),   
              SizedBox(height: 10,),
              Text(
                "Minimum Number"
              ),
              TextField(
                controller: generateController.minMumNumber,
                textAlign: TextAlign.start, 
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9) 
                ],
              ), 
              Text(
                "Maximum Number"
              ),
              TextField(
                controller: generateController.maxiMumNumber,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9)
                ],
              ), 
              SizedBox(height: 10,),  
              Text("Result"),
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
              ElevatedButton( 
                onPressed: () => { 
                  generateController.generate(generateController.numberCount.toInt())
                },  
                style: ElevatedButton.styleFrom( 
                  backgroundColor: Colors.blueAccent,  
                ),
                child: Text(
                  "Start Generate",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ), 
            ],
          ),
        ))
      ));
  }
}