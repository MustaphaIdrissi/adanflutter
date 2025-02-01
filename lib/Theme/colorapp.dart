import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorApp {
  static final ColorApp _instance = ColorApp._internal();

  factory ColorApp() {
    return _instance;
  }

  ColorApp._internal();

  Color background = Color.fromARGB(255, 189, 155, 128);
  Color background2 = Color.fromARGB(255, 14, 221, 194);
  Color Textcolor = Color(0xFFFFFFFF);
  Color Textcolor2 = Color.fromARGB(255, 0, 0, 0);
  Color trans = Colors.transparent;
  Color shado1 = Colors.grey.withOpacity(0.5);

  static const _backgroundColorKey = 'backgroundColor';
  static const _background2ColorKey = 'background2Color';
  static const _textColorKey = 'textColor';
  static const _textColor2Key = 'textColor2';

  Future<void> loadColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? bgColorValue = prefs.getInt(_backgroundColorKey);
    int? bg2ColorValue = prefs.getInt(_background2ColorKey);
    int? textColorValue = prefs.getInt(_textColorKey);
    int? textColor2Value = prefs.getInt(_textColor2Key);

    if (bgColorValue != null) background = Color(bgColorValue);
    if (bg2ColorValue != null) background2 = Color(bg2ColorValue);
    if (textColorValue != null) Textcolor = Color(textColorValue);
    if (textColor2Value != null) Textcolor2 = Color(textColor2Value);
  }

  Future<void> updateColors(
      {Color? background,
      Color? background2,
      Color? textColor,
      Color? textColor2}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (background != null) {
      this.background = background;
      await prefs.setInt(_backgroundColorKey, background.value);
    }
    if (background2 != null) {
      this.background2 = background2;
      await prefs.setInt(_background2ColorKey, background2.value);
    }
    if (textColor != null) {
      this.Textcolor = textColor;
      await prefs.setInt(_textColorKey, textColor.value);
    }
    if (textColor2 != null) {
      this.Textcolor2 = textColor2;
      await prefs.setInt(_textColor2Key, textColor2.value);
    }
  }
}
