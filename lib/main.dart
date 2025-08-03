import 'package:flutter/foundation.dart'; // For kReleaseMode
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trackside_app/login.dart';
import 'package:trackside_app/login.dart';
import 'package:trackside_app/signup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trackside_app/funct/scraper_retrieval.dart';
import 'package:supabase/supabase.dart';

late final SupabaseClient scraperClient;   //supabaseclient to be used for scraper


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://dydfevalyiuefthioeus.supabase.co',     
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR5ZGZldmFseWl1ZWZ0aGlvZXVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMwOTQ0MzEsImV4cCI6MjA2ODY3MDQzMX0.XAQot9aufInNI6nRzuN3ZyDpAf4Q-vQGYsTdSqkm8h0',       
  );

  scraperClient= SupabaseClient(     //initialize second supabase client for scraper
    'https://ljloevgynjbhsabajxqq.supabase.co', 
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxqbG9ldmd5bmpiaHNhYmFqeHFxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI4OTEyNjksImV4cCI6MjA2ODQ2NzI2OX0.LhINU3Xb4SNrrPHWtidBKoeUjLFJ89FCvYK2dVtFTf0'
    );

  await loadlatestdata();

  // print(nextRace);
  // print(driversPoints);
  // print(constructorsPoints);


  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const TracksideApp(),
    ),
  );
}


class TracksideApp extends StatelessWidget {
  const TracksideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'F1 Trackside',
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image (tire tracks)
          SizedBox.expand(
            child: Image.asset(
              'images/WelcomePageBckg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Buttons overlay
          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),  // Moves buttons lower by adding space at top
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 188, 188, 188),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),  // bigger buttons
                      textStyle: GoogleFonts.racingSansOne(
                        fontSize: 26,  // bigger text
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 25),  // space between buttons
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 188, 188, 188),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                      textStyle: GoogleFonts.racingSansOne(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage())
                      );
                    },
                    child: const Text("Sign Up"),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}