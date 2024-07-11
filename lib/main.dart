import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/start_page.dart';
import 'pages/sejour_page.dart';
import 'pages/add_avis_page.dart';
import 'pages/add_prescription_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/home',
      onGenerateRoute: (settings) {
        if (settings.name == '/start') {
          final int medecinId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (context) {
              return StartPage(medecinId: medecinId);
            },
          );
        }
        if (settings.name == '/sejour') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return SejourPage(
                sejourId: args['sejourId'],
                medecinId: args['medecinId'],
              );
            },
          );
        }
        if (settings.name == '/addAvis') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return AddAvisPage(
                sejourId: args['sejourId'],
                medecinId: args['medecinId'],
              );
            },
          );
        }
        if (settings.name == '/addPrescription') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return AddPrescriptionPage(
                sejourId: args['sejourId'],
                medecinId: args['medecinId'],
              );
            },
          );
        }
        return null;
      },
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
