import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:news_app/model/model.dart';
import 'package:news_app/model/saved_news.dart';
import 'package:news_app/utils/utils.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailPage extends StatefulWidget {
  final Article article;
  const DetailPage({Key? key, required this.article}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Box<SavedNews> localDB = Hive.box<SavedNews>("savedNews_list");
  bool _isSaved = false;
  var _indexSaved = 0;

  @override
  Widget build(BuildContext context) {
    for(var i = 0; i < localDB.length; i++){
      if(localDB.getAt(i)?.title == widget.article.title){
        _isSaved = true;
        _indexSaved = i;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Image.network(widget.article.urlToImage,
                height: 350, fit: BoxFit.cover),
            ListView(
              children: [
                const SizedBox(height: 330),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        Text(
                          widget.article.title,
                          style: tittleArticle.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.account_circle),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.article.author,
                                  style:
                                      authorDataArticle.copyWith(fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.calendar_today_outlined),
                                Text(
                                  time(DateTime.parse(
                                      widget.article.publishedAt)),
                                  style:
                                      authorDataArticle.copyWith(fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(widget.article.content,
                            style: detailArticle.copyWith(fontSize: 20))
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0,10),
                          blurRadius: 50
                        )
                      ]
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0,10),
                              blurRadius: 50
                          )
                        ]
                    ),
                    child: IconButton(
                      icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border_outlined, color: Colors.blue,),
                      onPressed: () {
                        setState(() {
                          if(!_isSaved){
                            localDB.add(SavedNews(
                                author: widget.article.author,
                                title: widget.article.title,
                                description: widget.article.description,
                                url: widget.article.url,
                                urlToImage: widget.article.urlToImage,
                                publishedAt: widget.article.publishedAt,
                                content: widget.article.content));
                            _isSaved = true;
                          }else{
                            localDB.getAt(_indexSaved)?.delete();
                            _isSaved = false;
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String time(DateTime parse) {
    return timeago.format(parse, allowFromNow: true, locale: 'id');
  }
}
