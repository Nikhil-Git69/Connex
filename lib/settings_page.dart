import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox( height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text("Settings",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,

              ),

            ),
          ),
          Divider(height: 15),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Preferences", style:
              TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Customize your experience", style:
              TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.mode_night, color: Colors.white,),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: (){

                  },
                  child: Text("Theme", style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 7),

          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Data & Backup", style:
              TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.data_usage, color: Colors.white,),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: (){

                  },
                  child: Text("Clear Data", style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.cloud, color: Colors.white,),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: (){

                  },
                  child: Text("Backup data", style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 7),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Legal Policies", style:
              TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.book, color: Colors.white,),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: (){

                  },
                  child: Text("Terms and Conditions", style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.privacy_tip, color: Colors.white,),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: (){

                  },
                  child: Text("Privacy Policy", style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 20,

                  ),
                  ),
                ),
              ],
            ),
          ),


          Divider(height: 7),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("More", style:
              TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.white,),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: (){

                  },
                  child: Text("About Us", style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  ),
                ),
              ],
            ),
          ),


          Divider(height: 7),


        ],
      ),
    );
  }
}
