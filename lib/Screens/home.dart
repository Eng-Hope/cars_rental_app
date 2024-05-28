import "package:flutter/material.dart";
import "package:rental_app/Screens/car.dart";
import "package:rental_app/authentication/login_screen.dart";
import "package:rental_app/functionalities/data.dart";

import "home_drawer.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    if (supabase.auth.currentUser == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: const HomeDrawer(),
      body: FutureBuilder(
          future: allAvailableCars(),
          builder:
              (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("failed to fetch data"),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text("No Data Found"),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final car = snapshot.data![index];
                    return Car(car: car);
                  });
            }
          }),
    );
  }
}
