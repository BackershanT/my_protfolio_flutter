import 'package:flutter/material.dart';

class CursorProvider with ChangeNotifier {
  bool _isHovering = false;
  Offset _pointerPosition = Offset.zero;

  bool get isHovering => _isHovering;
  Offset get pointerPosition => _pointerPosition;

  void setHovering(bool value) {
    if (_isHovering != value) {
      _isHovering = value;
      notifyListeners();
    }
  }

  void updatePosition(Offset position) {
    _pointerPosition = position;
    notifyListeners();
  }
}
