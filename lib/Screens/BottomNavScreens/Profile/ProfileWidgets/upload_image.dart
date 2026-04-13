import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadImage(String path) async {
  try {
    final fileName = path.split('/').last;
    final ref = FirebaseStorage.instance.ref().child('chat_images/$fileName');
    await ref.putFile(File(path));
    return await ref.getDownloadURL(); // ✅ must return URL
  } catch (e) {
    print("Upload failed: $e");
    return null;
  }
}