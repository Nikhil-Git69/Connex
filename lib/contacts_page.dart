import 'package:flutter/material.dart';
import 'package:connex/add_contacts.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final TextEditingController SearchController = TextEditingController();
  final FocusNode SearchFocusNode = FocusNode();
  bool isFocused = false;

@override
  void initState() {

    super.initState();

    SearchFocusNode.addListener((){
      setState(() {
        isFocused = SearchFocusNode.hasFocus;

      });
    });

    SearchController.addListener((){
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('My Contacts', style:
            TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddContacts()));
            },
                icon: Icon(Icons.add, color: Colors.white, size: 35,)),
          ],

        ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              controller: SearchController,
              focusNode: SearchFocusNode,
              decoration: InputDecoration(
                hintText: 'Search Contacts',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade400,),

                suffixIcon: ( isFocused )
                    ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    SearchController.clear();
                    FocusScope.of(context).unfocus();
                  },
                ) : null,
                filled: true,
                fillColor: Colors.grey[900],

                enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Colors.grey.shade900,
                      width: 1.5,
                    ),
                  ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.white38,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),

          Divider(
            color: Colors.grey.shade900,
            indent: 15,
            endIndent: 15,
          ),


        ],
      ),
    );
  }
}

