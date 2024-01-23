import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fooderapp/pages/add_food_screen.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.black,
        title: const Text(
          'Foodfeeds',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 10, // This should be the length of your data list
        itemBuilder: (context, index) {
          return const NewsFeedItem(); // Custom widget for newsfeed item
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your logic to navigate to the new post creation screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddFoodScreen(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NewsFeedItem extends StatelessWidget {
  const NewsFeedItem({super.key});

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
            title: const Text(
              'User Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            subtitle: const Text(
              'Time ago',
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Post content goes here...',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/jcoleFHD.jpg',
              fit: BoxFit.cover,
              // height: 300.0, // Adjust the height as needed
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {},
                icon:
                    // post.isLiked?
                    const Icon(FluentIcons.heart_20_filled),
                // : const Icon(FluentIcons.heart_20_regular),
                label: const Text('Like'),
              ),
              ElevatedButton.icon(
                onPressed: () {/* Comment action */},
                icon: const Icon(Icons.comment),
                label: const Text('Comment'),
              ),
              ElevatedButton.icon(
                onPressed: () {/* Share action */},
                icon: const Icon(Icons.share),
                label: const Text('Share'),
              ),
            ],
          )
        ],
      ),
    );
  }
}


// class NewsFeedItem extends StatelessWidget {
//   const NewsFeedItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           const ListTile(
//             leading: CircleAvatar(
//                 // Profile picture
//                 ),
//             title: Text('User Name'), // User name
//             subtitle: Text('Time ago'), // Post time
//           ),
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text('Post content goes here...'), // Post content
//           ),
//           Image.asset(
//             'assets/images/jcoleFHD.jpg', // Post image
//             fit: BoxFit.cover,
//           ),
//           ButtonBar(
//             children: <Widget>[
//               TextButton(
//                 child: const Icon(Icons.thumb_up),
//                 onPressed: () {/* Like action */},
//               ),
//               TextButton(
//                 child: const Icon(Icons.comment),
//                 onPressed: () {/* Comment action */},
//               ),
//               TextButton(
//                 child: const Icon(Icons.share),
//                 onPressed: () {/* Share action */},
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
