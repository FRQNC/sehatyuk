import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/providers/endpoint.dart';

import 'package:sehatyuk/models/janji_temu.dart';
import 'package:sehatyuk/models/doctor.dart';
import 'package:sehatyuk/models/jadwal_dokter.dart';

class JanjiTemuProvider extends ChangeNotifier {
  List<JanjiTemu> _janjiTemuList = [];
  List<JanjiTemu> get janjiTemuList => _janjiTemuList;

  set janjiTemuList(List<JanjiTemu> value) {
    _janjiTemuList = value;
    notifyListeners();
  }

  // nunggu web service
} 