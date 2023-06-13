

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;


class DetailsOfThisSerei extends StatefulWidget {
  const DetailsOfThisSerei({super.key, required this.idse, required this.idep});
  final int idse;
  final int idep;

  @override
  State<DetailsOfThisSerei> createState() => _DetailsOfThisSereiState();
}

class _DetailsOfThisSereiState extends State<DetailsOfThisSerei> {

  static final apikey =  dotenv.env['API_KEY'];

    Map ?mapdata;
  Future<void> getallmovies(String sei, String epi) async {
    final url = Uri.parse('https://api.themoviedb.org/3/tv/$sei/season/$epi?api_key=apikey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      mapdata = jsonDecode(response.body);
    } else {
      throw Exception('Failed to delete book: ${response.reasonPhrase}');
    }
    print(mapdata);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getallmovies('${widget.idse}', "${widget.idep}");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 5,
            mainAxisSpacing: 15
          ),
          itemCount: mapdata?['episodes'].length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Image.network('http://image.tmdb.org/t/p/w780/${mapdata?['episodes'][index]['still_path']}', fit: BoxFit.cover,)),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Text("${mapdata?['episodes'][index]['name']}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),), 
                  )
                ]
              ),
            );
          },
        ),
      )
    );
  }
}