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
  String name = "";

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
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                height: 50,
                child: TextField(
                  style: const TextStyle(
                    fontSize: 20
                  ),
                  onChanged: (value){
                   setState(() {
                     name = value;
                   });
                 },
                  decoration: InputDecoration(
                    hintText: 'Search for rooms',
                    hintStyle: const TextStyle(fontSize: 17),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )
                  ),
                ),
              ),
            ),
            Expanded(child: FutureBuilder(
                future: allAvailableCars(name),
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
                }),)
          ],
        ),
      ),
    );
  }
}
