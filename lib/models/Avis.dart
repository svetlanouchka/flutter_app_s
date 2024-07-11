import 'dart:convert';

class Avis {
  int id;
  String libelle;
  DateTime date;
  String description;
  int medecinId;
  int sejourId;

  Avis({
    required this.id,
    required this.libelle,
    required this.date,
    required this.description,
    required this.medecinId,
    required this.sejourId,
  });

  factory Avis.fromJson(Map<String, dynamic> json) {
    return Avis(
      id: json['id'],
      libelle: json['libelle'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      medecinId: json['medecin_id'],
      sejourId: json['sejour_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'libelle': libelle,
      'date': date.toIso8601String(),
      'description': description,
      'medecin_id': medecinId,
      'sejour_id': sejourId,
    };
  }
}
