class Contact {
  final int? id;
  final String name;
  final String number;
  final String? email;
  final String? notes;
  final bool isFavorite;

  Contact({
    this.id,
    required this.name,
    required this.number,
    this.email,
    this.notes,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'email': email,
      'notes': notes,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'] ?? '',
      number: map['number'] ?? '',
      email: map['email'],
      notes: map['notes'],
      isFavorite: map['isFavorite'] == 1,
    );
  }

  Contact copyWith({
    int? id,
    String? name,
    String? number,
    String? email,
    String? notes,
    bool? isFavorite,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.number,
      email: email ?? this.email,
      notes: notes ?? this.notes,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
