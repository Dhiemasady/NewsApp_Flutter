import 'dart:convert';
import 'package:news_app/model/model.dart';
import 'package:http/http.dart' as http;

String apiKey = 'af5fe18fce394bc4b5f4a2a509552f13';
String baseUrl = 'https://newsapi.org/v2';

class News{
  Future<List<Article>?> getNews() async{
    List<Article>? list;
    String url = '$baseUrl/top-headlines?country=id&apiKey=$apiKey';
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      var result = data['articles'] as List;
      list = result.map<Article>((json) => Article.fromJson(json)).toList();
      return list;
    }else {
      throw Exception('Cant get news data');
    }
  }

  Future<List<Article>?> getNewsByCategory(String category) async{
    List<Article>? list;
    String url = '$baseUrl/top-headlines?country=id&category=$category&apiKey=$apiKey';
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      var result = data['articles'] as List;
      list = result.map<Article>((json) => Article.fromJson(json)).toList();
      return list;
    }else {
      throw Exception('Cant get news data');
    }
  }

  Future<List<Article>?> getNewsSearch(String query) async{
    List<Article>? list;
    String url = '$baseUrl/everything?q=$query&apiKey=$apiKey';
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      var result = data['articles'] as List;
      list = result.map<Article>((json) => Article.fromJson(json)).toList();
      return list;
    }else {
      throw Exception('Cant get news data');
    }
  }

}