import 'package:flutter/material.dart';
import 'package:news_app/model/model.dart';
import 'package:news_app/screen/newspage.dart';
import 'package:news_app/service/service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var news = News();
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          width: 10,
          margin: const EdgeInsets.all(8),
        ),
        title: const Text(
          '',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: news.getNews(),
        builder: (context, snapshot) => snapshot.data != null
            ? NewsPage(article: snapshot.data as List<Article>)
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
