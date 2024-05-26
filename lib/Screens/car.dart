import 'package:flutter/material.dart';
import 'package:rental_app/Screens/car_description.dart';
class Car extends StatelessWidget {
  final Map<String, dynamic> car;
  const Car({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final adjustedWidth = screenWidth - 40;
    final price = car["price"].toString();
    final name = car["name"].toString();
    final model = car["model"].toString();
    final serviceType = car['serviceType'].toString();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$name  $model',
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: adjustedWidth,
              child: Image.network(
                car['imageUrl'] as String,
                fit: BoxFit.fill,
              ),),

         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text('For $serviceType services', style: const TextStyle(
                   fontSize: 16
                 ),),
                 Text('$price Tsh /= per hour', style: const TextStyle(
                   fontSize: 14,
                   fontWeight: FontWeight.w500,
                 ),),
               ],
             ),
             ElevatedButton(onPressed: ()=>{
               Navigator.push(context, MaterialPageRoute(builder: (context)=> CarDescription(id: car['id'].toString())))
             },
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.redAccent,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(2),
               ),
             ) ,
             child: const Text('View', style: TextStyle(color: Colors.white),),),
           ],
         ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
