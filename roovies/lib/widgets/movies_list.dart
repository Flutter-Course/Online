import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:roovies/helpers/dummy_data.dart';

class MoviesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4 - 48,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemExtent: 140,
        scrollDirection: Axis.horizontal,
        itemCount: DummyData.nowPlaying.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          DummyData.nowPlaying[index]['poster_url'],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  flex: 7,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      DummyData.nowPlaying[index]['movie_name'],
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: FittedBox(
                    child: Row(
                      children: [
                        FittedBox(
                          child: Text(
                            '8.0',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        FittedBox(
                          child: RatingBar(
                            initialRating: 4,
                            allowHalfRating: true,
                            ignoreGestures: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  flex: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
