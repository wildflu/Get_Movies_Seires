

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class InputSearch extends StatelessWidget {
  const InputSearch({super.key, required this.onchange});
  final VoidCallback onchange;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 50),
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white10
      ),
      child: TextFormField(
        onChanged: (value) => onchange(),
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.search),
          ),
          hintText: "Search For Movie",
          suffixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(onPressed: (){}, icon: const Icon(Icons.mic)),
          ),
          fillColor: Colors.amber,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}