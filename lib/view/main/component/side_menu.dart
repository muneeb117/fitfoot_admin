import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/route_name.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: MediaQuery.of(context).size.height *
                      0.15,
                  width: MediaQuery.of(context).size.width *
                      0.3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit
                          .contain,
                      image: AssetImage("assets/logo.png"),
                    ),
                  ),
                ),
              ),
            ),
            DrawerItem(
                iconPath: 'assets/dashboard-interface.png',
                text: 'Dashboard',
                onTap: () {
                  GoRouter.of(context).goNamed(AppRouteNames.dashboard);
                }),
            DrawerItem(
                iconPath: 'assets/upload.png',
                text: 'Upload Content',
                onTap: () {
                  GoRouter.of(context).goNamed(AppRouteNames.productUpload);
                }),
            DrawerItem(
                iconPath: 'assets/community.png',
                text: 'Community Guidelines',
                onTap: () {
                  GoRouter.of(context)
                      .goNamed(AppRouteNames.communicationGuidelines);
                }),
            DrawerItem(
                iconPath: 'assets/privacy-policy.png',
                text: 'Privacy Policy',
                onTap: () {
                  GoRouter.of(context).goNamed(AppRouteNames.privacyPolicy);
                }),
            DrawerItem(
                iconPath: 'assets/account.png',
                text: 'Account',
                onTap: () {
                  GoRouter.of(context).goNamed(AppRouteNames.account);
                }),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 8,
      onTap: onTap,
      leading: Image.asset(
        iconPath,
        height: 22,
        width: 22,
      ),
      title: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
      ),
    );
  }
}
