
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/video.dart'; // Path to your Video model
import '../models/user.dart'; // Path to your User model

class UploadVideoController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // Updated method to upload video from bytes
  Future<String> _uploadVideoFileToStorage(String videoId, Uint8List videoBytes, Function(double) onProgress) async {
    Reference ref = _storage.ref('All Videos').child(videoId);
    UploadTask uploadTask = ref.putData(videoBytes);

    uploadTask.snapshotEvents.listen((event) {
      onProgress(event.bytesTransferred.toDouble() / event.totalBytes.toDouble());
    }).onError((error) {
      print('Error uploading video file: $error');
      throw error;
    });

    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }


  Future<void> uploadPromotionalVideo(String songName, String caption, Uint8List videoBytes, int durationDays, Function(double) onProgress) async {
    try {
      var firebaseUser = _auth.currentUser;
      if (firebaseUser == null) throw Exception('User not found');

      var userSnapshot = await _firestore.collection('users').doc(firebaseUser.uid).get();
      UserModel user = UserModel.fromSnap(userSnapshot);

      String videoId = "Promo_${DateTime.now().millisecondsSinceEpoch}";
      String videoUrl = await _uploadVideoFileToStorage(videoId, videoBytes, onProgress);
      int expiryDateTime = DateTime.now().add(Duration(days: durationDays)).millisecondsSinceEpoch;

      Video video = Video(
        userId: user.uid,
        userName: user.name,
        userProfileImage: user.image,
        videoId: videoId,
        totalComment: 0,
        totalShare: 0,
        likeList: [],
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        thumbnailUrl: '', // No thumbnail
        publishedDateTime: DateTime.now().millisecondsSinceEpoch,
        isPromotional: true,
        expiryDateTime: expiryDateTime,
      );

      await _firestore.collection("videos").doc(videoId).set(video.toJson());
    } catch (e) {
      print('Error uploading promotional video: ${e.toString()}');
      rethrow; // Rethrow the exception for handling at the call site
    }
  }

}