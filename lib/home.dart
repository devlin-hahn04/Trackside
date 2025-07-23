import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _recoverSession();
  }

  Future<void> _recoverSession() async {
    // Wait a moment to allow Supabase to restore session from storage
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      user = Supabase.instance.client.auth.currentUser;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          if (user != null)
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () async {
                await Supabase.instance.client.auth.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
        ],
      ),
      body: Center(
        child: user != null
            ? Text(
                'Logged in as: ${user!.email}',
                style: const TextStyle(fontSize: 18),
              )
            : const Text(
                'No user signed in.',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
      ),
    );
  }
}
