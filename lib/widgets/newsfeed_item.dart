import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fooderapp/models/food_model.dart';
import 'package:fooderapp/pages/detail_dish_screen.dart';
import 'package:fooderapp/widgets/comment_widget.dart';
class NewsFeedItem extends StatefulWidget {
  final Food food;

  const NewsFeedItem({Key? key, required this.food}) : super(key: key);

  @override
  _NewsFeedItemState createState() => _NewsFeedItemState();
}



class _NewsFeedItemState extends State<NewsFeedItem> {
  bool isLiked = false;
  int likeCount = 0;
  int commentCount = 0;

  @override
  void initState() {
    super.initState();
    likeCount = widget.food.likersCount == null
                  ? 0
                  : widget.food.likersCount!;
    commentCount = widget.food.comments == null ? 0 : widget.food.comments!.length;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900], // Dark background color
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: const CircleAvatar(
              // Placeholder image or actual image from data
              backgroundImage: AssetImage('assets/images/jcoleFHD.jpg'),
            ),
            title:  Text(
              widget.food.author!.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            subtitle:  Text(
              widget.food.createdAt!.toLocal().toString() // Use the food parameter
                  .split(' ')[0],
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            trailing: PopupMenuButton(
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'hide',
                  child: Text('Hide'),
                ),
                const PopupMenuItem(
                  value: 'report',
                  child: Text('Report'),
                ),
                // Add more items as needed
              ],
              onSelected: (value) {
                // Handle menu item selection
                if (value == 'hide') {
                  // Handle hide action
                } else if (value == 'report') {
                  // Handle report action
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              widget.food.body, // Use the food parameter
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: GestureDetector(
              onTap: () {
                // Handle the onPressed event here
                DetailsDishScreen(widget.food.id!);
                // You can navigate to a new screen or perform any other action.
              },
              child: Image.network(
                widget.food.images![0],
                fit: BoxFit.cover,
                // height: 300.0, // Adjust the height as needed
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    if (isLiked) {
                      // Unlike
                      likeCount--;
                    
                    } else {
                      // Like
                      likeCount++;
                      
                    }
                    isLiked = !isLiked;
                  });
                  widget.food.likersCount = likeCount;
                },
                icon: isLiked
                    ? const Icon(FluentIcons.heart_20_filled)
                    : const Icon(FluentIcons.heart_20_regular),
                label: Text('$likeCount '),
              ),
          ElevatedButton.icon(
            onPressed: () {
              // Show the CommentWidget when the button is pressed
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return CommentWidget(widget.food.id!, widget.food.comments == null ? [] : widget.food.comments!);
                },
              );
            },
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.comment),
              ],
            ),
            label: Text(''), // You can add a label if needed
          ),
            ],
          )
        ],
      ),
    );
  }
}
