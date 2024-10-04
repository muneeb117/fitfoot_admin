
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ReusableScriptContainer extends StatelessWidget {
  const ReusableScriptContainer({
    super.key,
    required this.hintText,
    required this.child,
    required this.controller,
    required this.maxLines,
  });

  final TextEditingController controller;
  final String hintText;
  final Widget? child;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.strokeColor),
      ),
      child: TextFormField(
        maxLines: maxLines,
        controller: controller,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 1),
            child: child,
          ),
        ),
      ),
    );
  }
}
