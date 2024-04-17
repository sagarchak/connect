import 'package:flutter/material.dart';

const newDefaultFontFamily = "Poppins";

class ThemeFonts {
  static TextStyle h1Medium({Color? textColor, bool useCustomLineHeight = true, double lineHeight = 34.0}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 28.0,
        height: useCustomLineHeight ? lineHeight / 24.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle h1Bold({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 28.0,
        height: useCustomLineHeight ? 34.0 / 28.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle h2Bold({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24.0,
        height: useCustomLineHeight ? 33.0 / 24.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle h2Medium({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24.0,
        height: useCustomLineHeight ? 34.0 / 24.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle h3Bold({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20.0,
        height: useCustomLineHeight ? 26.0 / 20.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle h3Medium({Color? textColor, bool useCustomLineHeight = true, double lineHeight = 23.0}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
        height: useCustomLineHeight ? lineHeight / 20.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle sBold({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18.0,
        height: useCustomLineHeight ? 23.0 / 18.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle semiBold({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        height: useCustomLineHeight ? 23.0 / 18.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle sMedium({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
        height: useCustomLineHeight ? 23.0 / 18.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle sRegular({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18.0,
        height: useCustomLineHeight ? 27.0 / 18.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle p1Medium({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        height: useCustomLineHeight ? 23.0 / 16.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle p1Regular({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.0,
        height: useCustomLineHeight ? 24.0 / 16.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle p2Medium({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        height: useCustomLineHeight ? 19.0 / 14.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle p2Regular({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        height: useCustomLineHeight ? 19.0 / 14.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle p3Medium({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
        height: useCustomLineHeight ? 16.0 / 12.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle p3SemiMedium({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12.0,
        height: useCustomLineHeight ? 23.0 / 18.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle p3Regular({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12.0,
        height: useCustomLineHeight ? 16.0 / 12.0 : null,
        fontFamily: newDefaultFontFamily,
        color: textColor,
      );

  static TextStyle c1({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 11.0,
        height: useCustomLineHeight ? 15.0 / 11.0 : null,
        fontFamily: newDefaultFontFamily,
        letterSpacing: 0.01,
        color: textColor,
      );

  static TextStyle c2({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12.0,
        height: useCustomLineHeight ? 14.0 / 12.0 : null,
        fontFamily: newDefaultFontFamily,
        letterSpacing: 0.01,
        color: textColor,
      );

  static TextStyle c0({Color? textColor, bool useCustomLineHeight = true}) => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 9.0,
        height: useCustomLineHeight ? 14.0 / 12.0 : null,
        fontFamily: newDefaultFontFamily,
        letterSpacing: 0.01,
        color: textColor,
      );

  static TextStyle medium(double fontSize) => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
        fontFamily: newDefaultFontFamily,
      );

  static TextStyle bold(double fontSize) => TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        fontFamily: newDefaultFontFamily,
      );
  static TextStyle bold2(double fontSize , Color? textColor) => TextStyle(
    fontWeight: FontWeight.w900,
    color: textColor,
    fontSize: fontSize,
    fontFamily: newDefaultFontFamily,
  );

  static TextStyle black(double fontSize) => TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: fontSize,
        fontFamily: newDefaultFontFamily,
      );

  static TextStyle thin(double fontSize) => TextStyle(
        fontWeight: FontWeight.w100,
        fontSize: fontSize,
        fontFamily: newDefaultFontFamily,
      );

  static TextStyle light(double fontSize) => TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: fontSize,
        fontFamily: newDefaultFontFamily,
      );

  static TextStyle regular(double fontSize) => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        fontFamily: newDefaultFontFamily,
      );
}
