import 'package:flutter/material.dart';
import 'package:roovies/widgets/movies_list.dart';

class MoviesByGenre extends StatefulWidget {
  @override
  _MoviesByGenreState createState() => _MoviesByGenreState();
}

class _MoviesByGenreState extends State<MoviesByGenre>
    with TickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 48,
          bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Action',
              ),
              Tab(
                text: 'Comedy',
              ),
              Tab(
                text: 'Romance',
              ),
              Tab(
                text: 'Horror',
              ),
              Tab(
                text: 'Sci-Fi',
              ),
              Tab(
                text: 'Thriller',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            MoviesList(),
            MoviesList(),
            MoviesList(),
            MoviesList(),
            MoviesList(),
            MoviesList(),
          ],
        ),
      ),
    );
  }
}
