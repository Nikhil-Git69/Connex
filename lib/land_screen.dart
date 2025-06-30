import 'package:connex/bottom_nav.dart';
import 'package:flutter/material.dart';

class LandScreen extends StatefulWidget {
  const LandScreen({super.key});

  @override
  State<LandScreen> createState() => _LandScreenState();
}

class _LandScreenState extends State<LandScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
        
          SizedBox(height: 250),
          
          Center(
            child: Container(
              child: Text("CONNEX", style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
             ),
            ),
          ),

          SizedBox(height: 75),
          
          ElevatedButton(onPressed: ()
          {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavBar()));
          },
              child: Text("Start",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
             ),
          )




        ],
      ),
    );
  }
}
