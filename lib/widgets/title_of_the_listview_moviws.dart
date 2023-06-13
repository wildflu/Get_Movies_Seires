


import 'package:flutter/material.dart';

class TypeCardMovie extends StatelessWidget {
  const TypeCardMovie({
    super.key, required this.type, required this.text,
  });
  final String type;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 40, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(type, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal),),
          TextButton(onPressed: (){}, child: Text(text, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w200, fontStyle: FontStyle.italic, color: Colors.white)))
        ],
      ),
    );
  }
}
