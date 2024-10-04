import 'package:flutter/material.dart';

import '../widgets/responsive.dart';
import 'main/component/side_menu.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
       appBar:  ResponsiveWidget.isSmallScreen(context)||ResponsiveWidget.isMediumScreen(context)?AppBar(
         elevation: 0,
         backgroundColor: Colors.transparent,


       ):null,
      drawer: const SideMenu(),
      body: ResponsiveWidget.isLargeScreen(context)
          ? Row(
        children: [
          const Expanded(flex: 2, child: SideMenu()),
          Expanded(flex: 8, child: widget.child),
        ],
      )
          : widget.child,
    );
  }
}
