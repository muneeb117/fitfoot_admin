import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import '../../../constants.dart';
import '../../../models/user.dart';
import '../../../responsive.dart';
import '../../../routes/route_name.dart';

class PortfolioCard extends StatefulWidget {
  const PortfolioCard({super.key});

  @override
  _PortfolioCardState createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<PortfolioCard> {
  Future<UserModel>? _userData;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _userData = fetchUserData();
  }

  Future<UserModel> fetchUserData() async {
    // Assuming you have a way to get the current user's UID
    String uid = firebaseAuth.currentUser!.uid;
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return UserModel.fromSnap(userSnapshot);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: _userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator while waiting for data
        }
        if (!snapshot.hasData) {
          return const Text("No user data found"); // Handle no data scenario
        }
        UserModel user = snapshot.data!; // Your User data

        return Row(
          children: [
            CircleAvatar(
              backgroundImage: user.image.isNotEmpty
                  ? NetworkImage(user.image) as ImageProvider
                  : const AssetImage(
                      'path_to_local_placeholder_image'), // Assuming you have a local image for the placeholder
            ),
            if (!Responsive.isMobile(context))
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Text(
                  user.name,
                  style: const TextStyle(color: Colors.white),
                ), // Use user name from Firestore
              ),
            PopupMenuButton<String>(
              icon:const  Icon(Icons.keyboard_arrow_down, color: Colors.white),
              onSelected: (String result) async {
                if (result == 'signout') {
                  await firebaseAuth.signOut();
                  GoRouter.of(context).goNamed(AppRouteNames.signIn);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'signout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.black),
                      SizedBox(width: 8),
                      Text('Sign Out'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
