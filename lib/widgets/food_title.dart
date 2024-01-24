import 'package:flutter/material.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:fooderapp/pages/detail_dish_screen.dart';

class FoodTile extends StatelessWidget {
  final int id;
  final String title;
  final List<String> images;
  final String body;
  const FoodTile(this.id, this.title, this.images, this.body, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => DetailsDishScreen(id)),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Image.network(
                images[0],
                height: 180.0,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.network(
                  defaultProfileImageUrl,
                  height: 180.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black87, Colors.transparent],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '120 Likes',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.bookmark),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return InkWell(
  //     onTap: () => Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (_) => DetailsDishScreen(id))),
  //     child: Padding(
  //       padding: const EdgeInsets.all(12.0),
  //       child: Row(children: [
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(8.0),
  //           child: Image.network(
  //             images[0],
  //             height: 100.0,
  //             width: 100.0,
  //             fit: BoxFit.cover,
  //             errorBuilder: (_, __, ___) => Image.network(
  //               defaultProfileImageUrl, // Replace with the path to your default image asset
  //               height: 100.0,
  //               width: 100.0,
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //         const VerticalDivider(width: 20),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 title,
  //                 style: const TextStyle(fontSize: 20),
  //               ),
  //               Text(
  //                 body,
  //                 maxLines: 3,
  //                 overflow: TextOverflow.ellipsis,
  //               )
  //             ],
  //           ),
  //         )
  //       ]),
  //     ),
  //   );
  // }
}
