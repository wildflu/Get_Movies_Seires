import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:moviesapp/widgets/card_prodius_movie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controller/ui_controller/bottom_bar_controller.dart';
import '../widgets/input_search.dart';

import 'package:badges/badges.dart' as badges;

import 'indexes/home_index.dart';
import 'indexes/menu_index.dart';
import 'indexes/search_index.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if(mounted) {
      setState(() {
      getallmovies();
    getpopularemovies();
    getopratedmovies();
    getupcomingmovies();
    });
    }
    _refreshController.loadComplete();
  }
  static final apikey =  dotenv.env['API_KEY'];


  List moviesList = [];
  Future<void> getallmovies() async {
    // final url = Uri.parse('https://api.themoviedb.org/3/movie/550?api_key=$apikey');
    final url = Uri.parse('https://api.themoviedb.org/3/list/10?api_key=$apikey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      moviesList.add(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete book: ${response.reasonPhrase}');
    }
    // print(moviesList);
    setState(() {});
  }

  List popularemovies = [];
  Future<void> getpopularemovies()async{
    final url = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apikey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      popularemovies.add(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete book: ${response.reasonPhrase}');
    }
    setState(() {});
  }
  List topratedmovies = [];
  Future<void> getopratedmovies()async{
    final url = Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=$apikey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      topratedmovies.add(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete book: ${response.reasonPhrase}');
    }
    setState(() {});
  }


  List upcommingmovies = [];
  Future<void> getupcomingmovies()async{
    final url = Uri.parse('https://api.themoviedb.org/3/movie/upcoming?api_key=$apikey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      upcommingmovies.add(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete book: ${response.reasonPhrase}');
    }
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    getallmovies();
    getpopularemovies();
    getopratedmovies();
    getupcomingmovies();
  }

  @override
  Widget build(BuildContext context) {
    BottomBarController btncontroller = Get.put(BottomBarController());
    List<Widget> indexesPages = [
      HomeIndex(popularemovies: popularemovies, upcommingmovies: upcommingmovies, topratedmovies: topratedmovies, moviesList: moviesList),
      const MenuIndex(),
      const SearchIndex(),
    ];
    return Scaffold(
    appBar: AppBar(
      title: const Text("Movies App", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_none_outlined))
      ],
    ),
    bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(15),
      child: GNav(
        onTabChange: (value) => btncontroller.incrementIndex(value),
        tabActiveBorder: Border.all(color: Colors.white, width: 1), 
        curve: Curves.easeIn, 
        duration: const Duration(milliseconds: 500), 
        gap: 8,
        color: Colors.grey[800],
        iconSize: 24, 
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), 
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.menu_open_outlined,
            text: 'Menu',
          ),
          GButton(
            icon: Icons.search,
            text: 'Search',
          ),
        ]
      ),
    ),
      body: Obx(() => SmartRefresher(
        controller: _refreshController ,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: indexesPages[btncontroller.theIndex.value])),
    );
  }
}


