import 'package:flutter/material.dart';

import 'index.dart';

TextStyle latoText = const TextStyle(fontFamily: TextFontFamily.lato);


class TextFontFamily {
  static const String lato = "Lato";
}

extension TextStypeExtension on TextStyle {
//==============================================================================
// ** Common Weight **
//==============================================================================
  TextStyle get bold => weight(FontWeight.w700);

  TextStyle get normal => weight(FontWeight.w400);

  TextStyle get thin => weight(FontWeight.w100);

//==============================================================================
// ** decoration **
//==============================================================================
  TextStyle decoration(dynamic v) => copyWith(decoration: v);

  TextStyle get underLine => decoration(TextDecoration.underline);

//==============================================================================
// ** FontSize **
//==============================================================================
  TextStyle size(double v) => copyWith(fontSize: v);

  TextStyle get get10 => size(10);

  TextStyle get get12 => size(12);

  TextStyle get get13 => size(13);

  TextStyle get get14 => size(14);

  TextStyle get get15 => size(15);

  TextStyle get get16 => size(16);
  TextStyle get get17 => size(17);

  TextStyle get get18 => size(18);

  TextStyle get get20 => size(20);

  TextStyle get get22 => size(22);

  TextStyle get get24 => size(24);

  TextStyle get get26 => size(26);

  TextStyle get get28 => size(28);

  TextStyle get get30 => size(30);

  TextStyle get get34 => size(34);

  TextStyle get get40 => size(40);

//==============================================================================
// ** FontWeight **
//==============================================================================

  TextStyle weight(FontWeight v) => copyWith(fontWeight: v);

  TextStyle get w100 => weight(FontWeight.w100);

  TextStyle get w200 => weight(FontWeight.w200);

  TextStyle get w300 => weight(FontWeight.w300);

  TextStyle get w400 => weight(FontWeight.w400);

  TextStyle get w500 => weight(FontWeight.w500);

  TextStyle get w600 => weight(FontWeight.w600);

  TextStyle get w700 => weight(FontWeight.w700);

  TextStyle get w800 => weight(FontWeight.w800);

  TextStyle get w900 => weight(FontWeight.w900);

//==============================================================================
// ** TextColor **
//==============================================================================
  TextStyle textColor(Color v) => copyWith(color: v);

  TextStyle get xff000000 => textColor(appColors.xff000000);

  TextStyle get xffFFFFFF => textColor(appColors.xffFFFFFF);

  TextStyle get xff1E1E1E => textColor(appColors.xff1E1E1E);

  TextStyle get xff006685 => textColor(appColors.xff006685);

  TextStyle get xffF44336 => textColor(appColors.xffF44336);

  TextStyle get xff474747 => textColor(appColors.xff474747);

//==============================================================================
// ** letterSpace **
//==============================================================================
  TextStyle letterSpace(double v) => copyWith(letterSpacing: v);

  TextStyle get space01 => letterSpace(0.1);

  TextStyle get space02 => letterSpace(0.2);

  //==============================================================================
// ** TextHeight **
//==============================================================================
  TextStyle textHeight(double v) => copyWith(height: v);

  TextStyle get height01 => textHeight(1.0);

  TextStyle get height0102 => textHeight(1.2);

  TextStyle get height0105 => textHeight(1.5);

  //==============================================================================
// ** TextStyle **
//==============================================================================
  TextStyle customStyle({
    double? letterSpacing,
    double? height,
    double? fontSize,
    FontWeight? weight,
  }) =>
      copyWith(
        letterSpacing: letterSpacing,
        height: height,
        fontSize: fontSize,
        fontWeight: weight,
      );
}
