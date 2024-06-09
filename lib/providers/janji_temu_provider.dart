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
    print(janji_temu.idOrangLain);

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
        _janjiTemuList = responseData.map((data) => JanjiTemu.fromJson(data)).toList();
        notifyListeners(); // Memberi tahu pendengar tentang perubahan pada data
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      notifyListeners(); // Memberi tahu pendengar bahwa terjadi kesalahan
      // Handle error sesuai dengan kebutuhan aplikasi Anda
    }
  }

  Future<bool> deleteData(String token, String id) async {
    try {
      final url = Uri.parse('${Endpoint.url}delete_janji_temu/$id');
      final response = await http.delete(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Jika penghapusan berhasil, kita perlu menghapus item dari daftar janji temu lokal
        _janjiTemuList.removeWhere((janjiTemu) => janjiTemu.id.toString() == id);
        notifyListeners(); // Memberi tahu pendengar bahwa ada perubahan pada data
        return true; // Penghapusan berhasil
      } else {
        return false; // Penghapusan gagal
      }
    } catch (error) {
      print('Error: $error');
      return false; // Penghapusan gagal karena kesalahan
      // Handle error sesuai dengan kebutuhan aplikasi Anda
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
        // Jika penghapusan berhasil, kita perlu menghapus item dari daftar janji temu lokal
        final updatedJanjiTemu = JanjiTemu.fromJson(json.decode(response.body));
      
        // Update the status of the item in the local list
        final index = _janjiTemuList.indexWhere((janjiTemu) => janjiTemu.id == updatedJanjiTemu.id);
        if (index != -1) {
          _janjiTemuList[index] = updatedJanjiTemu;
          notifyListeners(); // Notify listeners about the data change
        }
        
        return true; // Penghapusan berhasil
      } else {
        return false; // Penghapusan gagal
      }
    } catch (error) {
      print('Error: $error');
      return false; // Penghapusan gagal karena kesalahan
      // Handle error sesuai dengan kebutuhan aplikasi Anda
    }
  }

} 