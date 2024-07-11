import 'dart:convert';

class Sejour {
  int id;
  DateTime dateDebut;
  DateTime dateFin;
  String motif;
  int specialiteId;
  int userId;
  int medecinId;

  Sejour({
    required this.id,
    required this.dateDebut,
    required this.dateFin,
    required this.motif,
    required this.specialiteId,
    required this.userId,
    required this.medecinId,
  });

  factory Sejour.fromJson(Map<String, dynamic> json) {
    return Sejour(
      id: json['id'],
      dateDebut: DateTime.parse(json['date_debut']),
      dateFin: DateTime.parse(json['date_fin']),
      motif: json['motif'],
      specialiteId: json['specialite_id'],
      userId: json['user_id'],
      medecinId: json['medecin_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date_debut': dateDebut.toIso8601String(),
      'date_fin': dateFin.toIso8601String(),
      'motif': motif,
      'specialite_id': specialiteId,
      'user_id': userId,
      'medecin_id': medecinId,
    };
  }
}
