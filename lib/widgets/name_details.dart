import 'package:flutter/material.dart';

import '../constants.dart';
class nameDetails extends StatelessWidget {
  const nameDetails({
    super.key,
    required this.name,
    required this.release_On,
    required this.adult,
  });

  final String name;
  final String release_On;
  final bool adult;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'muli',
                      fontSize: 30,
                    )
                ),
                const SizedBox(height: kDefaultPadding/2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              fontSize: 20,
                              color: kTextLightColor
                          ),
                          children: [
                            const TextSpan(text: 'Released : '),
                            TextSpan(text: release_On.substring(0,4),style: const TextStyle(fontWeight: FontWeight.bold))
                          ]
                      ),
                    ),
                    const SizedBox(width: kDefaultPadding/2,),
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: 20,
                                color: kTextLightColor
                            ),
                            children: [
                              const TextSpan(text: 'Rated : '),
                              adult ? const TextSpan(text: 'Adult',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent
                              )) : const TextSpan(text: 'PG-13',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green
                              ))
                            ]
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}