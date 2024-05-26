// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});
//
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//   final LatLng _center = const LatLng(37.42796133580664, -122.085749655962);
//   final Set<Marker> _markers = {};
//   final Set<Polyline> _polylines = {};
//   late TextEditingController sourceController;
//   late TextEditingController destinationController;
//
//   @override
//   void initState() {
//     super.initState();
//     sourceController = TextEditingController();
//     destinationController = TextEditingController();
//
//   }
//
//   @override
//   void dispose() {
//     sourceController.dispose();
//     destinationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map'),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(
//               target: _center,
//               zoom: 11.0,
//             ),
//             markers: _markers,
//             polylines: _polylines,
//           ),
//           Positioned(
//             top: 10,
//             left: 10,
//             right: 10,
//             child: Column(
//               children: [
//                 TextField(
//                   controller: sourceController,
//                   decoration: InputDecoration(
//                     labelText: 'Source',
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.clear),
//                       onPressed: () {
//                         sourceController.clear();
//                       },
//                     ),
//                   ),
//                 ),
//                 TextField(
//                   controller: destinationController,
//                   decoration: InputDecoration(
//                     labelText: 'Destination',
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.clear),
//                       onPressed: () {
//                         destinationController.clear();
//                       },
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: _onShowRoutePressed,
//                   child: const Text('Show Route'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   Future<void> _onShowRoutePressed() async {
//     final String sourceText = sourceController.text.trim();
//     final String destinationText = destinationController.text.trim();
//
//     if (sourceText.isNotEmpty && destinationText.isNotEmpty) {
//       final LatLng? sourceLatLng = _getLatLngFromString(sourceText);
//       final LatLng? destinationLatLng = _getLatLngFromString(destinationText);
//
//       if (sourceLatLng != null && destinationLatLng != null) {
//         _markers.clear();
//         _markers.add(
//           Marker(
//             markerId: const MarkerId('Source'),
//             position: sourceLatLng,
//             infoWindow: const InfoWindow(title: 'Source'),
//           ),
//         );
//         _markers.add(
//           Marker(
//             markerId: const MarkerId('Destination'),
//             position: destinationLatLng,
//             infoWindow: const InfoWindow(title: 'Destination'),
//           ),
//         );
//
//         // Draw polyline between source and destination
//         _drawRoute(sourceLatLng, destinationLatLng);
//
//         _fitMarkersBounds(sourceLatLng, destinationLatLng);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Invalid source or destination coordinates'),
//           ),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please enter both source and destination coordinates'),
//         ),
//       );
//     }
//   }
//
//   LatLng? _getLatLngFromString(String coordinateString) {
//     try {
//       final coordinates = coordinateString.split(',');
//       if (coordinates.length != 2) return null;
//       final lat = double.parse(coordinates[0].trim());
//       final lng = double.parse(coordinates[1].trim());
//       return LatLng(lat, lng);
//     } catch (e) {
//       return null;
//     }
//   }
//
//   void _drawRoute(LatLng source, LatLng destination) {
//     _polylines.clear();
//     _polylines.add(Polyline(
//       polylineId: const PolylineId('Route'),
//       points: [source, destination],
//       color: Colors.blue,
//       width: 3,
//     ));
//   }
//
//   void _fitMarkersBounds(LatLng source, LatLng destination) {
//     final bounds = LatLngBounds(southwest: source, northeast: destination);
//     mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
//   }
// }
