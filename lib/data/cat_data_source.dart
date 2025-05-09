import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/entities/cat.dart';

class CatDataSource {
  static const _apiKey =
      'live_4fieRZZ17w99GdAXqmG4BbueWzgwMtDrBlcCsa310ssO6OnqNdLQEwxDZs0eDOB9';
  static const _baseUrl = 'https://api.thecatapi.com/v1';

  Future<Cat> fetchRandomCat() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/images/search?has_breeds=true'),
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode != 200) throw Exception('API Error');

    final List<dynamic> dataList = json.decode(response.body);
    if (dataList.isEmpty) throw Exception('No cats found');

    final data = dataList[0];
    final breeds = data['breeds'] as List?;

    if (breeds == null || breeds.isEmpty) {
      return Cat(
        id: data['id'] ?? 'unknown',
        imageUrl: data['url'] ?? '',
        breed: 'Unknown Breed',
        description: 'No description',
        temperament: 'No data',
        origin: 'Unknown',
      );
    }
    return Cat(
      id: data['id'] ?? 'unknown',
      imageUrl: data['url'] ?? '',
      breed: breeds[0]['name'] ?? 'Unknown Breed',
      description: breeds[0]['description'] ?? 'No description',
      temperament: breeds[0]['temperament'] ?? 'No data',
      origin: breeds[0]['origin'] ?? 'Unknown',
    );
  }
}
