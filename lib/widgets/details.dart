import 'package:flutter/material.dart';
import 'package:movie_buddy/constants.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'header.dart';
import 'name_details.dart';
class DetailScreeen extends StatefulWidget {
  final id,name, info, bannerurl, posterurl, vote, release_On,vote_count,popularity,lang,adult;
  const DetailScreeen({Key? key,this.id, this.name, this.info, this.bannerurl, this.posterurl, this.vote, this.release_On,this.vote_count,this.popularity,this.lang,this.adult}) : super(key: key);

  @override
  State<DetailScreeen> createState() => _DetailScreeenState();
}

class _DetailScreeenState extends State<DetailScreeen> {
  List similarMovie = [];
  final String apikey = 'd9f280a0dab035efe348ed6d04f64340';
  final String readaccesstoken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkOWYyODBhMGRhYjAzNWVmZTM0OGVkNmQwNGY2NDM0MCIsInN1YiI6IjYzNmE4NDQ3NjkzZTIwMDA3ZjdmMjQyOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JGRyaOf-rJ5N7rJnqdzUOO55S-xx1Cr427qdLRlSovE';
  void initState() {
    loadSimilar(widget.id);
    super.initState();
  }
  loadSimilar(int movieId) async {
    TMDB tmdbwithcustomlogs = TMDB(ApiKeys(apikey,readaccesstoken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    Map similarResult = await tmdbwithcustomlogs.v3.movies.getSimilar(movieId);
    setState(() {
      similarMovie = similarResult['results'];
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
     return Scaffold(
       extendBodyBehindAppBar: true,
       appBar: AppBar(
         title: Text('${widget.name}',),
         backgroundColor: Colors.transparent,
         elevation: 0.1,
       ),
       body: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
             children: [
           Header(size: size, bannerurl: widget.bannerurl, vote: widget.vote, vote_count: widget.vote_count, popularity: widget.popularity, lang: widget.lang),
           nameDetails(name: widget.name, release_On: widget.release_On, adult: widget.adult),
           const Padding(
               padding: EdgeInsets.symmetric(
                 vertical: kDefaultPadding/2,
                 horizontal: kDefaultPadding,
               ),
             child: Text('Plot Summary',
             style: TextStyle(
               fontWeight: FontWeight.bold,
               fontFamily: 'muli',
               fontSize: 30,
             ),),
           ),
               Padding(padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
               child: Text(
                 widget.info,
                 style: const TextStyle(
                   color: Color(0xFF737599),
                   fontSize: 20,
                   fontFamily: 'muli',
                 ),
               ),
               ),
           Padding(
             padding: const EdgeInsets.all(kDefaultPadding),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const Text('Similar Movies',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontFamily: 'muli',
                       fontSize: 30,
                     )),
                 const SizedBox(height: 15,),
                 SizedBox(
                   height: 160,
                   child: ListView.builder(
                     scrollDirection: Axis.horizontal,
                     itemCount: similarMovie.length,
                     itemBuilder: (context,index) => Container(
                       margin: const EdgeInsets.only(right: kDefaultPadding),
                       width: 100,
                       child: Column(
                         children: [
                           Expanded(
                             child: GestureDetector(
                               onTap: () {
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreeen(
                                   name: similarMovie[index]['title'],
                                   bannerurl: 'https://image.tmdb.org/t/p/w500${similarMovie[index]['backdrop_path']}',
                                   info: similarMovie[index]['overview'],
                                   vote: similarMovie[index]['vote_average'].toString(),
                                   release_On: similarMovie[index]['release_date'],
                                   vote_count: similarMovie[index]['vote_count'].toString(),
                                   popularity: similarMovie[index]['popularity'].toString(),
                                   id: similarMovie[index]['id'],
                                   lang: similarMovie[index]['original_language'],
                                   adult: similarMovie[index]['adult'],
                                 )));
                               },
                               child: Container(
                                 height: 80,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     boxShadow: const [kDefaultShadow],
                                   image: DecorationImage(
                                     image: NetworkImage('https://image.tmdb.org/t/p/w500${similarMovie[index]['poster_path']}',),
                                     fit: BoxFit.cover,
                                   )
                                 ),
                               ),
                             ),
                           ),
                           const SizedBox(height: kDefaultPadding/2,),
                           Text(
                             similarMovie[index]['title'],
                             overflow: TextOverflow.ellipsis,
                             textAlign: TextAlign.center,
                             style: const TextStyle(
                               fontWeight: FontWeight.bold,
                               fontFamily: 'muli',
                               fontSize: 15,
                             ),
                           )
                         ],
                       ),
                     ),
                   ),
                 )
               ],
             ),
           )
         ]
         ),
       ),
     );
  }
}

