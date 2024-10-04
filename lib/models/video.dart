import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String userId;
  String userName;
  String userProfileImage;
  String videoId;
  int totalComment;
  int totalShare;
  List likeList;
  String songName;
  String caption;
  String videoUrl;
  String thumbnailUrl;
  int publishedDateTime;
  bool isHidden;
  bool isPromotional; // new field to indicate promotional video
  int? expiryDateTime; // new field for expiry date of the video


  Video({
    required this.userId,
    required this.userName,
    required this.userProfileImage,
    required this.videoId,
    required this.totalComment,
    required this.totalShare,
    required this.likeList,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.publishedDateTime,
    this.isHidden = false,
    this.isPromotional = false, // default as false
    this.expiryDateTime,

  });

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userName": userName,
    "userProfileImage": userProfileImage,
    "videoId": videoId,
    "totalComment": totalComment,
    "totalShare": totalShare,
    'likeList': likeList,
    "songName": songName,
    "caption": caption,
    "videoUrl": videoUrl,
    "thumbnailUrl": thumbnailUrl,
    "publishedDateTime": publishedDateTime,
    "isHidden": isHidden,
    "isPromotional": isPromotional, // add to JSON
    "expiryDateTime": expiryDateTime, // add to JSON

  };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
      userId: snapshot['userId'],
      userName: snapshot['userName'],
      userProfileImage: snapshot['userProfileImage'],
      videoId: snapshot['videoId'],
      totalComment: snapshot['totalComment'],
      totalShare: snapshot['totalShare'],
      likeList: snapshot['likeList'] ?? [],
      songName: snapshot['songName'],
      caption: snapshot['caption'],
      videoUrl: snapshot['videoUrl'],
      thumbnailUrl: snapshot['thumbnailUrl'],
      publishedDateTime: snapshot['publishedDateTime'],
      isHidden: snapshot['isHidden'] ?? false,
      isPromotional: snapshot['isPromotional'] ?? false, // default to false if not available
      expiryDateTime: snapshot['expiryDateTime'],

    );
  }
}
