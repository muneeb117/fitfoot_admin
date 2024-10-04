

import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key, required this.text,required this.onPress,
  });
  final String? text;
  void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBackground,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),
        onPressed: onPress, child: Text("$text")
    );
  }
}
