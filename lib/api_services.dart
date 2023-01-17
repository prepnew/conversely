import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_key.dart';

String apiKey = openApiKey;

class ApiServices {
  static String baseUrl = "https://api.openai.com/v1/completions";
  static Map<String, String> header = {
    'Content-Type': "application/json",
    'Authorization': "Bearer $apiKey",
  };

  static searchQuery(String? query) async {
    var res = await http.post(Uri.parse(baseUrl),
        headers: header,
        body: jsonEncode({
          "model": "text-davinci-003",
          "prompt": "$query",
          "temperature": 0,
          "max_tokens": 2048,
          "top_p": 1,
          "n": 1,
          "frequency_penalty": 0.0,
          "presence_penalty": 0.0,
          "stop": [" Human:", "AI"]
        }));
    print(res.statusCode);

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      String msg = data['choices']
          .map((e) => e['text'])
          .toList()
          .join('\n\nAnother Example\n\n');

      return msg;
    } else {
      return 'Error Occurred, try again, by pressing back and come here again';
    }
  }
}
