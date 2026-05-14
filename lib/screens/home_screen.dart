import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supabase = ref.watch(supabaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulso Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // This completely clears the session
              await supabase.auth.signOut();
            },
          )
        ],
      ),
      body: const Center(
        child: Text('Welcome to Pulso!'),
      ),
    );
  }
}