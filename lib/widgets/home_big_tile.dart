import 'package:flutter/material.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:fooderapp/utils/helpers.dart';
import 'package:fooderapp/pages/details_dish_page.dart';

class HomeBigTile extends StatelessWidget {
  final String title;
  final String imagePath;
  const HomeBigTile({Key? key, required this.title, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Navigator.of(context).pushNamed(albumDetailsPage),
      onTap: () {
        // Đoạn mã sau sẽ chuyển đến trang DetailsDishPage
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DetailsDishPage()),
        );
      },
      child: SizedBox(
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset(imagePath),
            ),
            const VerticalSpacer(height: 10),
            Text(
              title,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[500],
              ),
            )
          ],
        ),
      ),
    );
  }
}
