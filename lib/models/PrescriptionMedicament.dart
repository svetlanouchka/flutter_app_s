import 'dart:convert';

class PrescriptionMedicament {
  int id;
  int prescriptionId;
  int medicamentId;
  String posologie;
  DateTime dateDebut;
  DateTime dateFin;

  PrescriptionMedicament({
    required this.id,
    required this.prescriptionId,
    required this.medicamentId,
    required this.posologie,
    required this.dateDebut,
    required this.dateFin,
  });

  factory PrescriptionMedicament.fromJson(Map<String, dynamic> json) {
    return PrescriptionMedicament(
      id: json['id'],
      prescriptionId: json['prescription_id'],
      medicamentId: json['medicament_id'],
      posologie: json['posologie'],
      dateDebut: DateTime.parse(json['date_debut']),
      dateFin: DateTime.parse(json['date_fin']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'prescription_id': prescriptionId,
      'medicament_id': medicamentId,
      'posologie': posologie,
      'date_debut': dateDebut.toIso8601String(),
      'date_fin': dateFin.toIso8601String(),
    };
  }
}
