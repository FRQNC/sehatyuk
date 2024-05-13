import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sehatyuk/models/users.dart';

class UserProvider extends ChangeNotifier {
  int? _userId;
  String? _token = "";

  void setUserFromJson(Map<String, dynamic> json) {
    _token = json["access_token"];
    _userId = json["user_id"];
    notifyListeners();
  }

  Future<String> register(String email, String password) async {
    final response = await http.post(
        Uri.parse("your_register_endpoint_url"),
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
        Uri.parse("your_login_endpoint_url"),
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
      Uri.parse("your_update_user_profile_endpoint_url"),
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

  String? get token => _token;
  int? get userId => _userId;
}
