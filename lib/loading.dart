import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home.dart'; // import your HomePage

class LottieTransitionPage extends StatelessWidget {
  const LottieTransitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // optional, matches theme
      body: Align(
        alignment: const Alignment(-0.5, 0.0), // move a bit to the left
        child: Lottie.asset(
          'images/wheel.json', // path to your Lottie file
          width: 200,
          height: 200,
          fit: BoxFit.contain,
          onLoaded: (composition) {
            // Navigate automatically when the animation finishes
            Future.delayed(const Duration(seconds: 3), () {
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              }
            });
          },
        ),
      ),
    );
  }
}
