


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controller/ui_controller/bottom_bar_controller.dart';

import 'package:http/http.dart' as http;

import '../../widgets/list_view_movies.dart';
import '../../widgets/title_of_the_listview_moviws.dart';


class MenuIndex extends StatefulWidget {
  const MenuIndex({super.key});

  @override
  State<MenuIndex> createState() => _MenuIndexState();
}

class _MenuIndexState extends State<MenuIndex> {

  static final apikey =  dotenv.env['API_KEY'];

  List moviesList1 = [];
  List moviesList2 = [];
  List moviesList3 = [];
  List moviesList4 = [];
  List moviesList5 = [];
  List moviesList6 = [];
  List moviesList7 = [];

  List airingtodaysires = [];
  List popularesires = [];
  List topratedseries = [];
  List ontheairseries = [];



  Future<void> getallmovies(String urllink, List x) async {
    final url = Uri.parse(urllink);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      x.add(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete book: ${response.reasonPhrase}');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getallmovies('https://api.themoviedb.org/3/list/1?api_key=$apikey', moviesList1);
    getallmovies('https://api.themoviedb.org/3/list/2?api_key=$apikey', moviesList2);
    getallmovies('https://api.themoviedb.org/3/list/3?api_key=$apikey', moviesList3);
    getallmovies('https://api.themoviedb.org/3/list/4?api_key=$apikey', moviesList4);
    getallmovies('https://api.themoviedb.org/3/list/5?api_key=$apikey', moviesList5);
    getallmovies('https://api.themoviedb.org/3/list/6?api_key=$apikey', moviesList6);
    getallmovies('https://api.themoviedb.org/3/list/7?api_key=$apikey', moviesList7);

    getallmovies('https://api.themoviedb.org/3/tv/airing_today?api_key=$apikey', airingtodaysires);
    getallmovies('https://api.themoviedb.org/3/tv/popular?api_key=$apikey', popularesires);
    getallmovies('https://api.themoviedb.org/3/tv/top_rated?api_key=$apikey', topratedseries);
    getallmovies('https://api.themoviedb.org/3/tv/on_the_air?api_key=$apikey', ontheairseries);



  }




  @override
  Widget build(BuildContext context) {
    BottomBarController btncontroller = Get.find();
    PageController pageController = PageController();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 70,
            right: 70,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (){
                      btncontroller.inmovies();
                      pageController.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
                    },
                    child: const Text("Movies"),
                  ),
                  SmoothPageIndicator(  
                    controller: pageController,
                    count: 2,
                    effect: const WormEffect(
                      dotWidth: 20,
                      spacing: 40,
                      dotHeight: 5
                    ),    
                    onDotClicked: (index){  
                    }  
                  ),
                  GestureDetector(
                    onTap: (){
                      btncontroller.insires();
                      pageController.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
                    },
                    child: const Text("Sires")
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 60,
            bottom: 0,
            child: Container(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  PageMovies(moviesList1: moviesList1, moviesList2: moviesList2, moviesList3: moviesList3, moviesList4: moviesList4, moviesList5: moviesList5, moviesList6: moviesList6, moviesList7: moviesList7),
                  Container(
                    padding: const EdgeInsets.all(0),
                    child: ListView(
                      children: [
                        const TypeCardMovie(type: "Airing Today",text: "series",),
                        ListViewMoviesAndSires(movies: airingtodaysires, thekey: "results", ismovie: false),
                        const TypeCardMovie(type: "Populare",text: "series",),
                        ListViewMoviesAndSires(movies: popularesires, thekey: "results", ismovie: false),
                        const TypeCardMovie(type: "Top Rated",text: "series",),
                        ListViewMoviesAndSires(movies: topratedseries, thekey: "results", ismovie: false),
                        const TypeCardMovie(type: "On The Air",text: "series",),
                        ListViewMoviesAndSires(movies: ontheairseries, thekey: "results", ismovie: false),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PageMovies extends StatelessWidget {
  const PageMovies({
    super.key,
    required this.moviesList1,
    required this.moviesList2,
    required this.moviesList3,
    required this.moviesList4,
    required this.moviesList5,
    required this.moviesList6,
    required this.moviesList7,
  });

  final List moviesList1;
  final List moviesList2;
  final List moviesList3;
  final List moviesList4;
  final List moviesList5;
  final List moviesList6;
  final List moviesList7;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: ListView(
        children: [
          const TypeCardMovie(type: "List 1",text: "Movies !",),
          ListViewMoviesAndSires(movies: moviesList1, thekey: "items", ismovie: true),
          const TypeCardMovie(type: "List 2",text: "Movies !",),
          ListViewMoviesAndSires(movies: moviesList2, thekey: "items", ismovie: true),
          const TypeCardMovie(type: "List 3",text: "Movies !",),
          ListViewMoviesAndSires(movies: moviesList3, thekey: "items", ismovie: true),
          const TypeCardMovie(type: "List 4",text: "Movies !",),
          ListViewMoviesAndSires(movies: moviesList4, thekey: "items", ismovie: true),
          const TypeCardMovie(type: "List 5",text: "Movies !",),
          ListViewMoviesAndSires(movies: moviesList5, thekey: "items", ismovie: true),
          const TypeCardMovie(type: "List 6",text: "Movies !",),
          ListViewMoviesAndSires(movies: moviesList6, thekey: "items", ismovie: true),
          const TypeCardMovie(type: "List 7",text: "Movies !",),
          ListViewMoviesAndSires(movies: moviesList7, thekey: "items", ismovie: true),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                backgroundColor: Colors.white10
              ),
              
              onPressed: (){}, child: const Text("Get More Lists of movies")),
          )
        ],
      ),
    );
  }
}