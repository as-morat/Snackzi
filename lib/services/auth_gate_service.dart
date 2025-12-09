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
  bool _isCheckingOnboarding = true;

  @override
  void initState() {
    super.initState();
    _initializeAuthGate();
  }

  /// Initialize auth gate with onboarding check and auth listener
  Future<void> _initializeAuthGate() async {
    // Check onboarding status first
    await _checkOnboardingStatus();

    // Listen to auth state changes for automatic navigation
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;

      // Only rebuild on important auth events
      if (event == AuthChangeEvent.signedIn ||
          event == AuthChangeEvent.signedOut ||
          event == AuthChangeEvent.tokenRefreshed) {
        if (mounted) {
          setState(() {
            // This will trigger rebuild and show correct screen
          });
        }
      }
    });
  }

  /// Check if user has completed onboarding
  Future<void> _checkOnboardingStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (mounted) {
        setState(() {
          _hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
          _isCheckingOnboarding = false;
        });
      }
    } catch (e) {
      debugPrint('Error checking onboarding status: $e');
      if (mounted) {
        setState(() {
          _hasSeenOnboarding = false;
          _isCheckingOnboarding = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading while checking onboarding
    if (_isCheckingOnboarding || _hasSeenOnboarding == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.blue),
        ),
      );
    }

    // Watch auth state from provider
    final authState = ref.watch(supabaseAuthStateProvider);

    return authState.when(
      // Loading state
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.blue),
        ),
      ),

      // Error state with retry option
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Authentication Error',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // Invalidate provider to retry
                    ref.invalidate(supabaseAuthStateProvider);
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Data state - route based on auth and onboarding status
      data: (authStateData) {
        final session = Supabase.instance.client.auth.currentSession;

        // Priority 1: User is authenticated -> Main Screen
        if (session != null) {
          return const AppMainScreen();
        }

        // Priority 2: User hasn't seen onboarding -> Onboarding
        if (_hasSeenOnboarding == false) {
          return const OnBoardingScreen();
        }

        // Priority 3: User has seen onboarding but not authenticated -> Sign In
        return const SignInScreen();
      },
    );
  }
}