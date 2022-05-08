import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class AvailableOtpMethod {
  final List<dynamic> method;

  const AvailableOtpMethod({
    required this.method,
  });

  factory AvailableOtpMethod.fromJson(Map<String, dynamic> json) {
    return AvailableOtpMethod(method: json['data']['method']);
  }
}

Future<AvailableOtpMethod> fetchAvailableOtpMethod() async {
  final response = await http.get(Uri.parse(''));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return AvailableOtpMethod.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
