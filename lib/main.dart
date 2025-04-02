import 'package:flutter/material.dart';
import 'utils/secrets.dart';
import 'package:qreate/services/auth/auth_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_ANON_KEY);
  runApp(Qreate());
}

class Qreate extends StatelessWidget {
  const Qreate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthManager(),
      debugShowCheckedModeBanner: false,
    );
  }
}
