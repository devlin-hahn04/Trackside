import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trackside_app/funct/scraper_retrieval.dart';
import 'package:trackside_app/wdc.dart';
import 'package:trackside_app/wcc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';



final supabase= Supabase.instance.client;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Helper to sort and get top 3 entries from a Map
  static List<MapEntry<String, int>> _getTopEntries(Map<String, int> data) {
    final entries = data.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries.take(3).toList();
  }

  String? getCurrentUserName(){    //gets current user to display in welcome bubble 

    final user= supabase.auth.currentUser;

    if(user != null){

      return user.userMetadata?['first_name'] as String?;

    }

    return null;

  }


  @override
  Widget build(BuildContext context) {

    // Directly use the globals, no loading state because data is loaded on app startup
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image
          Positioned(
            top: MediaQuery.of(context).padding.top * 0.6, // pushes it down dynamically
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'images/HomeDashboard.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            top: true,
            bottom: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome Message
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 16, left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              // Logo on the left
                              Image.asset(
                                'images/TracksideLogo.png',
                                width: 130,
                                height: 130,
                                fit: BoxFit.contain,
                              ),

                              //Welcome bubble on right 
                              _glassContainer(
                                color: Colors.red.withOpacity(.3),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), 
                                  child: Center(
                                    child: Text(
                                      'Welcome, ${getCurrentUserName() ?? 'User'}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )

                            ]

                          ),
                        ),

                        const SizedBox(height: 20),

                        // Middle Image Container (Dynamic Image for Next Race)
                        Center(
                          child: _glassContainer(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 200,
                            noPadding: true, // Optional: remove padding if you want full fill
                            child: nextRace != null
                                ? Transform.scale(
                                    scale: 1.15, // Zoom level
                                    child: Image.asset(
                                      'images/F1 tracks/${nextRace!}.jpg',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(Icons.broken_image, size: 60, color: Colors.white38),
                                        );
                                      },
                                    ),
                                  )
                                : const Center(
                                    child: Icon(Icons.image, size: 60, color: Colors.white38),
                                  ),
                          ),
                        ),



                        const SizedBox(height: 12),

                        // Next Grand Prix
                        Center(
                          child: Text(
                            'Next Grand Prix: ${nextRace ?? 'Unknown'}',
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Top Drivers & Top Teams
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _rankingCard(
                              'Top Drivers',
                              _getTopEntries(driversData.map((driver, data) => MapEntry(driver, data['points'] as int))),
                            ),
                            _rankingCard(
                              'Top Teams',
                              _getTopEntries(constructorsPoints),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Bottom Navigation
                        
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                          child: _glassContainer(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // LEFTMOST BUTTON -> goes to WDC
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

                                // MIDDLE BUTTON -> home 
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

                                // RIGHTMOST BUTTON -> goes to WDC
                                ClipOval(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const ConstructorsPage()),
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
                                        child: Icon(Icons.emoji_events, color: Colors.white), 
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Glass Container Widget
  static Widget _glassContainer({
    required Widget child,
    double? width,
    double? height,
    bool noPadding = false,
    Color color = const Color.fromRGBO(255, 255, 255, 0.15), // default same as before
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          width: width,
          height: height,
          padding: noPadding ? EdgeInsets.zero : const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: child,
        ),
      ),
    );
  }


  // Ranking Card (Driver/Team)
  static Widget _rankingCard(String title, List<MapEntry<String, int>> entries) {
    return _glassContainer(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: _glassContainer(
                width: 120,
                color: Colors.red.withOpacity(.3),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, // <-- center horizontally
                    children: [
                      Text(
                        entry.key,
                        style: GoogleFonts.racingSansOne(
                          fontSize: 16, // adjust size as you like
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${entry.value} pts',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
