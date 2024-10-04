//
// class AuthenticationController extends GetxController {
//   final RxBool isUpdatingProfileImage = RxBool(false);
//   Rx<User?> _currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
//
//   // Other properties remain unchanged
//   static AuthenticationController instanceAuth = Get.find();
//   final Rx<File?> _pickedFile = Rx<File?>(null);
//   File? get profileImage => _pickedFile.value;
//   Stream<User?> get userStream => FirebaseAuth.instance.authStateChanges();
//
//   // Use this getter to safely access the current user
//   User? get user => _currentUser.value;
//
//   // Method to reset the image
//   void resetImage() {
//     _pickedFile.value = null;
//     update(); // Notify listeners
//   }
//
//   Future<void> updateUserName(String newName) async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       await user.updateDisplayName(newName);
//       await FirebaseFirestore.instance
//           .collection("users")
//           .doc(user.uid)
//           .update({'name': newName});
//
//       // Ensure the local user object is updated
//       _currentUser.value = user;
//
//       // Notify listeners to rebuild
//       update();
//     }}
//     Future<void> updateProfileImage(File imageFile, Function onSuccess) async {
//       isUpdatingProfileImage.value = true; // Start loading
//       try {
//         String imageUrl = await uploadedImagetoStorage(imageFile);
//         User? user = FirebaseAuth.instance.currentUser;
//         if (user != null) {
//           await FirebaseFirestore.instance
//               .collection("users")
//               .doc(user.uid)
//               .update({'image': imageUrl});
//           _currentUser.value = user;
//           onSuccess(); // Call the callback function
//         }
//       } catch (e) {
//         print("Error updating profile image: $e");
//         // Handle errors
//       } finally {
//         isUpdatingProfileImage.value = false; // Stop loading
//         update(); // Notify listeners
//       }
//     }
//
//
//
//
//   Future<String> uploadedImagetoStorage(File imageFile) async {
//     Reference reference = FirebaseStorage.instance
//         .ref()
//         .child("Profile Image")
//         .child(FirebaseAuth.instance.currentUser!.uid);
//     UploadTask uploadTask = reference.putFile(imageFile);
//     TaskSnapshot taskSnapshot = await uploadTask;
//     String downloadUrlOfImage = await taskSnapshot.ref.getDownloadURL();
//     return downloadUrlOfImage;
//   }
//   void login(String userEmail, String userPassword, BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmail, password: userPassword);
//       Get.snackbar("Login", "You are successfully logged in");
//
//       // Navigate to the dashboard screen
//       GoRouter.of(context).goNamed(AppRouteNames.dashboard);
//
//     } catch (error) {
//       Get.snackbar("Login", "Unsuccessful");
//     }
//   }
//
//   void signOut() async {
//     // Get the current user
//     User? user = FirebaseAuth.instance.currentUser;
//       // Finally, sign out from Firebase
//       await FirebaseAuth.instance.signOut();
//
//   }
//
//   void gotoScreen(User? currentUser) {
//     if (currentUser == null) {
//       // If no current user, go to the initial route (probably a welcome or sign-in screen)
//       GoRouter.of(context).goNamed(AppRouteNames.dashboard);
//     } else
//       // Check if the user's email is verified
//       if (currentUser.emailVerified) {
//         // If email is verified, navigate to the application's main screen
//         // Get.offAllNamed(AppRoutes.main);
//       }
//     }
//
//
//
//   @override
//   void onReady() {
//     super.onReady();
//     _currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
//     _currentUser.bindStream(FirebaseAuth.instance.authStateChanges());
//     ever(_currentUser, gotoScreen);
//   }
// }
