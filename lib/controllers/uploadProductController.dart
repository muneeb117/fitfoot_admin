import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';

class UploadProductController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String _productCollection = 'products';
  final Uuid uuid = const Uuid();

  Future<void> uploadProduct(
    String title,
    int price,
    String description,
    Uint8List imageBytes, {
    String? arLink, // Optional AR Link
    int size = 0,
    int colorValue = 0xFFFFFFFF, // Random color value
  }) async {
    try {
      String productId = uuid.v4();

      String imageUrl = await _uploadImage(productId, imageBytes);

      await _firestore.collection(_productCollection).doc(productId).set({
        'id': productId,
        'title': title,
        'price': price,
        'description': description,
        'image': imageUrl,
        'size': size,
        'color': colorValue, // Store the random color
        'arLink': arLink ?? '', // Store AR Link if provided
      });
    } catch (e) {
      throw Exception("Failed to upload product: $e");
    }
  }

  // Function to upload image to Firebase Storage
  Future<String> _uploadImage(String productId, Uint8List imageBytes) async {
    try {
      Reference ref = _storage.ref().child('products/$productId.png');
      UploadTask uploadTask = ref.putData(imageBytes);

      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception("Failed to upload image: $e");
    }
  }
}
