import 'package:flutter/material.dart';
import 'package:rental_app/Screens/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}


class _OrderScreenState extends State<OrderScreen> {
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //    appBar: AppBar(title: const Text("Your order")),
  //    body: Card(
  //      child: Center(
  //        child: Column(
  //          mainAxisAlignment: MainAxisAlignment.center,
  //          children: <Widget>[
  //           Card(
  //             child: Expanded(child: Column(
  //               children: [
  //                 SizedBox(
  //                   child: ,
  //                 )
  //               ],
  //             ),),
  //           ),
  //            Text(
  //              "Your order",
  //              style: Theme.of(context).textTheme.headline6,
  //            ),
  //            SizedBox(
  //             child: ElevatedButton(onPressed: () {
  //                Navigator.push(context, MaterialPageRoute(builder: (c) => const MapScreen()));
  //             }, child: Text("CheckOut"),)
  //            )
  //          ],
  //        ),
  //      ),
  //    ),
  //   );
  //}
  final _future = Supabase.instance.client.from('Cars').select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Orders Description ",
      
      ),),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final cars = snapshot.data!;
           
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                          title: Image.network(
                            cars[0]['imageUrl'],
                            fit: BoxFit.fill,
                          ),
                          
                  ),
                ),
                ),
                Card(
                  child: 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cars[0]['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ),
                Card(child: 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Price: ${cars[0]['price']}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                ),
                Card ( child: 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Model: ${cars[0]['model']}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                ),
               
             Center(
              
              child: ElevatedButton(onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (c) => const Home()));
              }, child: const Text("Choose Route"),)
             )
              ],
            ),
          );
        },
      ),
    );
  }
}

class MapScreen {
  const MapScreen();
}
