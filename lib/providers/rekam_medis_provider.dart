import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:sehatyuk/models/rekam_medis.dart';

class RekamMedisProvider extends ChangeNotifier {
  List<RekamMedis> _rekamMedisList = [];
  RekamMedis? _selectedRekamMedis;
  bool _isLoading = false;

  List<RekamMedis> get rekamMedisList => _rekamMedisList;
  RekamMedis? get selectedRekamMedis => _selectedRekamMedis;
  bool get isLoading => _isLoading;

  set rekamMedisList(List<RekamMedis> value) {
    _rekamMedisList = value;
    notifyListeners();
  }

  set selectedRekamMedis(RekamMedis? value) {
    _selectedRekamMedis = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchRekamMedisByUser(String token, int userId) async {
    isLoading = true;

    final url = Uri.parse('${Endpoint.url}rekam_medis/user/$userId/selesai');
    try {
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) ?? [];
        rekamMedisList = data.map((json) => RekamMedis.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load rekam medis');
      }
    } catch (error) {
      print('Error fetching rekam medis by user: $error');
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchRekamMedisById(String token, int rekamMedisId) async {
    isLoading = true;

    final url = Uri.parse('${Endpoint.url}rekam_medis/$rekamMedisId');
    try {
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>?;
        if (data != null) {
          selectedRekamMedis = RekamMedis.fromJson(data);
        } else {
          throw Exception('Rekam medis data is null');
        }
      } else {
        throw Exception('Failed to load rekam medis');
      }
    } catch (error) {
      print('Error fetching rekam medis by ID: $error');
    } finally {
      isLoading = false;
    }
  }

  void clearSelectedRekamMedis() {
    selectedRekamMedis = null;
  }
}

