import 'package:flutter/material.dart';

class ResetPassProvider extends ChangeNotifier{
    bool _resetPass = true;
  bool get resetPass => _resetPass;
  void toggleResetPassword() {
    _resetPass = !_resetPass;
    notifyListeners();
  }
    bool _resetConfirmPass = true;
  bool get resetConfirmPass => _resetConfirmPass;
  void toggleResetConfirm() {
    _resetConfirmPass = !_resetConfirmPass;
    notifyListeners();
  }
}