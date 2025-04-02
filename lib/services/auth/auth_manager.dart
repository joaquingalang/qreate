import 'package:flutter/material.dart';
import 'package:qreate/screens/auth_screen.dart';
import 'package:qreate/screens/dashboard_screen.dart';
import 'package:qreate/services/auth/auth_service.dart';
import 'package:qreate/widgets/progress_indicators/loading_icon.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthManager extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Listen to auth changes
      stream: Supabase.instance.client.auth.onAuthStateChange,

      // Build appropriate auth page based on auth state
      builder: (context, snapshot) {

        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: LoadingIcon(
                icon: Icon(Icons.qr_code, size: 30),
              ),
            ),
          );
        }

        // Check if there is a valid session
        final session = snapshot.hasData ? snapshot.data!.session : null;
        print('!!! SNAPSHOT: $snapshot');

        if (session != null) {
          return DashboardScreen();
        } else {
          return AuthScreen();
        }

      },
    );
  }
}
