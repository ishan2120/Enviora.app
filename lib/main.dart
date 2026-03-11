import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MaterialApp(
    home: TrackingScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. THE MAP LAYER
          const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(6.9271, 79.8612), // Example: Colombo
              zoom: 14,
            ),
          ),

          // 2. THE TOP BACK BUTTON
          Positioned(
            top: 50,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
            ),
          ),

          // 3. THE INFO CARD (Bottom)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Wrap content height
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("● EN ROUTE", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  const Text("15 mins", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  const Text("Estimated arrival at your location"),
                  const SizedBox(height: 20),
                  
                  // Gray Location Box
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      children: [
                        Text("CURRENT LOCATION", style: TextStyle(fontSize: 10)),
                        Text("Kinross Avenue & Mary's Road", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Report Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
                      child: const Text("Report an Issue", style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}