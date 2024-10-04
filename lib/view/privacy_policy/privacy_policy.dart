import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/custom_button.dart';
import '../../components/reusable_script_container.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() =>
      _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  TextEditingController privacyController = TextEditingController();
  String _lastUpdated = "Not Avaliable";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadGuidelines();
  }
  Future<void> _loadGuidelines() async {
    var doc = await _firestore
        .collection('settings')
        .doc('privacy_policy')
        .get();
    if (doc.exists) {
      setState(() {
        privacyController.text = doc.data()?['text'] ?? '';
        _lastUpdated = doc.data()?['last_updated'] != null
            ? DateFormat('yyyy-MM-dd – kk:mm')
            .format(doc.data()?['last_updated'].toDate())
            : "Not Available";
      });
    }
  }

  Future<void> _saveGuidelines() async {
    await _firestore.collection("settings").doc("privacy_policy").set({
      "text": privacyController.text.toString(),
      "last_updated": DateTime.now(),
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Uploaded Successfully")));
    _loadGuidelines();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const   SizedBox(
                  height: 20,
                ),
                const Text(
                  "Privacy Policy",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
               const  SizedBox(
                  height: 20,
                ),
                ReusableScriptContainer(hintText: 'Enter Privacy Policy Here', child: null, controller: privacyController, maxLines: 10)
              ,
               const  SizedBox(
                  height: 20,
                ),

                CustomButton(text: "Save Changes", onPress: _saveGuidelines),
               const  SizedBox(
                  height: 20,
                ),
                Text(
                  'Last Updated: $_lastUpdated',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}