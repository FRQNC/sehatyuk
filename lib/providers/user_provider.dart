import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sehatyuk/models/users.dart';

class UserProvider extends ChangeNotifier {
  int? _userId;
  String? _token = "";
  Users? _userData; // tambahkan variabel untuk menyimpan data pengguna

  void setUserFromJson(Map<String, dynamic> json) {
    _token = json["access_token"];
    _userId = json["user_id"];
    notifyListeners();
  }

  Future<String> register(String email, String password) async {
    final response = await http.post(
        Uri.parse(""),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.body);
      return "failed";
    }
  }

  Future<String> login(String email, String password) async {
    final response = await http.post(
        Uri.parse(""),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "failed";
    }
  }

  Future<String> updateUserProfile(Users updatedUser) async {
    final response = await http.put(
      Uri.parse(""),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode(updatedUser.toJson()),
    );

    if (response.statusCode == 200) {
      // Update successful
      return "success";
    } else {
      // Update failed
      print(response.body);
      return "failed";
    }
  }

  Future<void> fetchData(String token) async {
    try {
      final url = Uri.parse(''); 
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _userData = Users.fromJson(responseData); 
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      notifyListeners();

    }
  }

  String? get token => _token;
  int? get userId => _userId;
  Users? get userData => _userData; // Getter untuk mengakses data pengguna
}