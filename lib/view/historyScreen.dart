import 'package:flutter/material.dart';

class Historyscreen extends StatelessWidget {
  const Historyscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context,index) {
          return Padding(
              padding:EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "100000000",
                    style: TextStyle(
                      fontSize: 20
                    )
                  ),
                  ElevatedButton.icon(
                    onPressed: () => {
                      
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
    );
  }
}