import 'package:fitfoot_web/routes/route_name.dart';
import 'package:fitfoot_web/routes/route_path.dart';
import 'package:fitfoot_web/view/product_upload/confirm_product_arguments.dart';
import 'package:fitfoot_web/view/product_upload/confirm_screen.dart';
import 'package:fitfoot_web/view/product_upload/product_upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view/account/account_screen.dart';
import '../view/ban-suspend/report_screen.dart';
import '../view/community guidelines/community_guidelines.dart';
import '../view/dashboard/dashboard_screen.dart';
import '../view/main_layout.dart';
import '../view/privacy_policy/privacy_policy.dart';
import '../view/sign_in/sign_in_screen.dart';

class AppRouteBuilder {
  static GoRoute mainRoute() {
    return GoRoute(
      name: AppRouteNames.main,
      path: AppRoutePaths.main,
      pageBuilder: (context, state) => const MaterialPage(
        child: MainLayout(child: DashboardScreen()),
      ),
      routes: [
        dashboardRoute(),
        promotionalRoute(),
        communicationGuidelinesRoute(),
        privacyPolicyRoute(),
        accountRoute(),
        confirmVideoRoute(),
      ],
    );
  }

  static GoRoute confirmVideoRoute() {
    return GoRoute(
      name: AppRouteNames.confirmProduct,
      path: AppRoutePaths.confirmVideo,
      pageBuilder: (context, state) {
        final args = state.extra as ConfirmProductScreenArguments;
        return MaterialPage(
          child: MainLayout(
            child: ConfirmProductScreen(
              productImageBytes: args.productImageBytes,
              // videoFile: args.videoFile,
            ),
          ),
        );
      },
    );
  }

  static GoRoute signInRoute() {
    return GoRoute(
      name: AppRouteNames.signIn,
      path: AppRoutePaths.signIn,
      pageBuilder: (context, state) => const MaterialPage(
        child: SignInScreen(),
      ),
    );
  }

  static GoRoute dashboardRoute() {
    return GoRoute(
      name: AppRouteNames.dashboard,
      path: AppRoutePaths.dashboard,
      pageBuilder: (context, state) => const MaterialPage(
        child: MainLayout(child: DashboardScreen()),
      ),
    );
  }

  static GoRoute promotionalRoute() {
    return GoRoute(
      name: AppRouteNames.productUpload,
      path: AppRoutePaths.productUpload,
      pageBuilder: (context, state) => const MaterialPage(
        child: MainLayout(child: ProductUploadScreen()),
      ),
    );
  }

  static GoRoute communicationGuidelinesRoute() {
    return GoRoute(
      name: AppRouteNames.communicationGuidelines,
      path: AppRoutePaths.communicationGuidelines,
      pageBuilder: (context, state) => const MaterialPage(
        child: MainLayout(child: CommunityGuidelineScreen()),
      ),
    );
  }

  static GoRoute privacyPolicyRoute() {
    return GoRoute(
      name: AppRouteNames.privacyPolicy,
      path: AppRoutePaths.privacyPolicy,
      pageBuilder: (context, state) => const MaterialPage(
        child: MainLayout(child: PrivacyPolicyScreen()),
      ),
    );
  }

  static GoRoute accountRoute() {
    return GoRoute(
      name: AppRouteNames.account,
      path: AppRoutePaths.account,
      pageBuilder: (context, state) => const MaterialPage(
        child: MainLayout(child: AccountScreen()),
      ),
    );
  }

// Add any other route builders as needed for your application
}
