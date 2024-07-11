import 'dart:convert';

class Medicament {
  int id;
  String nom;
  String description;

  Medicament({
    required this.id,
    required this.nom,
    required this.description,
  });

  factory Medicament.fromJson(Map<String, dynamic> json) {
    return Medicament(
      id: json['id'],
      nom: json['nom'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'description': description,
    };
  }
}
