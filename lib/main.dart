import 'package:flutter/material.dart';
import 'package:rental_app/Screens/car.dart';
import 'package:rental_app/Screens/home.dart';
import 'package:rental_app/Screens/home_drawer.dart';
import 'package:rental_app/authentication/login_screen.dart';
import 'package:rental_app/functionalities/data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url:'https://puodfumpmuonqcadrrhb.supabase.co',
    anonKey:'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB1b2RmdW1wbXVvbnFjYWRycmhiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM2MTQ1NzEsImV4cCI6MjAyOTE5MDU3MX0.YSXYkmZ0gNaOVBULo-lyqzNCMyV6-ZbCCP9zrNwYkNU',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final _sup = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Renting App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: _sup.auth.currentUser == null? const LoginScreen(): const Home() ,
    );
  }
}

