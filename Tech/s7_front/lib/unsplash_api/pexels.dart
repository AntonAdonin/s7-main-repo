import 'dart:convert';

import 'package:http/http.dart' as http;

class PexelsApi {
  static String apiKey = "Li6C9rRz1aZSJAOzNQUKgU7rb5nATihXm2AUKbrPAtyVOfY4fS5kVmVu";

  static Future<String> fetchCityPhoto(String cityName) async {
    final String url = "https://api.pexels.com/v1/search?query=$cityName skyline OR landmarks OR famous places&per_page=1";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": apiKey},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['photos'].isNotEmpty) {
          String imageUrl = data['photos'][0]['src']['medium']; // Можно выбрать другой размер
          print("Фото города $cityName: $imageUrl");
          return imageUrl;
        } else {
          print("Фотографии для $cityName не найдены.");
        }
      } else {
        print("Ошибка: ${response.statusCode}");
      }
    } catch (e) {
      print("Произошла ошибка: $e");
    }
    return "";
  }
}