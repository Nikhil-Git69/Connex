import 'package:connex/Data/contact_model.dart';
import 'package:connex/Data/database_helper.dart';
import 'package:connex/contacts_detail_page.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Contact> favorites = [];

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  void _fetchFavorites() async {
    final favs = await DatabaseHelper().getContacts(favoritesOnly: true);
    setState(() => favorites = favs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Favorite Contacts',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: favorites.isEmpty
          ? const Center(
        child: Text(
          "No Favorites Yet",
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final contact = favorites[index];
          return GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContactDetailPage(contact: contact),
                ),
              );
              if (result == true) _fetchFavorites();
            },
            child: ListTile(
              title: Text(
                contact.name,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                contact.email ?? 'No Email',
                style: const TextStyle(color: Colors.white60),
              ),
              trailing: IconButton(
                icon: Icon(
                  contact.isFavorite ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () async {
                  await DatabaseHelper().toggleFavorite(contact);
                  _fetchFavorites();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
