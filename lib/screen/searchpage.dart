import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/model.dart';
import 'package:news_app/screen/newspage.dart';
import 'package:news_app/service/service.dart';
import 'package:news_app/widget/news_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  bool _isSearching = false;
  late String _querySearch = "";

  @override
  Widget build(BuildContext context) {
    var news = News();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: !_isSearching
            ? Text(
          'Search News',
          style: GoogleFonts.openSans(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        )
            : TextField(
          style: GoogleFonts.openSans(
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
          controller: _searchController,
          decoration: InputDecoration(
            icon: Icon(Icons.search, color: Colors.blue,),
            hintText: "Search News Here",
            hintStyle: GoogleFonts.openSans(
                fontSize: 12,
                color: Colors.black45,
                fontWeight: FontWeight.w600
            ),
          ),
          onEditingComplete: (){
            setState(() {
              _querySearch = _searchController.text;
            });
          },
        ),
        actions: [
          _isSearching
              ? IconButton(
            icon: Icon(Icons.cancel, color: Colors.grey,),
            onPressed: (){
              setState(() {
                this._isSearching = !this._isSearching;
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.search, color: Colors.blue,),
            onPressed: (){
              setState(() {
                this._isSearching = !this._isSearching;
                _querySearch = "";
              });
            },
          )
        ],
      ),

      body: _querySearch != ""
          ? FutureBuilder(
              future: news.getNewsSearch(_querySearch),
              builder: (context, snapshot) => snapshot.data != null
                ? _listNewsSearch(snapshot.data as List<Article>)
                : const Center(child: CircularProgressIndicator()),
          )
          : Container(),
    );
  }

  Widget _listNewsSearch(List<Article> article) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListView.builder(
        itemBuilder: (context, index) => NewsItem(article: article[index]),
        itemCount: article.length,
      ),
    );
  }
}
