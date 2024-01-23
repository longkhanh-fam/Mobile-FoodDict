import 'package:flutter/material.dart';
import 'package:fooderapp/config/constants.dart';

class FoodTile extends StatelessWidget {
  final int id;
  final String title;
  final List<String> images;
  final String body;
  const FoodTile(this.id, this.title, this.images, this.body, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (_) => DetailsDishScreen(id))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              images[0],
              height: 100.0,
              width: 100.0,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.network(
                defaultProfileImageUrl, // Replace with the path to your default image asset
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const VerticalDivider(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  body,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
