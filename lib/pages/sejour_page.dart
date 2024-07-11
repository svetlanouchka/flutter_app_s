import 'package:flutter/material.dart';
import 'add_avis_page.dart';
import 'add_prescription_page.dart';
import '../models/sejour.dart';
import '../services/api_service.dart';

class SejourPage extends StatelessWidget {
  final int sejourId;
  final int medecinId;

  const SejourPage({Key? key, required this.sejourId, required this.medecinId})
      : super(key: key);

  Future<Sejour> fetchSejourDetails() async {
    return ApiService().getSejourDetails(sejourId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails du Séjour"),
        backgroundColor: const Color(0xFF22949B),
      ),
      body: FutureBuilder<Sejour>(
        future: fetchSejourDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Détails du séjour non trouvés'));
          } else {
            final sejour = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Motif: ${sejour.motif}"),
                  Text("Date début: ${sejour.dateDebut}"),
                  Text("Date fin: ${sejour.dateFin}"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAvisPage(
                              sejourId: sejourId, medecinId: medecinId),
                        ),
                      );
                    },
                    child: const Text("Ajouter un avis"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22949B),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddPrescriptionPage(
                              sejourId: sejour.id, medecinId: medecinId),
                        ),
                      );
                    },
                    child: const Text("Ajouter une prescription"),
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
            );
          }
        },
      ),
    );
  }
}
