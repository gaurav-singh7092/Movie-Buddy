import 'package:flutter/material.dart';

import '../constants.dart';
class nameDetailsTV extends StatelessWidget {
  const nameDetailsTV({
    super.key,
    required this.name,
    required this.release_On,
    required this.adult,
  });

  final String name;
  final String release_On;
  final String adult;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
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
                            const TextSpan(text: 'Country : '),
                            TextSpan(text: adult,style: const TextStyle(
                              fontWeight: FontWeight.bold,
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