import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/model/model.dart';
import 'package:news_app/model/saved_news.dart';
import 'package:news_app/screen/detailpage.dart';
import 'package:news_app/utils/utils.dart';
import 'package:news_app/widget/news_item.dart';

class SavedNewsPage extends StatefulWidget {
  const SavedNewsPage({Key? key}) : super(key: key);

  @override
  _SavedNewsPageState createState() => _SavedNewsPageState();
}

class _SavedNewsPageState extends State<SavedNewsPage> {
  Box<SavedNews> localDB = Hive.box<SavedNews>("savedNews_list");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Saved News",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: localDB.listenable(),
        builder: (BuildContext context, Box<dynamic> value, Widget? child){
          if(value.isEmpty){
            return Center(
              child: Text('Favorite Manga listing is Empty'),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: localDB.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 24),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "${localDB.getAt(index)?.urlToImage}",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${localDB.getAt(index)?.title}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: tittleArticle.copyWith(fontSize: 12),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_outlined,
                                        size: 12,
                                      ),
                                      const SizedBox(width: 3),
                                      SizedBox(
                                        width: 70,
                                        child: Text(
                                          "${localDB.getAt(index)?.publishedAt}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: authorDataArticle.copyWith(fontSize: 12),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        size: 12,
                                      ),
                                      const SizedBox(width: 3),
                                      SizedBox(
                                        width: 70,
                                        child: Text(
                                          "${localDB.getAt(index)?.author}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: authorDataArticle.copyWith(fontSize: 12),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );;
          }
        },
      ),
    );
  }

  // Widget _listNewsSaved(List<Article> article) {
  //   return Container(
  //     height: MediaQuery
  //         .of(context)
  //         .size
  //         .height,
  //     margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  //     child: ListView.builder(
  //       itemBuilder: (context, index) => NewsItem(article: article[index]),
  //       itemCount: article.length,
  //     ),
  //   );
  // }
}
