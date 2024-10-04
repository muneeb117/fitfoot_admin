
import 'package:flutter/cupertino.dart';

class AppColors {
  /// pink color for buttons
  static const Color primaryBackground = Color.fromARGB(255, 255, 101, 132);

  /// grey background
  static const Color primarySecondaryBackground = Color.fromARGB(
      255, 245, 245, 245);

  static const Color primaryText = Color.fromARGB(255, 158, 158, 158);


  /// Stroke Colors
  static const Color strokeColor = Color.fromARGB(255, 216, 218, 220);

  //build dot non active color
  static const Color nonActive = Color.fromARGB(255, 53, 56, 63);

  /// build dot active color
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 255, 128, 77), // Starting color
      Color.fromARGB(255, 255, 131, 149), // Ending color
    ],
  );




  /// main text color black
  //static const Color primaryText = Color.fromARGB(255, 0, 0, 0);


  /// video backgroun color
  static const Color primary_bg = Color.fromARGB(210, 32, 47, 62);


  /// main widget text color white
  static const Color primaryElementText = Color.fromARGB(255, 255, 255, 255);
  // main widget text color grey
  static const Color primarySecondaryElementText = Color.fromARGB(255, 102, 102, 102);
  // main widget third color grey
  static const Color primaryThreeElementText = Color.fromARGB(255, 170, 170, 170);

  static const Color primaryFourElementText = Color.fromARGB(255, 204, 204, 204);
  //state color
  static const Color primaryElementStatus = Color.fromARGB(255, 88, 174, 127);

  static const Color primaryElementBg = Color.fromARGB(255, 238, 121, 99);


}
