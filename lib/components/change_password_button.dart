import 'package:flutter/material.dart';

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({
    super.key, required this.text, required this.onPress,
  });

  final String? text;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.lock_reset), // Icon for password reset
      label: Text("$text"),
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
