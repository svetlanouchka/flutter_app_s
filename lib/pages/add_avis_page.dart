import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddAvisPage extends StatelessWidget {
  final int sejourId;
  final int medecinId;
  final TextEditingController libelleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  AddAvisPage({super.key, required this.sejourId, required this.medecinId});

  void _addAvis(BuildContext context) async {
    final libelle = libelleController.text;
    final description = descriptionController.text;
    final date = DateTime.now().toString();

    if (libelle.isNotEmpty && description.isNotEmpty) {
      final apiService = ApiService();
      final response = await apiService.addAvis(
          libelle, date, description, medecinId, sejourId);

      if (response['success']) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de l\'ajout de l\'avis.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un avis"),
        backgroundColor: const Color(0xFF22949B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: libelleController,
              decoration: const InputDecoration(labelText: 'Libellé'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _addAvis(context),
              child: const Text("Ajouter"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF22949B),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
