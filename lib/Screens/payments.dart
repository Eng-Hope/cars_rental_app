import 'package:flutter/material.dart';
import 'package:rental_app/Screens/car_description.dart';
import 'package:rental_app/Screens/home_drawer.dart';
import 'package:rental_app/authentication/login_screen.dart';
import 'package:rental_app/functionalities/data.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    if (supabase.auth.currentUser == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
    return Scaffold(
        drawer: const HomeDrawer(),
        appBar: AppBar(
          title: const Text('Payments'),
          actions: [
            IconButton(
              onPressed: () => {setState(() {})},
              icon: const Icon(
                Icons.refresh,
                size: 27,
              ),
            ),
          ],
        ),
        body: FutureBuilder(
            future: getPaymentList(supabase.auth.currentUser!.id),
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
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final payment = snapshot.data![index];

                      Color? color = Colors.yellow[800];
                      if (payment['Status'].toString() == 'Accepted') {
                        color = Colors.green;
                      } else if (payment['Status'].toString() == 'Rejected') {
                        color = Colors.redAccent;
                      }

                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        child: ListTile(
                          tileColor: Colors.black12,
                          leading: GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CarDescription(
                                    id: payment['carId'].toString(),
                                  ),
                                ),
                              ),
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(payment['Cars']['imageUrl']),
                            ),
                          ),
                          title: Text('${payment['totalPrice']} Tsh/='),
                          subtitle: Text(
                              '${payment['Cars']['name']} (${payment['Cars']['model']})'),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Text(
                                  'At ${payment['Date'].toString()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                'On ${payment['time'].toString()}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              )),
                              Expanded(
                                child: Text(
                                  payment['Status'].toString(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            }));
  }
}
