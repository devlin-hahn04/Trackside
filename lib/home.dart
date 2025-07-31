import 'dart:ui';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'images/Dashboard.png',
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
                          padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _glassContainer(
                                child: const Text(
                                  'Welcome, user',
                                  style: TextStyle(color: Colors.white),
                                ),
                                width: 130,
                                height: 40,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Middle Image Container
                        Center(
                          child: _glassContainer(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 200,
                            child: const Center(
                              child: Icon(Icons.image, size: 80, color: Colors.white38),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Next Grand Prix
                        const Center(
                          child: Text(
                            'Next Grand Prix: Value',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Top Drivers & Top Teams
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _rankingCard('Top Drivers', ['Driver 1', 'Driver 2', 'Driver 3']),
                            _rankingCard('Top Teams', ['Team A', 'Team B', 'Team C']),
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
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: child,
        ),
      ),
    );
  }

  // Ranking Card (Driver/Team)
  static Widget _rankingCard(String title, List<String> names) {
    return _glassContainer(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...names.map(
            (name) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: _glassContainer(
                width: 120,
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Points',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(name, style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
