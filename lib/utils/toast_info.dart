import 'package:flutter/material.dart';

void toastInfo({
  required BuildContext context,
  required String msg,
  List<Color> gradientColors = const [Colors.blue, Colors.pink],
  Color textColor = Colors.white,
}) {
  var overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.1, // Position the toast
      width: MediaQuery.of(context).size.width * 0.8, // Set the width
      left: MediaQuery.of(context).size.width * 0.1,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Text(
            msg,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
        ),
      ),
    ),
  );

  // Insert the overlay
  Overlay.of(context).insert(overlayEntry);

  // Automatically remove the toast after a duration
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
