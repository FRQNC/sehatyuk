import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:sehatyuk/models/janji_temu.dart';

class JanjiTemuProvider extends ChangeNotifier {
  List<JanjiTemu> _janjiTemuList = [];
  List<JanjiTemu> get janjiTemuList => _janjiTemuList;

  set janjiTemuList(List<JanjiTemu> value) {
    _janjiTemuList = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }


  Future<bool> createJanjiTemu(String token, JanjiTemu janji_temu) async {
    _setLoading(true);
    final response = await http.post(
      Uri.parse('${Endpoint.url}create_janji_temu/'),
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(janji_temu.toJson()),
    );
    _setLoading(false);
    print(response.statusCode);
    print(janji_temu.idOrangLain);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> fetchData(String token, String id) async {
    try {
      final url = Uri.parse('${Endpoint.url}get_janji_temu/$id');
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _janjiTemuList =
            responseData.map((data) => JanjiTemu.fromJson(data)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      notifyListeners();
    }
  }

  Future<bool> deleteData(String token, String id) async {
    try {
      final url = Uri.parse('${Endpoint.url}delete_janji_temu/$id');
      _setLoading(true);
      final response = await http.delete(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      _setLoading(false);
      if (response.statusCode == 200) {
        _janjiTemuList
            .removeWhere((janjiTemu) => janjiTemu.id.toString() == id);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }

  Future<bool> alter_status(String token, String id) async {
    try {
      final url = Uri.parse('${Endpoint.url}alter_status/$id');
      final response = await http.put(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final updatedJanjiTemu = JanjiTemu.fromJson(json.decode(response.body));

        final index = _janjiTemuList
            .indexWhere((janjiTemu) => janjiTemu.id == updatedJanjiTemu.id);
        if (index != -1) {
          _janjiTemuList[index] = updatedJanjiTemu;
          notifyListeners();
        }

        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }
}
