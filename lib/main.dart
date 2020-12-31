import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: SearchApp(),
  ));
}

class SearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search App"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search)
              , onPressed: (){
                showSearch(context: context, delegate: DataSearch());
          }
              )
        ]
      ),
    );
  }
}

Future<http.Response> fetchAlbum() {
  return http.get('https://jsonplaceholder.typicode.com/albums/1'); // need the link to the repos
}

class Repository {
  final int repoId;
  final String title;

  Repository(this.repoId, this.title);

  factory Repository.fromJson(Map<String, dynamic> json){
    return Repository(
        repoId: json['repoId'],
        title: json['title'],
    );
  }

}

class DataSearch extends  SearchDelegate<String>{
  @override
  final city = [
    "Oran",
    "Tiaret",
    "Alger",
    "Adrar",
    "Blida",
    "Bejaia",
  ];
  final recent = [
    "Alger",
    "Bejaia",
  ];
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    //actions for app bar ( button X)
    return[
      IconButton(icon: Icon(Icons.clear),
          onPressed: () {
        query="";
          } )
    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    //leading icon on the left of the app bar ( the get back button )
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context,null); //why
        }
    );

  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // Show result based on the selection
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // shows suggestions when someone searches for something
    final suggestiontList = query.isEmpty
        ? recent
        : city.where((p) => p.startsWith(query )).toList();
    return ListView.builder(itemBuilder: (context,index)=> ListTile(leading: Icon(Icons.location_city),
      title: Text(suggestiontList[index]),
    ),
    itemCount: suggestiontList.length,);

  }


}
