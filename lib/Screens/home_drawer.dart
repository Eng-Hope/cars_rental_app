import 'package:flutter/material.dart';
import 'package:rental_app/Screens/home.dart';
import 'package:rental_app/Screens/payments.dart';
import 'package:rental_app/main.dart';
import '../authentication/login_screen.dart';
import '../functionalities/auth.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: <Widget>[
      UserAccountsDrawerHeader(
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.orange,
          child: Text(
            '${supabase.auth.currentUser?.email?[0]}',
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        accountName: Text('${supabase.auth.currentUser?.email}'),
        accountEmail: Text('${supabase.auth.currentUser?.email}'),
      ),
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyApp(),
            ),
          ),
        },
      ),
      ListTile(
        leading: const Icon(Icons.check_box_outline_blank_sharp),
        title: const Text(
          'Services',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        onTap: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const Home()))
        },
      ),
      ListTile(
        leading: const Icon(Icons.wallet),
        title: const Text(
          'Payments',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Payments(),
            ),
          ),
        },
      ),
      ListTile(
          leading: const Icon(Icons.logout),
          title: isLoading
              ? const Center(child: CircularProgressIndicator(color: Colors.black12, strokeWidth: 15,))
              : const Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
          onTap: () async {
            try{
              setState(() {
                isLoading = true;
              });
              await supabase.auth.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const LoginScreen(),
                ),
              );
            }
            catch(e){
              print(e);
              setState(() {
                isLoading = false;
              });
            }

          }),
    ]));
  }
}
