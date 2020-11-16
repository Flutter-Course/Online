import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/models/tmdb_handler.dart';
import 'package:roovies/providers/movies_provider.dart';
import 'package:roovies/widgets/movies_by_genre.dart';
import 'package:roovies/widgets/now_playing.dart';
import 'package:roovies/widgets/trending_movies.dart';
import 'package:roovies/widgets/trending_persons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool firstRun, successful;
  @override
  void initState() {
    super.initState();
    firstRun = true;
    successful = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstRun) {
      //await Provider.of<MoviesProvider>(context, listen: false).fetchNowPlaying();
      bool done = await context.read<MoviesProvider>().fetchNowPlaying();
      setState(() {
        firstRun = false;
        successful = done;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TMDBHandler.instance.getNowPlaying();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          onPressed: () {},
        ),
        title: Text('Roovies'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: (firstRun)
          ? Center(child: CircularProgressIndicator())
          : (successful)
              ? ListView(
                  children: [
                    NowPlaying(),
                    MoviesByGenre(),
                    TrendingPersons(),
                    TrendingMovies(),
                  ],
                )
              : Center(
                  child: Text(
                    'Error has occured',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
    );
  }
}
