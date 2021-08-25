import 'package:flutter/cupertino.dart';

class Util extends ChangeNotifier {
  var _xOffset = 0.0;
  var _yOffset = 0.0;
  var _scale = 1.0;

  void openDrawer() {
    xOffset = 250.0;
    yOffset = 150.0;
    scale = 0.65;
    notifyListeners();
  }

  void closeDrawer() {
    xOffset = 0.0;
    yOffset = 0.0;
    scale = 1.0;
    notifyListeners();
  }

  bool isDrawerOpen() {
    return yOffset != 0 && xOffset != 0;
  }

  get scale => _scale;

  set scale(value) {
    _scale = value;
  }

  get yOffset => _yOffset;

  set yOffset(value) {
    _yOffset = value;
  }

  get xOffset => _xOffset;

  set xOffset(value) {
    _xOffset = value;
  }
}
