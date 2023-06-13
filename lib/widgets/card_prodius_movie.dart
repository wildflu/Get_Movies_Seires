


import 'dart:ffi';

import 'package:flutter/material.dart';

class CardProdiusMovis extends StatelessWidget {
  const CardProdiusMovis({super.key, required this.imgurl, required this.popularity, required this.time});

  final String imgurl;
  final double popularity;
  // final String des;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.white)
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network('http://image.tmdb.org/t/p/w780/$imgurl', fit: BoxFit.cover,)),
          ),
          // Positioned(
          //   right: 5,
          //   left: 5,
          //   // width: double.infinity,
          //   bottom: 5,
          //   child: Container(
          //       padding: const EdgeInsets.all(10),
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(5),
          //         color: Colors.white54,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           Text("popularity", style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500, color: Colors.black),),
          //           Text("$popularity", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,)),
          //           // Text(time, style: const TextStyle(color: Colors.white),)
          //         ],
          //       ),
          //     ),
          // )
        ],
      ),
    );
  }
}