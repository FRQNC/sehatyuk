import 'package:flutter/material.dart';

class WelcomeDialogProvider extends ChangeNotifier{
  bool _openedFirstTime = true;

  bool get openedFirstTime => _openedFirstTime;

  set changeOpenedFirstTime(bool value){
    _openedFirstTime = value;
    notifyListeners();
  }
  
}