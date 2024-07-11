import 'dart:convert';

class Prescription {
  int id;
  String libelle;
  DateTime datePrescription;
  String description;
  int medecinId;
  int sejourId;

  Prescription({
    required this.id,
    required this.libelle,
    required this.datePrescription,
    required this.description,
    required this.medecinId,
    required this.sejourId,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      id: json['id'],
      libelle: json['libelle'],
      datePrescription: DateTime.parse(json['date_prescription']),
      description: json['description'],
      medecinId: json['medecin_id'],
      sejourId: json['sejour_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'libelle': libelle,
      'date_prescription': datePrescription.toIso8601String(),
      'description': description,
      'medecin_id': medecinId,
      'sejour_id': sejourId,
    };
  }
}
