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

  Future<bool> createJanjiTemu(String token, JanjiTemu janji_temu) async {
    final response = await http.post(
      Uri.parse('${Endpoint.url}create_janji_temu/'),
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(janji_temu.toJson()),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      // login(context, user);
      // return loginEmail(context, user.email, user.password); // registration successful
      return true;
    } else {
      // String result = response.body;
      // if(result.contains("Error: Email sudah digunakan") || result.contains("Error: No telp sudah digunakan")){
      //   return "credential_error";
      // }
      // return "failed";
      return false;
    }
  }
} 