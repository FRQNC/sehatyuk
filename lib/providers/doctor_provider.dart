import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sehatyuk/models/doctor.dart';
import 'package:sehatyuk/models/jadwal_dokter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/models/janji_temu.dart';
import 'package:sehatyuk/providers/endpoint.dart';
import 'dart:core';

class DoctorProvider extends ChangeNotifier {
  List<Doctor> _doctors = [];
  List<JadwalDokter> _jadwal_dokter = [];
  Doctor _dataDokter = Doctor(
      id: 0,
      namaLengkap: '',
      spesialis: '',
      pengalaman: 0,
      alumnus: '',
      harga: 0,
      minatKlinis: '',
      foto: '',
      rating: 0,
      idPoli: 0,
      poli: {});
  List<Doctor> _dataDokterJoin = [];

  List<Doctor> get doctors => _doctors;
  List<JadwalDokter> get jadwal_dokter => _jadwal_dokter;
  Doctor get dataDokter => _dataDokter;
  List<Doctor> get dataDokterJoin => _dataDokterJoin;

  set doctors(List<Doctor> value) {
    _doctors = value;
    notifyListeners();
  }

  set jadwal_dokter(List<JadwalDokter> value) {
    _jadwal_dokter = value;
    notifyListeners();
  }

  Future<void> fetchData(String token) async {
    try {
      final url = Uri.parse('${Endpoint.url}get_dokter/');
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _doctors = responseData.map((data) => Doctor.fromJson(data)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      notifyListeners();
    }
  }

  Future<void> fetchDataById(String token, int id) async {
    try {
      final url = Uri.parse('${Endpoint.url}get_dokter_by_id/$id');
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        _dataDokter = Doctor.fromJson(responseData);
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      notifyListeners();
    }
  }

  Future<void> fetchDataJoin(String token, List<JanjiTemu> janji_temu) async {
    _dataDokterJoin.clear();
    for (int i = 0; i < janji_temu.length; i++) {
      await fetchDataById(token, janji_temu[i].idDokter);
      _dataDokterJoin.add(_dataDokter);
      notifyListeners();
    }
  }

  Future<void> fetchDataJadwal(String token, String id) async {
    try {
      final url = Uri.parse('${Endpoint.url}get_jadwal_dokter_by_id/$id');
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _jadwal_dokter =
            responseData.map((data) => JadwalDokter.fromJson(data)).toList();
            DateTime now = new DateTime.now();
            DateTime date = new DateTime(now.year, now.month, now.day);
            for(int i = _jadwal_dokter.length - 1;i >= 0;i--){
              if(_jadwal_dokter[i].tanggalJadwalDokter.isBefore(date)){
                print("$i ${_jadwal_dokter[i].tanggalJadwalDokter} | date now : $date");
                _jadwal_dokter.removeAt(i);
              }
            }
            for (var element in _jadwal_dokter) {
              print(element.tanggalJadwalDokter); 
            }
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      notifyListeners();
    }
  }
}
