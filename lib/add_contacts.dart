import 'package:flutter/material.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({super.key});

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {

  TextEditingController NameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController NotesController = TextEditingController();

  bool isFormFilled = false;

  void _checkFormFilled() {
    setState(() {
      isFormFilled = NameController.text.trim().isNotEmpty ||
          NotesController.text.trim().isNotEmpty || EmailController.text.trim().isNotEmpty;

    });
  }

  @override
  void initState() {
    super.initState();

    NameController.addListener(_checkFormFilled);
    NotesController.addListener(_checkFormFilled);
    EmailController.addListener(_checkFormFilled);

  }

  @override
  void dispose() {
    NameController.dispose();
    NotesController.dispose();
    EmailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,

      body: Column(
        children: [
          Stack(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 80, bottom: 40),
                decoration: BoxDecoration(
                  color: Colors.black38,

                ),
                height: 250,
                width: double.infinity,

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                        Container(
                          height: 120,
                          width: 120,

                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                colors:[Colors.white,Colors.grey],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,


                            ),
                          ),

                          alignment: Alignment.center,
                          child: NameController.text.trim().isEmpty? Icon(Icons.person, size: 90, color: Colors.white)
                              : Text(NameController.text.trim()[0].toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),

                          )
                        )


                  ],
                )
              ),

              Positioned(
                top: 40,
                  left: 15,
                 child: GestureDetector(
                   onTap: (){
                     Navigator.pop(context);
                   },
                   child: Padding(
                     padding: const EdgeInsets.only(left: 7),
                     child: Text("Cancel",
                       style: TextStyle(
                         fontSize: 23,
                         color: Colors.blue,
                       ),),
                   ),
                 ),
              ),
              Positioned(
                top: 40,
                  right: 15,
                 child: GestureDetector(
                   onTap: (){

                   },
                   child: Padding(
                     padding: const EdgeInsets.only(left: 7),
                     child: Text("Save",
                     style: TextStyle(
                       fontSize: 23,
                       color: isFormFilled ? Colors.blue : Colors.grey,
                     ),),
                   ),
                 ),
              ),
            ],
          ),


          TextFormField(
            style: TextStyle(
              color: Colors.white,
            ),
              keyboardType: TextInputType.name,
              controller: NameController,
              decoration: InputDecoration(
                hintText: 'Full Name',
                hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                ),
                filled: true,
                fillColor: Colors.grey.shade900,


                border: InputBorder.none,

          ),

          ),
          SizedBox(height: 30,),
          TextFormField(
            style: TextStyle(
              color: Colors.white,
            ),
              keyboardType: TextInputType.emailAddress,
              controller: EmailController,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                ),
                filled: true,
                fillColor: Colors.grey.shade900,


                border: InputBorder.none,

          ),

          ),
          SizedBox(height: 30,),

          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 12, right:15),
                  child: Text("Notes", style:
                    TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
                TextFormField(
                  maxLines: 3,
                  keyboardType: TextInputType.name,
                  controller: NotesController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(

                    filled: true,
                    fillColor: Colors.grey.shade900,


                    border: InputBorder.none,

                  ),

                ),

              ],
            ),
          ),
          SizedBox(height: 30,),






        ],
      ),

    );
  }
}
