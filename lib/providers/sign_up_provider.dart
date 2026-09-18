
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
    bool _newPass = true;
  bool get newPass => _newPass;
  void toggleNewPassword() {
    _newPass = !_newPass;
    notifyListeners();
  }

    bool _confimPass = true;
  bool get confimPass => _confimPass;
  void toggleConfirmPassword() {
    _confimPass = !_confimPass;
    notifyListeners();
  }
}
