import 'package:http/http.dart' as http;

class HttpService {
  static Future<http.Response> get(String url) async {
    return await http.get(Uri.parse(url)).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(
          'Error',
          408,
        ); // Request Timeout response status code
      },
    );
  }

  static Future<http.Response> post(String url, String body) async {
    return await http
        .post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json', // Set the content type to JSON
      },
      body: body,
    )
        .timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(
          'Error',
          408,
        ); // Request Timeout response status code
      },
    );
  }
}
