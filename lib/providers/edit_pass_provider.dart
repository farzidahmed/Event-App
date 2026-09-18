import 'package:flutter/material.dart';

class EditPassProvider extends ChangeNotifier{

  bool _editPass = true;
  bool get editPass => _editPass;
  void toggleEditPassword() {
    _editPass = !_editPass;
    notifyListeners();
  }


}