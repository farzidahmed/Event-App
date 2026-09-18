import 'package:flutter/material.dart';

class ReviewProvider with ChangeNotifier {
  bool _showReview = false;

  bool get showReview => _showReview;

  void toggleReview() {
    _showReview = !_showReview;
    notifyListeners();
  }

  void show() {
    _showReview = true;
    notifyListeners();
  }

  void hide() {
    _showReview = false;
    notifyListeners();
  }
}
