import 'package:flutter/material.dart';

class SizedConfig {
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _blockSizeHorizontal;
  static late double _blocSizeVertical;

  static late double textMultiplier;
  static late double imageSizeMultiplier;
  static late double heightMultiplier;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenHeight = constraints.maxHeight;
      _screenWidth = constraints.maxWidth;
    } else {
      _screenHeight = constraints.maxWidth;
      _screenWidth = constraints.maxHeight;
    }
    // _screenHeight = constraints.maxHeight;
    // _screenWidth = constraints.maxWidth;

    _blocSizeVertical = _screenHeight / 100;
    _blockSizeHorizontal = _screenWidth / 100;

    textMultiplier = _blocSizeVertical;
    imageSizeMultiplier = _blockSizeHorizontal;
    heightMultiplier = _blocSizeVertical;
  }
}
