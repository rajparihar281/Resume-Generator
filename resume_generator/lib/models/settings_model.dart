import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 1)
class UserSettings extends HiveObject {
  @HiveField(0)
  double fontSize;

  @HiveField(1)
  int fontColor;

  @HiveField(2)
  int backgroundColor;

  UserSettings({
    this.fontSize = 18.0,
    this.fontColor = 0xFFFF5722, // Orange-red
    this.backgroundColor = 0xFF81C784, // Light green
  });

  Color get fontColorValue => Color(fontColor);
  Color get backgroundColorValue => Color(backgroundColor);
}
