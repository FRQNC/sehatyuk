import 'package:flutter/material.dart';
import 'package:sehatyuk/models/jadwal_dokter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/providers/endpoint.dart';

class RouteProvider extends ChangeNotifier{
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  // Future<void> fetchData(String token) async {
  //   try {
  //     final url = Uri.parse('${Endpoint.url}get_jadwal_dokter/');
  //     final response = await http.get(
  //       url,
  //       headers: {
  //         'accept' : 'application/json',
  //         'Authorization': 'Bearer $token', 
  //       }
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> responseData = json.decode(response.body);
  //       _jadwalDokter = responseData.map((data) => JadwalDokter.fromJson(data)).toList();
  //       notifyListeners();
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //     notifyListeners();
  //   }
  // }
}