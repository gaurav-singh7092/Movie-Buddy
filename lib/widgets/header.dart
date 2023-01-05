import 'package:flutter/material.dart';
import '../constants.dart';
class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.size,
    required this.bannerurl,
    required this.vote,
    required this.vote_count,
    required this.popularity,
    required this.lang,
  });

  final Size size;
  final String bannerurl;
  final String vote;
  final String vote_count;
  final String popularity;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: size.height*0.4,
            child: Stack(
              children: [
                Container(
                  height: size.height*0.4 - 50,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(bannerurl)
                      )
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    width: size.width*0.9,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            topLeft: Radius.circular(50),
                          ),
                          boxShadow: [BoxShadow(
                            offset: const Offset(0,5),
                            blurRadius: 50,
                            color: const Color(0xFF12153D).withOpacity(0.2),
                          )]
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.star,color: Colors.yellow,size: 35,),
                                const SizedBox(height: kDefaultPadding/4,),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: const TextStyle(color: Colors.black,),
                                      children: [
                                        TextSpan(
                                            text: '${vote}/',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600
                                            )
                                        ),
                                        const TextSpan(text: '10\n',),
                                        TextSpan(text : vote_count,style: const TextStyle(color: kTextLightColor),),
                                        const TextSpan(text : ' votes',style: TextStyle(color: kTextLightColor),)
                                      ]
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.trending_up_outlined,color: Colors.green,size: 35,),
                                const SizedBox(height: kDefaultPadding/4,),
                                RichText(
                                  text: TextSpan(
                                      style: const TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: '$popularity\n',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600
                                            )
                                        ),
                                        const TextSpan(text:'Popularity',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),)
                                      ]
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(lang.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                const SizedBox(height: kDefaultPadding/4,),
                                RichText(
                                  text: const TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: 'Language',
                                            style: TextStyle(
                                                fontSize: 16,
                                            )
                                        )]
                                  ),
                                )
                              ],
                            ),
                          ]
                      ),
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
