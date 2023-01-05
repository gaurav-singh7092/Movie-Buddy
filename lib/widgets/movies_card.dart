import 'package:flutter/material.dart';
import 'package:movie_buddy/constants.dart';
import 'dart:math' as math;
import 'package:movie_buddy/widgets/details.dart';
import 'package:tmdb_api/tmdb_api.dart';
class MovieCard extends StatefulWidget {
  final List result;
  const MovieCard({Key? key,required this.result}) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  List movieDetail = [];
  final String apikey = 'd9f280a0dab035efe348ed6d04f64340';
  final String readaccesstoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkOWYyODBhMGRhYjAzNWVmZTM0OGVkNmQwNGY2NDM0MCIsInN1YiI6IjYzNmE4NDQ3NjkzZTIwMDA3ZjdmMjQyOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JGRyaOf-rJ5N7rJnqdzUOO55S-xx1Cr427qdLRlSovE';
  int initialPage = 1;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: initialPage,
    );
  }
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
  loadDetails(int movieId) async {
    TMDB tmdbwithcustomlogs = TMDB(ApiKeys(apikey,readaccesstoken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    Map movieResult = await tmdbwithcustomlogs.v3.movies.getDetails(movieId);
    setState(() {
      movieDetail = movieResult['budget'];
    });

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 15),
      child: AspectRatio(
        aspectRatio: 0.75,
        child: PageView.builder(
          onPageChanged: (value) {
            setState(() {
              initialPage = value;
            });
          },
          physics: const ClampingScrollPhysics(),
          controller: _pageController,
          itemCount: widget.result.length,
          itemBuilder: (context,index) {
            return AnimatedBuilder(
              animation: _pageController,
              builder: (context,child) {
                double? value = 0.0;
                if(_pageController.position.haveDimensions) {
                  value = index - _pageController.page!;
                  value = (value*.038).clamp(-1, 1);
                }
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 350),
                  opacity: initialPage == index ? 1 : 0.4,
                  child: Transform.rotate(
                    angle: math.pi*value,
                      child: buildPadding(index)),
                );
              },
            );
          }
        ),
      ),
    );
  }

  Padding buildPadding(int index) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreeen(
                          name: widget.result[index]['title'],
                          bannerurl: 'https://image.tmdb.org/t/p/w500${widget.result[index]['backdrop_path']}',
                          info: widget.result[index]['overview'],
                          vote: widget.result[index]['vote_average'].toString(),
                          release_On: widget.result[index]['release_date'],
                          vote_count: widget.result[index]['vote_count'].toString(),
                          popularity: widget.result[index]['popularity'].toString(),
                          id: widget.result[index]['id'],
                          lang: widget.result[index]['original_language'],
                          adult: widget.result[index]['adult'],
                        )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [kDefaultShadow],
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${widget.result[index]['poster_path']}'
                            ),
                            fit: BoxFit.fill,
                          )
                        ),
                    ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding/2),
                    child: widget.result[index]['title'] != null ? Text(widget.result[index]['title'],
                    style: const TextStyle(
                      fontFamily: 'muli',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),) : Text(widget.result[index]['original_name'],style: const TextStyle(
                      fontFamily: 'muli',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star,color: Colors.yellow,size: 30,),
                      const SizedBox(width: kDefaultPadding/2,),
                      Text(widget.result[index]['vote_average'].toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'muli'
                      ),)
                    ],
                  )
                ],
              ),
            );
  }
}