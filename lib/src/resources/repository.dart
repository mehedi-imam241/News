import 'package:news/src/models/item_models.dart';
import 'package:news/src/resources/news_api_provider.dart';
import 'package:news/src/resources/news_db_provider.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  fetchItem(int id) async {
    ItemModels item;
    Source source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) break;
    }

    for (var cache in caches) cache.addItem(item);

    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModels> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModels item);
}
