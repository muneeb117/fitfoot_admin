import 'package:flutter/material.dart';

class BottomBarColumn extends StatelessWidget {
  final String heading;
  final String s1;
  final String s2;
  final String s3;

  const BottomBarColumn({super.key, 
    required this.heading,
    required this.s1,
    required this.s2,
    required this.s3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            s1,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            s2,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),const SizedBox(
            height: 6,
          ),
          Text(
            s3,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
