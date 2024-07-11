import 'package:flutter/material.dart';
import 'package:flutter_app_s/pages/sejour_page.dart';
import 'package:flutter_app_s/models/sejour.dart';
import 'package:flutter_app_s/services/api_service.dart';

class StartPage extends StatefulWidget {
  final int medecinId; // Définir la propriété medecinId ici

  const StartPage({Key? key, required this.medecinId})
      : super(key: key); // Modifier le constructeur

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late Future<List<Sejour>> futureSejours;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureSejours = apiService
        .getSejoursByMedecin(widget.medecinId); // Utiliser widget.medecinId
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil Médecin"),
        centerTitle: true,
        backgroundColor: const Color(0xFF22949B),
      ),
      body: FutureBuilder<List<Sejour>>(
        future: futureSejours,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun séjour trouvé'));
          } else {
            final sejours = snapshot.data!;
            return ListView.builder(
              itemCount: sejours.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sejours[index].motif),
                  subtitle: Text(
                      'Début: ${sejours[index].dateDebut} - Fin: ${sejours[index].dateFin}'),
                  onTap: () {
                    // Naviguer vers la page de détails du séjour
                    Navigator.pushNamed(
                      context,
                      '/sejour',
                      arguments: sejours[index].id,
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
