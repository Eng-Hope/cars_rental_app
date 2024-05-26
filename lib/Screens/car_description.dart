import 'package:flutter/material.dart';
import 'package:rental_app/Screens/car_booking.dart';
import 'package:rental_app/Screens/home_drawer.dart';
import 'package:rental_app/functionalities/data.dart';

class CarDescription extends StatelessWidget {
  final String id;
  const CarDescription({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final adjustedWidth = screenWidth - 40;
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text('Car Description'),
      ),
      body: FutureBuilder(
        future: getCar(id),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No Data Found"),
            );
          } else {
            final car = snapshot.data!;
            final price = car["price"].toString();
            final name = car["name"].toString();
            final model = car["model"].toString();
            final transportType = car['transportType'].toString();
            final serviceType = car['serviceType'].toString();
            final imageUrl = car['imageUrl'].toString();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$name $model',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: adjustedWidth,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Service Type: $serviceType',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Transport Type: $transportType',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Price : $price Tsh /= per hour',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarBooking(
                              id: id,
                              price: price,
                              model: model,
                              name: name,
                              transportType: transportType,
                              serviceType: serviceType,
                              imageUrl: imageUrl),
                        ),
                      ),
                    },
                    child: const Text(
                      'Book now',
                      style: TextStyle(
                        color: Colors.white,
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
