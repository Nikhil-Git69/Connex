
import 'package:connex/edit_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:connex/Data/database_helper.dart';
import 'package:connex/Data/contact_model.dart';

class ContactDetailPage extends StatefulWidget {
  final Contact contact;

  const ContactDetailPage({super.key, required this.contact});

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  late Contact _contact;

  @override
  void initState() {
    super.initState();
    _contact = widget.contact;
  }

  Future<void> _toggleFavorite() async {
    await DatabaseHelper().toggleFavorite(_contact);
    final updatedList = await DatabaseHelper().getContacts();
    final updated = updatedList.firstWhere((c) => c.id == _contact.id);
    setState(() => _contact = updated);
  }

  Future<void> _deleteContact() async {
    final confirmed = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text("Delete Contact?", style: TextStyle(color: Colors.white)),
        content: const Text("Are you sure you want to delete this contact?",
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await DatabaseHelper().deleteContact(_contact.id!);
      if (mounted) Navigator.pop(context, true);
    }
  }

  Future<void> _handleEdit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditContactPage(contact: _contact)),
    );

    if (result == true) {
      final updatedList = await DatabaseHelper().getContacts();
      final updated = updatedList.firstWhere((c) => c.id == _contact.id);
      setState(() => _contact = updated);
      Navigator.pop(context, true); // Notify previous page to refresh
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarLetter = _contact.name.trim().isEmpty
        ? null
        : _contact.name.trim()[0].toUpperCase();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Contact", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _contact.isFavorite ? Icons.star : Icons.star_border,
              color: Colors.amber,
            ),
            onPressed: () async {
              await _toggleFavorite();
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey.shade800,
            child: avatarLetter == null
                ? const Icon(Icons.person, size: 70, color: Colors.white)
                : Text(
              avatarLetter,
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _contact.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 25),
          Divider(color: Colors.grey.shade800, thickness: 0.6),

          _infoTile("Phone", _contact.number ?? '', Icons.phone),
          _infoTile("Email", _contact.email ?? '', Icons.email),
          if (_contact.notes != null && _contact.notes!.trim().isNotEmpty)
            _infoTile("Notes", _contact.notes!, Icons.notes),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionButton(Icons.edit, "Edit", onTap: _handleEdit),
                _actionButton(Icons.delete, "Delete", color: Colors.red, onTap: _deleteContact),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String? value, IconData icon) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          subtitle: Text(
            (value == null || value.isEmpty) ? 'Not available' : value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Divider(color: Colors.grey.shade800, thickness: 0.5),
        )
      ],
    );
  }

  Widget _actionButton(IconData icon, String label,
      {VoidCallback? onTap, Color? color}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey.shade800,
            child: Icon(icon, color: color ?? Colors.white, size: 26),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: color ?? Colors.white70),
        )
      ],
    );
  }
}
