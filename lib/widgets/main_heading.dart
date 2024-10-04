import 'package:flutter/material.dart';

class MainHeading                                                                                                extends StatelessWidget {
  const MainHeading({
    super.key,
    required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.only(
              top: screenSize.height / 10,
              bottom: screenSize.height / 15,
            ),
            width: screenSize.width,
            child: const Text(
              'Knowledge diversity',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
