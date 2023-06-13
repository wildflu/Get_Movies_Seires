

import 'package:flutter/material.dart';

import '../../widgets/input_search.dart';


class SearchIndex extends StatelessWidget {
  const SearchIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: InputSearch(
              onchange: (){},
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 3,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
                crossAxisSpacing: 5
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}