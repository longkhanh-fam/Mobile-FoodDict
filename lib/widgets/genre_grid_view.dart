import 'package:flutter/material.dart';
class GenreGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        GenreContainer("Pop Music", Colors.deepOrange),
        GenreContainer("Rock", Colors.deepPurple),
        GenreContainer("Hip Hop", Colors.blueAccent),
        GenreContainer("Jazz", Colors.amber),
        GenreContainer("House", Colors.green),
        GenreContainer("Reggae", Colors.red),
      ],
    );
  }
}

class GenreContainer extends StatelessWidget {
  final String genre;
  final Color color;

  const GenreContainer(this.genre, this.color);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: Text(
          genre,
          style: TextStyle(
            color: Colors.white,
            fontSize: 21.0,
          ),
        ),
        color: color,
      ),
    );
  }
}