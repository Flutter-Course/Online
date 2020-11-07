import 'package:flutter/material.dart';
import 'package:roovies/helpers/dummy_data.dart';

class PersonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemExtent: 110,
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
                      shape: BoxShape.circle,
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
                  child: Text(
                    DummyData.nowPlaying[index]['movie_name'],
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  flex: 3,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
