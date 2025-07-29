import 'package:flutter/material.dart';
import 'package:connex/add_contacts.dart';
import 'package:connex/Data/database_helper.dart';
import 'package:connex/Data/contact_model.dart';
import 'package:connex/contacts_detail_page.dart';



class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool isFocused = false;
  List<Contact> allContacts = [];

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      setState(() => isFocused = searchFocusNode.hasFocus);
    });
    searchController.addListener(() => setState(() {}));
    _fetchContacts();
  }

  void _fetchContacts() async {
    final data = await DatabaseHelper().getContacts();
    setState(() => allContacts = data);
  }




  void _deleteContact(int id) async {
    await DatabaseHelper().deleteContact(id);
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = searchController.text.isEmpty
        ? allContacts
        : allContacts.where((c) =>
        c.name.toLowerCase().contains(searchController.text.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'My Contacts',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white, size: 35),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddContacts()),
              );
              if (result == true) _fetchContacts();
            },
          ),
        ],
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              style:  TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              controller: searchController,
              focusNode: searchFocusNode,
              decoration: InputDecoration(
                hintText: 'Search Contacts',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                suffixIcon: (isFocused && searchController.text.isNotEmpty)
                    ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    searchController.clear();
                    FocusScope.of(context).unfocus();
                  },
                )
                    : null,
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
                  borderSide: const BorderSide(
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

          Expanded(
            child: filtered.isEmpty
                ? const Center(
              child: Text("No Contacts Found",
                  style: TextStyle(color: Colors.white70)),
            )
                : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final contact = filtered[index];
                return GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ContactDetailPage(contact: contact),
                      ),
                    );
                    if (result == true) _fetchContacts();
                  },

                  child: ListTile(
                    title: Text(contact.name,
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Text(contact.email ?? 'No Email', style: const TextStyle(color: Colors.white60)),

                    trailing: IconButton(
                      icon: Icon(
                        contact.isFavorite ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () async {
                        await DatabaseHelper().toggleFavorite(contact);
                        _fetchContacts();
                      },
                    ),

                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
