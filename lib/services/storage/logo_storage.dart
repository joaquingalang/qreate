import 'dart:io';
import 'package:qreate/models/uploaded_logo.dart';
import 'package:qreate/services/database/logo_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogoStorage {

  final StorageFileApi _logoStorage =
      Supabase.instance.client.storage.from('logos');

  final LogoDatabase _logoDatabase = LogoDatabase();

  // Upload Logo To Supabase Storage
  Future<void> uploadLogo(File logo) async {
    try {
      // Fetch current user's UID
      final String? userId = Supabase.instance.client.auth.currentUser?.id;

      // Check if there is current user
      if (userId != null) {

        // Upload logo
        final String fullPath = await _logoStorage.upload(
          '$userId/${logo.path}',
          logo,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );

        // Get record path
        final String recordPath = fullPath.substring(6);

        // Get the uploaded logo's url
        final String logoUrl = _logoStorage.getPublicUrl(recordPath);

        final newLogo = UploadedLogo(
          userId: userId,
          url: logoUrl,
          path: recordPath,
        );

        // Upload logo url to database
        await _logoDatabase.createLogo(newLogo);

      } else {
        throw Exception('No Current User!');
      }
    } catch (e) {
      print('Error Uploading Data: $e');
    }
  }

  // Delete Logo To Supabase Storage
  Future<void> deleteLogo(UploadedLogo logo) async {
    try {
      // Fetch current user's UID
      final String? userId = Supabase.instance.client.auth.currentUser?.id;

      // Delete logo image
      if (userId != null) {
        final List<FileObject> objects = await _logoStorage.remove([logo.path!]);
        await _logoDatabase.deleteLogo(logo);
      } else {
        throw Exception('No Current User!');
      }

    } catch (e) {
      print('Error Deleting Data: $e');
    }
  }

}
