import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_notifications/src/models/category_model.dart';
import 'package:news_notifications/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _urlNews = 'https://newsapi.org/v2';
const _apiKey = 'ee8a5ab793f54922abd95c2a84e5e95a';

class NewsService extends ChangeNotifier {
  List<Article> headLines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadLines();

    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });
    getarticlesByCategory(_selectedCategory);
  }

  get gselectedCategory => _selectedCategory;

  set selectedCategory(String valor) {
    _selectedCategory = valor;

    getarticlesByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada =>
      categoryArticles[gselectedCategory];

  getTopHeadLines() async {
    // ignore: avoid_print
    print('Cargando headlines...');

    const url = '$_urlNews/top-headlines?apiKey=$_apiKey&country=us';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = NewsResponse.fromJson(resp.body);

    headLines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getarticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }

    final url =
        '$_urlNews/top-headlines?apiKey=$_apiKey&country=us&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = NewsResponse.fromJson(resp.body);
    categoryArticles[category]!.addAll(newsResponse.articles);

    notifyListeners();
  }
}
