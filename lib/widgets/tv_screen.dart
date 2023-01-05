import 'package:flutter/material.dart';
import 'package:movie_buddy/widgets/tv_card.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../constants.dart';
import 'movies_card.dart';
class TVScreen extends StatefulWidget {
  const TVScreen({Key? key}) : super(key: key);

  @override
  State<TVScreen> createState() => _TVScreenState();
}

class _TVScreenState extends State<TVScreen> {
  int selected = 0;
  List<String> category = ['Trending Shows', 'Streaming Now', 'Top Rated Shows'];
  List trendingMovie = [];
  List topRatedMovie = [];
  List theatre = [];
  final String apikey = 'd9f280a0dab035efe348ed6d04f64340';
  final String readaccesstoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkOWYyODBhMGRhYjAzNWVmZTM0OGVkNmQwNGY2NDM0MCIsInN1YiI6IjYzNmE4NDQ3NjkzZTIwMDA3ZjdmMjQyOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JGRyaOf-rJ5N7rJnqdzUOO55S-xx1Cr427qdLRlSovE';
  @override
  void initState() {
    loadMovie();
    super.initState();
  }
  loadMovie() async {
    TMDB tmdbwithcustomlogs = TMDB(ApiKeys(apikey,readaccesstoken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    Map trendingresult = await tmdbwithcustomlogs.v3.tv.getPopular();
    Map topRatedResult = await tmdbwithcustomlogs.v3.tv.getTopRated();
    Map streamingResult = await tmdbwithcustomlogs.v3.tv.getOnTheAir();
    setState(() {
      trendingMovie = trendingresult['results'];
      topRatedMovie = topRatedResult['results'];
      theatre = streamingResult['results'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: category.length,
              itemBuilder: (context,index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = index;
                        });
                      },
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text(category[index],
                            style: Theme.of(context).textTheme.headline5?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: index == selected ? kTextColor : Colors.black.withOpacity(0.4),
                            ),
                          ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: kDefaultPadding/2),
                              height: 6,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index == selected ? kSecondaryColor : Colors.transparent,
                              ),
                            )
                          ]
                      ),
                    ),
                  ),
            ),
          ),
          if(selected == 0)
            TVCard(result: trendingMovie)
          else if(selected == 1)
            TVCard(result: theatre)
          else if(selected==2)
              TVCard(result: topRatedMovie)
        ],
      ),
    );
  }
}
