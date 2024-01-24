import 'package:flutter/material.dart';
import 'package:fooderapp/models/food_list_model.dart';
import 'package:fooderapp/pages/user_screen.dart';
import 'package:fooderapp/utils/helpers.dart';

class UserWidget extends StatelessWidget {
  final Author author;
  const UserWidget(this.author, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => UserScreen(author.id))),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.network(
                  author.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const HorizontalSpacer(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${author.followers} followers - ${author.following} following",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
