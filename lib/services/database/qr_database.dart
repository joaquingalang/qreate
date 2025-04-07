import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:qreate/models/qr_code.dart';

class QrDatabase {
  final _qrDatabase = Supabase.instance.client.from('qr_codes');

  // Create QR Code
  Future<void> createQr(QrCode newQr) async {
    await _qrDatabase.insert(newQr.toMap());
  }

  // Read QR Code
  Stream getStream() {
    return Supabase.instance.client
        .from('qr_codes')
        .stream(
          primaryKey: ['id'],
        )
        .eq('user_id', Supabase.instance.client.auth.currentUser!.id)
        .map((data) => data.map((qrMap) => QrCode.fromMap(qrMap)).toList());
  }

  // Update QR Code
  Future<void> updateQr(QrCode oldQr, QrCode newQr) async {
    final newQrMap = newQr.toMap();
    newQrMap['id'] = oldQr.id!;
    await _qrDatabase.update(newQrMap).eq('id', oldQr.id!);
  }

  // Delete QR Code
  Future<void> deleteQr(QrCode qrCode) async {
    await _qrDatabase.delete().eq('id', qrCode.id!);
  }
}
