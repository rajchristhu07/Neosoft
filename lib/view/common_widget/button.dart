import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget {
  static ElevatedButton button(
      elevation, primaryColor, textColor, fontSize, onPress, text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: primaryColor,
        onPrimary: Colors.white,
        // side: BorderSide(color: Colors.red, width: 1),
        textStyle: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.montserrat().fontFamily),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      onPressed: onPress,
      child: Text(text),
    );
  }

  static IconButton iconButton(icon, color, onPress) {
    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: onPress,
    );
  }
}
