import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfileImage(String userId, Uint8List imageBytes) async {
    final ref = _storage.ref('avatars/$userId/profile.jpg');
    final metadata = SettableMetadata(contentType: 'image/jpeg');
    final task = await ref.putData(imageBytes, metadata);
    return task.ref.getDownloadURL();
  }

  Future<String> uploadCaregiverDocument(String caregiverId, String docType, Uint8List bytes) async {
    final ref = _storage.ref('caregiver_docs/$caregiverId/${docType}_${DateTime.now().millisecondsSinceEpoch}.pdf');
    final task = await ref.putData(bytes, SettableMetadata(contentType: 'application/pdf'));
    return task.ref.getDownloadURL();
  }

  Future<void> deleteFile(String downloadUrl) async {
    final ref = _storage.refFromURL(downloadUrl);
    await ref.delete();
  }
}
