import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/auth/auth.dart';
import 'dart:convert';
import 'package:sehatyuk/models/users.dart';
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:sehatyuk/route.dart';

class UserProvider extends ChangeNotifier {
  // int? _userId;
  // String? _token = "";
  Users _userData = Users(namaLengkap: '', tanggalLahir: '', gender: '', alamat: '', noBPJS: '', noTelp: '', email: '', password: '', photoUrl: ''); // tambahkan variabel untuk menyimpan data pengguna
  Users get userData => _userData; // Getter untuk mengakses data pengguna

  AuthService auth = AuthService();

  // Future<void> setUserFromJson(Map<String, dynamic> json) async {
  //   _token = json["access_token"];
  //   _userId = json["user_id"];
  //   notifyListeners();
  //   print(_userId.toString() + "AAAAAAAAAAAAAAAAAAAAAAA");
  // }

  Future<String> register(BuildContext context, Users user) async {
    final response = await http.post(
      Uri.parse(Endpoint.url + "create_user/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
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
      })
    );
    if (response.statusCode == 200) {
      // loginByEmail(context, user.email, user.password);
      return loginByEmail(context, user.email, user.password);;
    } else {
      String result = response.body;
      if(result.contains("Error: Email sudah digunakan") || result.contains("Error: No telp sudah digunakan")){
        return "credential_error";
      }
      return "failed";
    }
  }

  Future<String> loginByEmail(BuildContext context, String email, String password) async {
    final response = await http.post(
        Uri.parse(Endpoint.url+"login_email"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          "email_user": email,
          "password_user": password,
        }));

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      auth.setId(data['user_id'].toString());
      auth.setToken(data['access_token']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RoutePage()));
      return "sukses";
    } else {
      String result = response.body;
      if(result.contains("Username atau password tidak cocok")){
        return "credential_error";
      }
      return "failed";
    }
  }

  Future<String> loginByPhone(BuildContext context, String phone, String password) async {
    final response = await http.post(
        Uri.parse(Endpoint.url+"login_no_telp"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          "no_telp_user": phone,
          "password_user": password,
        }));

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      auth.setId(data['user_id'].toString());
      auth.setToken(data['access_token']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RoutePage()));
      return "sukses";
    } else {
      String result = response.body;
      if(result.contains("Username atau password tidak cocok")){
        return "credential_error";
      }
      return "failed";
    }
  }

  // Future<String> updateUserProfile(Users updatedUser) async {
  //   final response = await http.put(
  //     Uri.parse(Endpoint.url),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': 'Bearer $_token',
  //     },
  //     body: jsonEncode(updatedUser.toJson()),
  //   );

  //   if (response.statusCode == 200) {
  //     // Update successful
  //     return "success";
  //   } else {
  //     // Update failed
  //     print(response.body);
  //     return "failed";
  //   }
  // }

  Future<void> fetchData() async {
    try {
      String id = await auth.getId();
      String token = await auth.getToken();
      final url = Uri.parse("http://10.0.2.2:8000/get_user_by_id/$id"); 
      print(url);
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _userData = Users.fromJson(responseData); 
        print(_userData);
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  // String? get token => _token;
  // int? get userId => _userId;
}