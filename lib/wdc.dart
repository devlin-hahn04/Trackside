import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trackside_app/funct/scraper_retrieval.dart';
import 'package:google_fonts/google_fonts.dart';


// Team colors
Map<String, Color> teamColors = {
  "Red Bull": const Color(0xFF1E5BC6),
  "Ferrari": const Color(0xFFDC0000),
  "Mercedes": const Color(0xFF00D2BE),
  "McLaren": const Color(0xFFFF8700),
  "Aston Martin": const Color(0xFF006F62),
  "Alpine": const Color(0xFF2293D1),
  "Williams": const Color(0xFF005AFF),
  "RB": const Color(0xFF6692FF),
  "Haas": const Color(0xFFB6BABD),
  "Sauber": const Color(0xFF52E252),
};

class DriversPage extends StatelessWidget {
  const DriversPage({super.key});

  @override
  Widget build(BuildContext context) {
    final driverEntries = driversData.entries.toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🔹 Background image
          SizedBox.expand(
            child: Image.asset(
              'images/WDCPage.png', 
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.topRight, // moves it all the way to the right
              child: Padding(
                padding: const EdgeInsets.all(16.0), // optional spacing from edges
                child: Row(
                  mainAxisSize: MainAxisSize.min, // so row wraps its content
                  children: [
                    const SizedBox(width: 12),
                    Text(
                      'Drivers Championship',
                      style: GoogleFonts.racingSansOne(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          // 🔹 Driver list
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 100, 12, 90),
              child: ListView.builder(
                itemCount: driverEntries.length,
                itemBuilder: (context, index) {
                  final driverName = driverEntries[index].key;
                  final driverInfo = driverEntries[index].value;
                  final int points = driverInfo["points"];
                  final String team = driverInfo["team"];
                  final String? photoUrl = driverPhotos[driverName];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: _glassDriverCard(
                      position: index + 1,
                      driverName: driverName,
                      points: points,
                      team: team,
                      photoUrl: photoUrl,
                    ),
                  );
                },
              ),
            ),
          ),

          // 🔹 Bottom nav bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: _glassContainer(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    3,
                    (_) => ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.4),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: const Icon(Icons.crop_square, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassDriverCard({
    required int position,
    required String driverName,
    required int points,
    required String team,
    String? photoUrl,
  }) {
    final color = teamColors[team] ?? Colors.grey;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              // Driver photo
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: photoUrl != null
                      ? Image.network(
                          photoUrl,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 56,
                          height: 56,
                          color: Colors.grey,
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(width: 12),

              // Driver info
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$position. $driverName",
                    style: GoogleFonts.racingSansOne(
                      fontSize: 18, // slightly bigger
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "$points pts",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassContainer({required double height, required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: child,
        ),
      ),
    );
  }
}
