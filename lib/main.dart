import 'package:firebase_core/firebase_core.dart';
import 'package:fitfoot_web/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_config/firebase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseConfig.options);
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fit Foot Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.urbanistTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routerConfig: AppRoutes().router,
      // routeInformationParser: AppRoutes().router.routeInformationParser,
      // routerDelegate: AppRoutes().router.routerDelegate,
    );
  }
}
