import 'dart:async';
import 'package:qreate/models/uploaded_logo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogoDatabase {
  final _logoDatabase = Supabase.instance.client.from('logos');

  // Create New Logo
  Future<void> createLogo(UploadedLogo logo) async {

    // Add record in logos table
    await _logoDatabase.insert(
        logo.toMap()
    );

  }

  // Get Uploaded Logo Stream
  Stream getStream() {
    return Supabase.instance.client
        .from('logos')
        .stream(
          primaryKey: ['id'],
        )
        .eq('user_id', Supabase.instance.client.auth.currentUser!.id)
        .map((data) =>
            data.map((logoMap) => UploadedLogo.fromMap(logoMap)).toList());
  }

  // Delete Uploaded Logo
  Future<void> deleteLogo(UploadedLogo logo) async {
    await _logoDatabase.delete().eq('id', logo.id!);
  }
}
