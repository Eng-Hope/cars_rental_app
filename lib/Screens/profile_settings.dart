// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vehicle_rental_app/widgets/upper.dart';
// import 'package:vehicle_rental_app/widgets/textfield_widget.dart';

// class ProfileSettings extends StatefulWidget {
//   const ProfileSettings({super.key });

//   @override
//   State <ProfileSettings> createState() =>_ProfileSettingsState();
// }

// class _ProfileSettingsState extends State <ProfileSettings> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController homeController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView (
//         child: Column (
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [

//           SizedBox(
//             height:Get.height*0.4,

//             child: Stack(
//               children: [
//                upper(),

//                Align (
//             alignment:Alignment.bottomCenter,
//              child: Container(
//               width: 120,
//               height: 120,
//               margin: const EdgeInsets.only(bottom:20),
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Color(0xffD6D6D6)
//                 ),
//                 child: const Center(child: Icon(Icons.camera_alt_outlined,size: 40, color: Colors.white , ),),
//               ),
              
//             ),

            
//               ],
              
            
//           ),



//         ),

//          const SizedBox(
//            height: 20,
//          )  ,

         
//         Container (
//           padding:const EdgeInsets.symmetric(horizontal:23) ,
//           child: Column (
//             children: [
//               textFieldWidget('Name', Icons.person_2_outlined,nameController),
//               const SizedBox(
//                 height: 10,
//               ),
//               textFieldWidget( 'Home address',Icons.home_outlined, homeController),

//               const SizedBox(
//                 height:10,
//               ),
//               textFieldWidget('Phone number', Icons.phone_android_outlined, phoneController),

//               const SizedBox( 
//                 height: 10,
//               ),
              

//               ], )

         

//           ),
//     ]  ),
//       ),
        
            
//           );

        
        
    
//   }
// }