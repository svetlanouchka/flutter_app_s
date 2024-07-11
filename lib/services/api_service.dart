import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sejour.dart';
import '../models/medicament.dart';

class ApiService {
  static const String baseUrl =
      'http://192.168.1.98/studi_ecf/soignemoi_spn/app/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    return jsonDecode(response.body);
  }

  Future<List<Sejour>> getSejoursByMedecin(int medecinId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/sejours_par_medecin.php?medecin_id=$medecinId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return jsonDecode(response.body);
  }

  Future<Sejour> getSejourDetails(int sejourId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/get_sejour_details.php?sejour_id=$sejourId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return Sejour.fromJson(responseData);
    } else {
      throw Exception('Failed to load sejour details');
    }
  }

  Future<Map<String, dynamic>> addAvis(String libelle, String date,
      String description, int medecinId, int sejourId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_avis.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'libelle': libelle,
        'date': date,
        'description': description,
        'medecin_id': medecinId,
        'sejour_id': sejourId,
      }),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> addPrescription(
      Map<String, dynamic> prescriptionData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_prescription.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(prescriptionData),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> updatePosologie(
      int prescriptionId, String newDateFin) async {
    final response = await http.post(
      Uri.parse('$baseUrl/update_posologie.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'prescription_id': prescriptionId,
        'new_date_fin': newDateFin,
      }),
    );

    return jsonDecode(response.body);
  }

  Future<List<Medicament>> fetchMedicaments() async {
    final response = await http.get(Uri.parse('$baseUrl/medicaments'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Medicament.fromJson(e)).toList();
      ;
    } else {
      throw Exception('Failed to load medicaments');
    }
  }
}
