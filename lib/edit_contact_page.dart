import 'package:flutter/material.dart';
import 'package:connex/Data/contact_model.dart';
import 'package:connex/Data/database_helper.dart';

class EditContactPage extends StatefulWidget {
  final Contact contact;

  const EditContactPage({super.key, required this.contact});

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController emailController;
  late TextEditingController notesController;

  final FocusNode nameFocus = FocusNode();

  bool isFormChanged = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.contact.name);
    numberController = TextEditingController(text: widget.contact.number);
    emailController = TextEditingController(text: widget.contact.email);
    notesController = TextEditingController(text: widget.contact.notes);

    nameFocus.requestFocus();

    nameController.addListener(_checkFormChanged);
    numberController.addListener(_checkFormChanged);
    emailController.addListener(_checkFormChanged);
    notesController.addListener(_checkFormChanged);
  }

  void _checkFormChanged() {
    setState(() {
      isFormChanged = nameController.text.trim() != widget.contact.name ||
          numberController.text.trim() != widget.contact.number ||
          emailController.text.trim() != (widget.contact.email ?? '') ||
          notesController.text.trim() != (widget.contact.notes ?? '');
    });
  }

  void _updateContact() async {
    if (_formKey.currentState!.validate()) {
      final updatedContact = widget.contact.copyWith(
        name: nameController.text.trim(),
        number: numberController.text.trim(),
        email: emailController.text.trim(),
        notes: notesController.text.trim(),
      );
      await DatabaseHelper().updateContact(updatedContact);
      Navigator.pop(context, true);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    emailController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avatarLetter = nameController.text.trim().isEmpty
        ? null
        : nameController.text.trim()[0].toUpperCase();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 80, bottom: 40),
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.grey],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: avatarLetter == null
                          ? const Icon(Icons.person, size: 90, color: Colors.white)
                          : Text(
                        avatarLetter,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 15,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 23, color: Colors.blue),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 15,
                    child: GestureDetector(
                      onTap: isFormChanged ? _updateContact : null,
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 23,
                          color: isFormChanged ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              _buildInputField("Name", nameController,
                  focusNode: nameFocus,
                  validator: (value) {
                    if (value!.trim().isEmpty) return "Name is required";
                    return null;
                  }),

              const SizedBox(height: 25),

              _buildInputField("Number", numberController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.trim().isEmpty) return "Number is required";
                    if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
                      return "Enter a valid 10-digit number";
                    }
                    return null;
                  }),

              const SizedBox(height: 25),

              _buildInputField("Email", emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) return null;
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  }),

              const SizedBox(height: 25),

              _buildNoteField("Notes", notesController),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.name,
        FocusNode? focusNode,
        String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          filled: true,
          fillColor: Colors.grey.shade900,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildNoteField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            TextFormField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              maxLines: 4,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
