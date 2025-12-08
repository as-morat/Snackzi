import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/pages/auth/sign_in_screen.dart';
import 'package:food_delivery/pages/home/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/stream_provider.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(supabaseAuthStateProvider);

    return authState.when(
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.blue),
        ),
      ),
      error: (e, _) => Scaffold(body: Center(child: Text('Auth Error: $e'))),
      data: (state) {
        final session = Supabase.instance.client.auth.currentSession;

        return session != null ? const HomeScreen() : const SignInScreen();
      },
    );
  }
}
