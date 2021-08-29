import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/constants/colors.dart';

class Util extends ChangeNotifier {
  var _xOffset = 0.0;
  var _yOffset = 0.0;
  var _scale = 1.0;
  var _title;
  var _id;
  var _docID;
  var _color;
  var _pickedColor;

  var colors = [blue, orange, teal];

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

  get title => _title;

  set title(value) {
    _title = value;
    notifyListeners();
  }

  get id => _id;

  set id(value) {
    _id = value;
    notifyListeners();
  }

  get color => _color;

  set color(value) {
    _color = value;
    notifyListeners();
  }

  get docID => _docID;

  set docID(value) {
    _docID = value;
    notifyListeners();
  }

  get pickedColor => _pickedColor;

  set pickedColor(value) {
    _pickedColor = value;
    notifyListeners();
  }
}
