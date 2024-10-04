import 'package:flutter/material.dart';
import '../utils/colors.dart'; // Ensure this is the correct path to your colors utility

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const ReusableButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false, // Default to not loading
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 45,
        width: 325,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: AppColors.primaryBackground.withOpacity(0.5),
              spreadRadius: 1,
              offset: const Offset(0, 3),
            )
          ],
          color: AppColors.primaryBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
            height: 20, // Smaller size for the indicator
            width: 20, // Smaller size for the indicator
            child: CircularProgressIndicator(
              strokeWidth: 2, // Makes the spinning circle thinner
              valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primarySecondaryBackground),
            ),
          )
              : Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.primarySecondaryBackground,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
      ),
    );
  }
}