import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String reportId;
  String videoId;
  String reportedByUserId; // Optional, in case you want to track who reported
  String reason; // Predefined reasons like "Nudity or Sexual Content", "Fraud or Scam", etc.
  String additionalDetails; // User-provided details
  DateTime reportedDateTime;

  Report({
    required this.reportId,
    required this.videoId,
    this.reportedByUserId = '',
    required this.reason,
    this.additionalDetails = '',
    required this.reportedDateTime,
  });

  Map<String, dynamic> toJson() => {
    "reportId": reportId,
    "videoId": videoId,
    "reportedByUserId": reportedByUserId,
    "reason": reason,
    "additionalDetails": additionalDetails,
    "reportedDateTime": reportedDateTime,
  };

  static Report fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Report(
      reportId: snapshot['reportId'],
      videoId: snapshot['videoId'],
      reportedByUserId: snapshot['reportedByUserId'] ?? '',
      reason: snapshot['reason'],
      additionalDetails: snapshot['additionalDetails'] ?? '',
      reportedDateTime: snapshot['reportedDateTime'].toDate(),
    );
  }
}
