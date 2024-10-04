import 'package:fitfoot_web/routes/route_page.dart';
import 'package:fitfoot_web/routes/route_path.dart';
import 'package:go_router/go_router.dart';



import 'package:firebase_auth/firebase_auth.dart';

class AppRoutes {
  final GoRouter router;

  AppRoutes() : router = GoRouter(
          initialLocation: AppRoutePaths.signIn,
          routes: [
            AppRouteBuilder.signInRoute(),
            AppRouteBuilder.mainRoute(),
          ],
          redirect: (context, state) {
            final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
            final bool goingToSignInPage =
                state.uri.path == AppRoutePaths.signIn;

            if (!isLoggedIn && !goingToSignInPage) {
              return AppRoutePaths.signIn;
            }
            if (isLoggedIn && goingToSignInPage) {
              return AppRoutePaths
                  .main;
            }
            return null;
          },
        );
}
