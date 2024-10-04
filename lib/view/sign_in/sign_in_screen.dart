import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../components/reusable_button.dart';
import '../../components/reusable_text.dart';
import '../../routes/route_name.dart';
import '../../widgets/responsive.dart';
import 'components/build_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 30,
                            height: 30,
                          ),
                          ResponsiveWidget.isSmallScreen(context)
                              ? Container(
                                  height: screenSize.height / 10,
                                  width: screenSize.width / 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: const DecorationImage(
                                          image:
                                              AssetImage("assets/try on.png"),
                                          fit: BoxFit.cover)),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            width: 20,
                            height: 40,
                          ),
                          const Text(
                            "Fit Foot",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      auth_reusable_text('Sign In'),
                      const SizedBox(
                        height: 50,
                      ),
                      BuildTextField(
                          text: 'Email',
                          textType: TextInputType.emailAddress,
                          iconName: 'inbox',
                          onValueChange: (value) {
                            emailController.text = value;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      BuildTextField(
                          text: 'Password',
                          textType: TextInputType.text,
                          iconName: 'lock',
                          onValueChange: (value) {
                            passwordController.text = value;
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                      ReusableButton(
                        text: 'Sign in',
                        onPressed: () => login(emailController.text,
                            passwordController.text, context),
                        isLoading: _isLoading,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
              ResponsiveWidget.isLargeScreen(context)
                  ? Expanded(
                      child: SizedBox(
                      height: screenSize.height,
                      child: Image.asset(
                        "assets/try on.png",
                        fit: BoxFit.cover,
                      ),
                    ))
                  : const SizedBox.shrink()
            ],
          ),
        ],
      ),
    ));
  }

  void login(
      String userEmail, String userPassword, BuildContext context) async {
    if (_isLoading) return; // Prevent multiple logins

    setState(() {
      _isLoading = true;
    });

    try {
      // Authenticate the user
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPassword);

      // Fetch user data from Firestore to check the role
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      // Check if the user is an admin
      if (userData['role'] == 'admin') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("You are successfully logged in as an Admin")));

        // Navigate to the dashboard screen
        GoRouter.of(context).goNamed(AppRouteNames.main);
      } else {
        // If user is not an admin, sign out the user and show an error message
        await FirebaseAuth.instance.signOut();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("You are not authorized as an Admin")));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login unsuccessful: ${error.toString()}")));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
