import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/services/auth_gate_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseUrl = dotenv.env["SUPABASE_URL"] ?? "";
final supabaseKey = dotenv.env["SUPABASE_ANON_KEY"] ?? "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: AuthGate(),
      ),
    );
  }
}
