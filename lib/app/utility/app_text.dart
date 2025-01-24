import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText {
  // Heading Styles
  static TextStyle heading1({Color? color}) => GoogleFonts.varelaRound(
        fontSize: 40,
        fontWeight: FontWeight.w600, // Semibold
        color: color,
      );

  static TextStyle heading2({Color? color}) => GoogleFonts.varelaRound(
        fontSize: 32,
        fontWeight: FontWeight.w600, // Medium
        color: color,
      );

  static TextStyle heading3({Color? color}) => GoogleFonts.varelaRound(
        fontSize: 30,
        fontWeight: FontWeight.w600, // Medium
        color: color,
      );

  static TextStyle heading4({Color? color}) => GoogleFonts.varelaRound(
        fontSize: 24,
        fontWeight: FontWeight.w600, // Medium
        color: color,
      );
  // Body Text Styles
  static TextStyle body1({Color? color}) => GoogleFonts.varelaRound(
        fontSize: 18,
        fontWeight: FontWeight.w400, // Regular
        color: color,
      );

  static TextStyle body2({Color? color}) => GoogleFonts.varelaRound(
        fontSize: 16,
        fontWeight: FontWeight.w400, // Regular
        color: color,
      );

  static TextStyle body3({Color? color}) => GoogleFonts.varelaRound(
        fontSize: 14,
        fontWeight: FontWeight.w400, // Regular
        color: color,
      );

  // Caption Styles
  static TextStyle caption({Color? color}) => GoogleFonts.varelaRound(
        fontSize: 12,
        fontWeight: FontWeight.w400, // Regular
        color: color,
      );
}