import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart'; // Ensure this path is correct for your project

class BuildTextField extends StatefulWidget {
  final String? text;
  final TextInputType? textType;
  final String? iconName;
  final bool? isPhoneNumber;
  final Function(String)? onValueChange; // Callback for value change

  const BuildTextField({
    super.key,
    required this.text,
    required this.textType,
    this.iconName = '',
    this.isPhoneNumber = false,
    this.onValueChange,
  });

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  late bool _obscureText;
  late bool _isPasswordField;
  final String _selectedCountryCode = '+92'; // Default country code
  final TextEditingController _textController = TextEditingController(); // Text controller

  @override
  void initState() {
    super.initState();
    _isPasswordField = widget.text == "Password" || widget.text == "Confirm Password";
    _obscureText = _isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.primarySecondaryBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Expanded(
            child: TextField(
              controller: _textController,
              keyboardType: widget.textType,
              obscureText: _obscureText,
              decoration: InputDecoration(
                prefixIcon: widget.iconName!.isNotEmpty
                    ? Padding(
                  padding: const EdgeInsets.only(left: 17, right: 10),
                  child: SvgPicture.asset("assets/${widget.iconName}.svg",
                      width: 16, height: 16),
                )
                    : null,
                hintText: widget.text,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                suffixIcon: _isPasswordField
                    ? GestureDetector(
                  onTap: _togglePasswordVisibility,
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color:_obscureText ? AppColors.primaryText : AppColors.primaryBackground,

                    size: 20,
                  ),
                )
                    : null,
                hintStyle: const TextStyle(
                  color: AppColors.primarySecondaryElementText,
                  fontSize: 14,
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              onChanged: (value) {
                if (widget.isPhoneNumber!) {
                  _updatePhoneNumber();
                } else {
                  widget.onValueChange?.call(value);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _updatePhoneNumber() {
    String fullPhoneNumber = _selectedCountryCode + _textController.text;
    widget.onValueChange?.call(fullPhoneNumber);
  }
}
