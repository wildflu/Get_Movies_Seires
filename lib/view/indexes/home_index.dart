


import 'package:flutter/material.dart';

import '../../widgets/card_prodius_movie.dart';
import '../../widgets/input_search.dart';
import '../../widgets/list_view_movies.dart';
import '../../widgets/title_of_the_listview_moviws.dart';
import '../home_page.dart';

class HomeIndex extends StatelessWidget {
  const HomeIndex({
    super.key,
    required this.popularemovies,
    required this.upcommingmovies,
    required this.topratedmovies,
    required this.moviesList,
  });

  final List popularemovies;
  final List upcommingmovies;
  final List topratedmovies;
  final List moviesList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: ListView(
        children: [
          const SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Hallo Name" , style: TextStyle(fontSize: 23, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("Descover You Favorit Movies Here ?1", style: TextStyle(fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w300,color: Colors.grey)),
                  ],
                ),
                const CircleAvatar(radius: 30, backgroundColor: Colors.white,),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.only(top: 30),
            child: InputSearch(
              onchange: (){},
            ),
          ),
          const TypeCardMovie(
            type: "Populare",
            text: "Movies !",
          ),
          ListViewMoviesAndSires(movies: popularemovies, thekey: "results", ismovie: true),
          const TypeCardMovie(
            type: "UpComing",
            text: "Movies !",
          ),
          ListViewMoviesAndSires(movies: upcommingmovies, thekey: "results", ismovie: true),
          const TypeCardMovie(
            type: "Top Rated",
            text: "Movies !",
          ),
          ListViewMoviesAndSires(movies: topratedmovies, thekey: "results", ismovie: true),
          const TypeCardMovie(
            type: "All CatiGuris",
            text: "Movies !",
          ),
          Container(
            child:  moviesList.isNotEmpty
            ? GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: moviesList[0]['items'].length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
                crossAxisSpacing: 5
              ),
              itemBuilder: (context, index) {
                return CardProdiusMovis(
                  imgurl: moviesList[0]['items'][index]['poster_path'], 
                  popularity: moviesList[0]['items'][index]['popularity'],
                  // des: "this will be the description of the movie ..",
                  time: moviesList[0]['items'][index]['release_date']
                );
              },
            )
            : const Center(
              child: CircularProgressIndicator(),
            )
          ),
        ],
      ),
    );
  }
}