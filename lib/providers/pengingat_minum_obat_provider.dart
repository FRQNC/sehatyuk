import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sehatyuk/models/pengingat_minum_obat.dart';
import 'package:sehatyuk/providers/endpoint.dart';

class PengingatMinumObatProvider extends ChangeNotifier {
  List<PengingatMinumObat> _pengingatMinumObatList = [];

  List<PengingatMinumObat> get pengingatMinumObatList =>
      _pengingatMinumObatList;

  PengingatMinumObat _dataPengingatMinumObat = PengingatMinumObat(
      idPengingat: 0,
      idObat: 0,
      idUser: 0,
      dosis: 0,
      sendok: '',
      jadwal: '',
      aturan: '',
      obat: {},
      user: {});

  PengingatMinumObat get dataPengingatMinumObat => _dataPengingatMinumObat;

  set pengingatMinumObatList(List<PengingatMinumObat> value) {
    _pengingatMinumObatList = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<bool> createPengingatMinumObat(
      String token, PengingatMinumObat pengingat_minum_obat) async {
    _setLoading(true);
    final response = await http.post(
      Uri.parse('${Endpoint.url}create_pengingat_minum_obat/'),
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(pengingat_minum_obat.toJson()),
    );
    _setLoading(false);
    if (response.statusCode == 200) {
      _pengingatMinumObatList
          .add(PengingatMinumObat.fromJson(json.decode(response.body)));
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteData(String token, String idPengingat) async {
    try {
      final url = Uri.parse(
          '${Endpoint.url}delete_pengingat_minum_obat_by_id/$idPengingat');
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
        _pengingatMinumObatList.removeWhere(
            (pengingat) => pengingat.idPengingat.toString() == idPengingat);
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

  Future<void> fetchData(String token, String idUser) async {
    try {
      final url = Uri.parse(
          '${Endpoint.url}get_pengingat_minum_obat/$idUser'); // url read obat
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        _pengingatMinumObatList = responseData
            .map((data) => PengingatMinumObat.fromJson(data))
            .toList();
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
