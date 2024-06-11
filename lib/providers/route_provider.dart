import 'package:flutter/material.dart';
import 'package:sehatyuk/models/jadwal_dokter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/providers/endpoint.dart';

class RouteProvider extends ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }
}
