


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/show_deteils.dart';

class ListViewMoviesAndSires extends StatelessWidget {
  const ListViewMoviesAndSires({
    super.key,
    required this.movies, required this.thekey, required this.ismovie,
  });

  final List movies;
  final String thekey;
  final bool ismovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      height: 400,
      child: movies.isNotEmpty
        ?ListView.builder(
          shrinkWrap: true,
          itemCount: movies[0][thekey].length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Get.to(() => ShowDeteils(
                  idmovie: movies[0][thekey][index]['id'],
                  movieornot: ismovie? 'movie':'tv',
                ));
              },
              child: Container(
                width: 250,
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.amber
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network('http://image.tmdb.org/t/p/w780/${movies[0][thekey][index]['poster_path']}', fit: BoxFit.cover,)),
              ),
            );
          },
        )
        :Container()
    );
  }
}
