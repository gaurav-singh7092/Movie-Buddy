import 'package:flutter/material.dart';
class TopRated extends StatelessWidget {
  final List topRated;
  const TopRated({Key? key,required this.topRated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top Rated Movies',style: TextStyle(fontFamily: 'muli',fontSize: 25),),
          const SizedBox(height: 10,),
          Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topRated.length,
              itemBuilder: (context,index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    width: 140,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500'+ topRated[index]['poster_path']
                                  )
                              )
                          ),
                        ),
                        const SizedBox(height: 4,),
                        Container(
                          child: topRated[index]['title'] != null ? Text(topRated[index]['title']) : Text('Loading'),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
