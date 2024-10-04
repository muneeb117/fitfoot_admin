

import 'package:flutter/cupertino.dart';

Padding auth_reusable_text(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
    ),
  );
}
