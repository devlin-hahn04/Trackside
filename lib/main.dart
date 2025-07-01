import 'package:flutter/foundation.dart'; // For kReleaseMode
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trackside_app/login.dart';
import 'package:trackside_app/login.dart';
import 'package:trackside_app/signup.dart';



void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const TracksideApp(),
  ),
);

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