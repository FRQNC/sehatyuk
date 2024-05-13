import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/models/users.dart';
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:sehatyuk/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<String> register(BuildContext context, Users user) async {
    final response = await http.post(
      Uri.parse('${Endpoint.url}create_user/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "nama_lengkap_user": user.namaLengkap,
        "tgl_lahir_user": user.tanggalLahir,
        "gender_user": user.gender,
        "alamat_user": user.alamat,
        "no_bpjs_user": user.noBPJS,
        "no_telp_user": user.noTelp,
        "foto_user": user.photoUrl,
        "email_user": user.email,
        "password_user": user.password,
      }),
    );

    if (response.statusCode == 200) {
      // login(context, user);
      return loginEmail(context, user.email, user.password); // registration successful
    } else {
      String result = response.body;
      if(result.contains("Error: Email sudah digunakan") || result.contains("Error: No telp sudah digunakan")){
        return "credential_error";
      }
      return "failed";
    }
  }

  Future<String> loginPhone(BuildContext context, String phone, String password) async {
    final response = await http.post(
      Uri.parse('${Endpoint.url}login_phone'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
          "phone_user": phone,
          "password_user": password,
        }),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      var token = json['access_token'];
      var id = json['user_id'].toString();
      
      setToken(token);
      setId(id);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RoutePage()),
      );
      return "sukses";
    } else {
      String result = response.body;
      if(result.contains("Username atau password tidak cocok")){
        return "credential_error";
      }
      return "failed";
    }
  }

  Future<String> loginEmail(BuildContext context, String email, String password) async {
    final response = await http.post(
      Uri.parse('${Endpoint.url}login_email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
          "email_user": email,
          "password_user": password,
        }),
    );

    print(response.body);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      var token = json['access_token'];
      var id = json['user_id'].toString();
      
      setToken(token);
      setId(id);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RoutePage()),
      );
      return "sukses";
    } else {
      String result = response.body;
      if(result.contains("Username atau password tidak cocok")){
        return "credential_error";
      }
      return "failed";
    }
  }

  Future<void> setToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', value);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

  Future<void> setId(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', value);
  }

  Future<String> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id') ?? "";
  }
}
