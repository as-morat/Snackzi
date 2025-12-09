import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/pages/auth/sign_in_screen.dart';
import 'package:food_delivery/pages/screens/app_main_screen.dart';
import 'package:food_delivery/pages/screens/on_boarding_screen.dart';
import 'package:food_delivery/providers/stream_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends ConsumerStatefulWidget {
  const AuthGate({super.key});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  bool? _hasSeenOnboarding;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(supabaseAuthStateProvider);

    // Wait for onboarding check to complete
    if (_hasSeenOnboarding == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.blue)),
      );
    }

    return authState.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.blue)),
      ),
      error: (e, _) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: .center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Auth Error: $e'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(supabaseAuthStateProvider);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (state) {
        final session = Supabase.instance.client.auth.currentSession;

        // User is authenticated -> go to Main Screen
        if (session != null) {
          return const AppMainScreen();
        }

        // User not authenticated
        // Check if they've seen onboarding
        if (_hasSeenOnboarding == false) {
          return const OnBoardingScreen();
        }

        // They've seen onboarding -> go to Sign In
        return const SignInScreen();
      },
    );
  }
}
