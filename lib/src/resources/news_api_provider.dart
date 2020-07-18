import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:news/src/models/item_models.dart';
import 'package:news/src/resources/repository.dart';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client
        .get('https://hacker-news.firebaseio.com/v0/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModels> fetchItem(int id) async {
    final response = await client
        .get('https://hacker-news.firebaseio.com/v0/item/$id.json?');
    final parsedJson = json.decode(response.body);

    return ItemModels.fromJson(parsedJson);
  }
}
