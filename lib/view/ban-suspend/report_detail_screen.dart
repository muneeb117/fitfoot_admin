import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';
import '../../models/report_model.dart';
import '../../models/video.dart';
import 'components/video_overlay.dart';
class ReportDetailScreen extends StatefulWidget {
  final Report report;
  final VoidCallback onActionTaken;

  const ReportDetailScreen({super.key, required this.report, required this.onActionTaken});

  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  VideoPlayerController? _controller;
  Video? videoDetails;

  @override
  void initState() {
    super.initState();
    fetchVideoDetails(widget.report.videoId).then((video) {
      if (video != null) {
        videoDetails = video;
        _controller = VideoPlayerController.network(video.videoUrl)
          ..initialize().then((_) {
            setState(() {});
          });
      }
    });
  }

  Future<Video?> fetchVideoDetails(String videoId) async {
    var docSnapshot = await _firestore.collection('videos').doc(videoId).get();
    if (docSnapshot.exists) {
      return Video.fromSnap(docSnapshot);
    }
    return null;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Report Detail Screen",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              if (_controller != null && _controller!.value.isInitialized)
                SizedBox(
                  height: 300, // Constrain the height
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(_controller!),
                        PlayPauseOverlay(controller: _controller),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              Text('Reason: ${widget.report.reason}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Additional Details: ${widget.report.additionalDetails}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Reported On: ${widget.report.reportedDateTime}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _suspendOrBlockUser(context, widget.report),
                child: const Text('Take Action'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _suspendOrBlockUser(BuildContext context, Report report) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Take Action'),
          content: const Text('Do you want to suspend or permanently block the user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _updateUserStatus(report.videoId, 'suspend');
              },
              child: const Text('Suspend User'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _updateUserStatus(report.videoId, 'block');
              },
              child: const Text('Block User'),
            ),
          ],
        );
      },
    );
  }

  void _updateUserStatus(String videoId, String action) async {
    try {
      DocumentSnapshot videoDoc = await _firestore.collection('videos').doc(videoId).get();
      if (!videoDoc.exists) return;

      String userId = videoDoc['userId'];

      if (action == 'suspend') {
        // Update user status to suspended and set suspensionEnd date
        await _firestore.collection('users').doc(userId).update({
          'isSuspended': true,
          'suspensionEnd': DateTime.now().add(const Duration(days: 15)).millisecondsSinceEpoch, // 15 days suspension
        });

        // Hide the specific video
        await _firestore.collection('videos').doc(videoId).update({
          'isHidden': true,
        });
      } else if (action == 'block') {
        // Update user status to permanently blocked
        await _firestore.collection('users').doc(userId).update({
          'isPermanentlyBlocked': true,
        });

        // Hide all user's videos
        var userVideos = await _firestore.collection('videos').where('userId', isEqualTo: userId).get();
        for (var doc in userVideos.docs) {
          await doc.reference.update({'isHidden': true});
        }
      }
      // After taking action, delete the report and refresh the list
      await _firestore.collection('reports').doc(widget.report.reportId).delete();
      widget.onActionTaken();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User has been ${action == 'suspend' ? 'suspended' : 'blocked'}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $e')),
      );
    }
  }
}
