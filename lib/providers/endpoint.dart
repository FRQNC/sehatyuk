import 'package:flutter/foundation.dart';

class Endpoint {
  static String host = kIsWeb ? "127.0.0.1" : "10.0.2.2";
  static String url = "http://$host:8000/";
}
