import 'package:flutter/material.dart';

class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Foodfeeds'),
      ),
      body: ListView.builder(
        itemCount: 10, // This should be the length of your data list
        itemBuilder: (context, index) {
          return NewsFeedItem(); // Custom widget for newsfeed item
        },
      ),
    );
  }
}

class NewsFeedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              // Profile picture
            ),
            title: Text('User Name'), // User name
            subtitle: Text('Time ago'), // Post time
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Post content goes here...'), // Post content
          ),
          Image.asset(
            'assets/images/jcoleFHD.jpg', // Post image
            fit: BoxFit.cover,
          ),
          ButtonBar(
            children: <Widget>[
              TextButton(
                child: Icon(Icons.thumb_up),
                onPressed: () {/* Like action */},
              ),
              TextButton(
                child: Icon(Icons.comment),
                onPressed: () {/* Comment action */},
              ),
              TextButton(
                child: Icon(Icons.share),
                onPressed: () {/* Share action */},
              ),
            ],
          )
        ],
      ),
    );
  }
}
