import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/api_service.dart';
import '../models/medicament.dart';

class AddPrescriptionPage extends StatefulWidget {
  final int sejourId;
  final int medecinId;

  const AddPrescriptionPage({
    super.key,
    required this.sejourId,
    required this.medecinId,
  });

  @override
  _AddPrescriptionPageState createState() => _AddPrescriptionPageState();
}

class _AddPrescriptionPageState extends State<AddPrescriptionPage> {
  final TextEditingController libelleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController posologieController = TextEditingController();
  final TextEditingController dateDebutController = TextEditingController();
  final TextEditingController dateFinController = TextEditingController();

  List<Medicament> medicaments = [];
  Medicament? selectedMedicament;

  @override
  void initState() {
    super.initState();
    _fetchMedicaments();
  }

  Future<void> _fetchMedicaments() async {
    try {
      final fetchedMedicaments = await ApiService().fetchMedicaments();
      setState(() {
        medicaments = fetchedMedicaments;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erreur lors du chargement des médicaments: $e')),
      );
    }
  }

  void _addPrescription(BuildContext context) async {
    final libelle = libelleController.text;
    final description = descriptionController.text;
    final posologie = posologieController.text;
    final dateDebut = dateDebutController.text;
    final dateFin = dateFinController.text;

    if (libelle.isNotEmpty &&
        description.isNotEmpty &&
        selectedMedicament != null &&
        posologie.isNotEmpty &&
        dateDebut.isNotEmpty &&
        dateFin.isNotEmpty) {
      final success = await ApiService().addPrescription({
        'libelle': libelle,
        'description': description,
        'datePrescription': DateTime.now().toIso8601String(),
        'medecinId': widget.medecinId,
        'sejourId': widget.sejourId,
        'medicamentId': selectedMedicament!.id,
        'posologie': posologie,
        'dateDebut': dateDebut,
        'dateFin': dateFin,
      });
      if (success['success']) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Erreur lors de l\'ajout de la prescription.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter une prescription"),
        backgroundColor: const Color(0xFF22949B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              const SizedBox(height: 16),
              DropdownButtonFormField<Medicament>(
                value: selectedMedicament,
                items: medicaments.map((medicament) {
                  return DropdownMenuItem<Medicament>(
                    value: medicament,
                    child: Text(medicament.nom),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMedicament = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Médicament'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: posologieController,
                decoration: const InputDecoration(labelText: 'Posologie'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: dateDebutController,
                decoration: const InputDecoration(
                    labelText: 'Date de début (yyyy-MM-dd)'),
                keyboardType: TextInputType.datetime,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: dateFinController,
                decoration: const InputDecoration(
                    labelText: 'Date de fin (yyyy-MM-dd)'),
                keyboardType: TextInputType.datetime,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _addPrescription(context),
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
      ),
    );
  }
}
