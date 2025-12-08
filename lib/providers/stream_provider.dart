import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// auth state stream provider
final supabaseAuthStateProvider = StreamProvider<AuthState?>((ref) {
  final supabase = Supabase.instance.client;

  // Convert auth change events into a stream
  return supabase.auth.onAuthStateChange.map((event) {
    return event;
  });
});
