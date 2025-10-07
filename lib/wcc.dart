import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trackside_app/funct/scraper_retrieval.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trackside_app/home.dart';
import 'package:trackside_app/wdc.dart';

class ConstructorsPage extends StatelessWidget {
  const ConstructorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sort constructors by points in descending order
    final teamEntries = constructorsPoints.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 49, 49),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Logo on left, text on right
                children: [
                  Image.asset(
                    'images/TracksideLogo.png', 
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
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

          // 🔹 Team list
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 100, 12, 90),
              child: ListView.builder(
                itemCount: teamEntries.length,
                itemBuilder: (context, index) {
                  final teamName = teamEntries[index].key;
                  final int points = teamEntries[index].value;
                  final String logoPath = 'images/F1_Team_Logos/$teamName.png'; // Match pubspec.yaml

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: _glassTeamCard(
                      position: index + 1,
                      teamName: teamName,
                      points: points,
                      logoPath: logoPath,
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
                  children: [
                    // LEFTMOST BUTTON → Drivers Championship
                    ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const DriversPage()),
                            );
                          },
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
                            child: Icon(MdiIcons.racingHelmet, color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    // MIDDLE BUTTON → Home Page
                    ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            );
                          },
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
                            child: Icon(MdiIcons.garageVariant, color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    // RIGHTMOST BUTTON → Constructors Championship (current page)
                    ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.6),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Icon(MdiIcons.trophy, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassTeamCard({
    required int position,
    required String teamName,
    required int points,
    required String logoPath,
  }) {
    final color = teamColors[teamName] ?? Colors.grey;

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
              // Team logo
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: Image.asset(
                    logoPath,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print("Error loading logo at $logoPath: $error"); // Debug log
                      return Container(
                        width: 56,
                        height: 56,
                        color: Colors.grey,
                        child: const Icon(Icons.error, color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Team info
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$position. $teamName",
                    style: GoogleFonts.racingSansOne(
                      fontSize: 18,
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