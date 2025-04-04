import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {

  final SupabaseClient _supabase = Supabase.instance.client;

  // TODO: Sign-in with email and password
  Future<AuthResponse> signInWithEmailPassword({required String email, required String password}) async {
    return await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  // TODO: Sign-up with email and password
  Future<AuthResponse> signUpWithEmailPassword({required String email, required String password}) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }

  // TODO: Sign-out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // TODO: Get user id
  String? getCurrentUserId() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }

  // TODO: Get session stream
  Stream<AuthState> get authListener => _supabase.auth.onAuthStateChange;

}