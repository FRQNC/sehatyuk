import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'dart:convert';
import 'package:sehatyuk/models/relasi.dart';
import 'package:sehatyuk/providers/endpoint.dart';

class RelasiProvider extends ChangeNotifier {
  List<Relasi> _relasiList = [];

  List<Relasi> get relasiList => _relasiList;

  set relasiList(List<Relasi> value) {
    _relasiList = value;
    notifyListeners();
  }

  AuthService auth = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }


  Future<void> fetchData(String id, String token) async {
    try {
      final url = Uri.parse("${Endpoint.url}get_relasi/$id");
      final response = await http.get(
        url,
        headers: {
          'accept': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        _relasiList = responseData.map((data) => Relasi.fromJson(data)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<Map<String, dynamic>> addRelasi(String token, Relasi relasi) async{
    _setLoading(true);
    final response = await http.post(
      Uri.parse("${Endpoint.url}create_relasi/"),
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(relasi.toJson())
    );
    _setLoading(false);
    if(response.statusCode == 200){
      var result = json.decode(response.body);
      result['statusCode'] = 200;
      return result;
    }
    else{
      return {"error" : "gagal menambahkan relasi"};
    }
  }

  Future<String> addRelasiImage(int id_relasi, File file) async {
  String token = await auth.getToken();
  try {
    // Detect the file's MIME type
    String? mimeType = lookupMimeType(file.path);
    mimeType ??= 'application/octet-stream';

    // Create multipart request
    var request = http.MultipartRequest('POST', Uri.parse("${Endpoint.url}upload_relasi_image/$id_relasi"))
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType.parse(mimeType),
      ));

    // Log request details
    print('Sending request to: ${request.url}');
    print('Headers: ${request.headers}');
    print('Files: ${request.files.map((f) => f.filename).join(', ')}');

    // Send request
    var response = await request.send();

    // Get response data
    var responseData = await http.Response.fromStream(response);

    // Log response details
    print('Response status: ${response.statusCode}');
    print('Response body: ${responseData.body}');

    if (response.statusCode == 200) {

      return "success";
    } else {
      return "failed: ${responseData.body}";
    }
  } catch (e) {
    print('Exception: $e');
    return "failed: $e";
  }
}
}
