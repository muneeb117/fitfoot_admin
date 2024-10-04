import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/change_password_button.dart';
import '../../components/custom_button.dart';
import '../../components/reusable_script_container.dart';
import '../../models/user.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    var userDoc = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
    var user = UserModel.fromSnap(userDoc);
    _nameController.text = user.name;
    _emailController.text = user.email;
  }

  Future<void> _updateUserData() async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      'name': _nameController.text,
      // 'email': _emailController.text,
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile Updated Successfully")));
  }

  Future<void> _sendPasswordResetEmail() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password reset email sent successfully")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error sending password reset email: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Account Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Account Setting",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
         const    SizedBox(
              height: 20,
            ),
            ReusableScriptContainer(hintText: 'Name', child: null, controller: _nameController, maxLines: 1),
            const SizedBox(height: 10),

            ChangePasswordButton(
              onPress: _sendPasswordResetEmail,
              text:'Reset Password',

            ),
            const SizedBox(height: 20),

            Center(
              child: CustomButton(
                onPress: _updateUserData,
                text:'Update Profile'
              ),
            ),


          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
