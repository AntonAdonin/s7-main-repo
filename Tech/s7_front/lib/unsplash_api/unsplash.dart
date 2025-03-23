import 'dart:convert';

import 'package:http/http.dart' as http;

class UnsplashApi {
  static const String accessKey = "bSc_EkRYYKEUNA22HiM-sEhEg9bMqWJfwCMj6SeskNM";

  static Future<String> fetchCityPhoto(String cityName) async {
    final String url = "https://api.unsplash.com/search/photos?query=city $cityName&per_page=10&client_id=$accessKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['results'].isNotEmpty) {
          String imageUrl = data['results'][0]['urls']['small'];
          print("Фото города $cityName: $imageUrl");
          return imageUrl;
        } else {
          print("Фотографии для $cityName не найдены.");
          return "";
        }
      } else {
        print("Ошибка: ${response.body}");
      }
    } catch (e) {
      print("Произошла ошибка: $e");
    }
    return "";
  }
}
