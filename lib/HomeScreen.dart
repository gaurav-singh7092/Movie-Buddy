import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_buddy/constants.dart';
import 'package:movie_buddy/widgets/movie_screen.dart';
import 'package:movie_buddy/widgets/tv_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<String> listbar = ['Movies', 'TV'];
  List<IconData> listIcon = [Icons.movie_outlined, Icons.tv_rounded];
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SizedBox(
            height: 80,
            width: 80,
            child: Image.asset('assets/images/icon.jpg'),
          ),
            Text(
              'Movie-Buddy',
              style: Theme.of(context).textTheme.headline1?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            )
          ]
        )
      ),
      body: currentIndex == 0 ? MovieScreen() : TVScreen(),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * 0.05),
        padding: const EdgeInsets.symmetric(horizontal: 70),
        height: displayWidth * .155,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 30,
                  offset: const Offset(0, 10)
              )
            ],
            borderRadius: BorderRadius.circular(50)
        ),
        child: ListView.builder(
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * 0.02),
          itemBuilder: (context, index) =>
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                    HapticFeedback.lightImpact();
                  });
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: index == currentIndex
                          ? displayWidth * 0.32
                          : displayWidth * 0.18,
                      alignment: Alignment.center,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        height: index == currentIndex ? displayWidth * .12 : 0,
                        width: index == currentIndex ? displayWidth * .32 : 0,
                        decoration: BoxDecoration(
                          color: index == currentIndex ? Colors.blue
                              .withOpacity(0.2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: index == currentIndex
                          ? displayWidth * 0.31
                          : displayWidth * .18,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex ? displayWidth *
                                    .13 : 0,
                              ),
                              AnimatedOpacity(
                                opacity: index == currentIndex ? 1 : 0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: currentIndex == 0 ? Text(
                                  index == currentIndex ?
                                  listbar[index] : ' ',
                                  style: const TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ) : Text(
                                  index == currentIndex ?
                                  listbar[index] : ' ',
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                )
                                ,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex ? displayWidth *
                                    0.03 : 20,
                              ),
                              currentIndex == 0 ? Icon(
                                listIcon[index],
                                size: displayWidth * 0.076,
                                color: index == currentIndex
                                    ? Colors.redAccent
                                    : Colors.black26,
                              ) : Icon(
                                listIcon[index],
                                size: displayWidth * 0.076,
                                color: index == currentIndex
                                    ? Colors.blueAccent
                                    : Colors.black26,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
        ),
      ),
    );
  }

}