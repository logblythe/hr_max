import 'package:hrmax/network/api_provider.dart';
import 'package:hrmax/network/models/chuch_categories.dart';
import 'package:hrmax/network/models/jokes.dart';

class UserService{
  ApiProvider _provider=ApiProvider();

  Future<ChuchCategories> getCategories() async{
    final response = await _provider.get("jokes/categories");
    return ChuchCategories.fromJson(response);
  }

  Future<Jokes> fetchChuckJoke(String category) async {
    final response = await _provider.get("jokes/random?category=" + category);
    return Jokes.fromJson(response);
  }
}