import 'package:flutter/material.dart';
import 'package:searchrepo/api.dart';

void main() {
  runApp(MaterialApp(
    home: SearchApp(),
  ));
}

class SearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search App"), actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            })
      ]),
    );
  }
}

class DataSearch extends SearchDelegate<Repository> {
  final GithubApi githubApi = new GithubApi();

  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Repository>>(
      future: githubApi.searchRepositories(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final repository = snapshot.data[index];
              return ListTile(
                  leading: repository.avatarUrl != null ?
                  Image.network(repository.avatarUrl) :
                Icon(Icons.location_city),
                title: Text(repository.fullName),
                subtitle: repository.description != null ?
                  Text(repository.description) :
                  null,
                onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(repository)),);
                },
              );
            },
            itemCount: snapshot.data.length,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }
}

class DetailsPage extends StatelessWidget{
  final Repository repository;
  DetailsPage( this.repository) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text(repository.fullName),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
                  repository.avatarUrl != null ?
              Image.network(repository.avatarUrl) :
              Icon(Icons.location_city),
              Text(repository.fullName),
              repository.description != null ?
              Text(repository.description) :  null,
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go back!'),
              ),


            ],
          )
      ),
    );
  }

}