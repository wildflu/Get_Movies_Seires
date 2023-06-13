

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:moviesapp/view/show_serie_deteils.dart';
import 'package:url_launcher/url_launcher.dart';


class ShowDeteils extends StatefulWidget {
  const ShowDeteils({super.key, required this.idmovie, required this.movieornot});

  final int idmovie;
  final String movieornot;

  @override
  State<ShowDeteils> createState() => _ShowDeteilsState();
}

class _ShowDeteilsState extends State<ShowDeteils> {

  static final apikey =  dotenv.env['API_KEY'];

  Map ?mapdata;
  Future<void> getallmovies(String urllink, String mos) async {
    final url = Uri.parse('https://api.themoviedb.org/3/$mos/$urllink?api_key=$apikey');
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
    getallmovies('${widget.idmovie}', widget.movieornot);
    print(widget.idmovie);
  }

  Future<void> _launchUrl() async {
  if (!await launchUrl(Uri.parse('${mapdata?['homepage']}'))) {
    throw Exception('Could not launch');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mapdata != null
      ? Container(
        child:  widget.movieornot == 'movie'
        ? ListView(
          children: [
            Container(
              height: 350,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TheRow(title: "Name",thevalue: mapdata?['original_title']),
                          TheRow(title: "Release Date",thevalue: mapdata?['release_date'],),
                          TheRow(title: "popularity",thevalue: "${mapdata?['popularity']}"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network('http://image.tmdb.org/t/p/w780/${mapdata?['poster_path']}', fit: BoxFit.cover,)
                      ),
                    ),
                  )
                ],
              ),
            ),

            Container(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text("Genres", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20),),
                  ),
                  Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:mapdata?['genres'].length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white10),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text(mapdata?['genres'][index]['name'])),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text("OverView", style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500),)
                  ),
                  Text(mapdata?['overview'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic, height: 1.5),textAlign: TextAlign.center,),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: Colors.white10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                onPressed: ()async{
                  await _launchUrl();
              }, child: const Text("Get The Movie Link")),
            )
          ],
        )
        :Container(
          child: ListView(
            children:
              [
                Image.network('http://image.tmdb.org/t/p/w780/${mapdata?['poster_path']}', fit: BoxFit.cover,),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(child: Text("${mapdata?['name']}", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
                ),
                Center(child: Text("${mapdata?['overview']}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300), textAlign: TextAlign.center,)),
                
                const SizedBox(height: 50,),
                ListTile(
                  title: const Text("Number Of Seasons"),
                  trailing: Text("${mapdata?['number_of_seasons']} Ses"),
                ),
                ListTile(
                  title: const Text("Number Of Episode"),
                  trailing: Text("${mapdata?['number_of_episodes']} Ep"),
                ),
                ListTile(
                  title: const Text("Popularity"),
                  trailing: Text("${mapdata?['popularity']} So"),
                ),
                const SizedBox(height: 50,),

                Container(
                  margin: const EdgeInsets.all(20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mapdata?['seasons'].length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: ()=>Get.to(()=> DetailsOfThisSerei(idse: widget.idmovie,idep: mapdata?['seasons'][index]['season_number'],)),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white)
                          ),
                          child: Column(
                            children: [
                              Image.network('http://image.tmdb.org/t/p/w780/${mapdata?['seasons'][index]['poster_path']}'),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(child: Text("${mapdata?['seasons'][index]['name']}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),),
                              ),
                              ListTile(
                                title: const Text("Date Of Air"),
                                trailing: Text("${mapdata?['seasons'][index]['air_date']} "),
                              ),
                              ListTile(
                                title: const Text("Nomber Of Episode"),
                                trailing: Text("${mapdata?['seasons'][index]['episode_count']} Ep"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
            ],
          ),
        )
      )
      :const Center(child: CircularProgressIndicator(),)
    );
  }
}

class TheRow extends StatelessWidget {
  const TheRow({super.key, required this.title, required this.thevalue});
  final String title;
  final String thevalue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(title, style: const TextStyle(fontSize: 18, fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),),
        ),
        Text(thevalue, style: const TextStyle(fontSize: 13, fontStyle: FontStyle.normal,fontWeight: FontWeight.w300, color: Colors.grey),),
        const Divider(
          color: Colors.white,
        )
      ],
    );
  }
}