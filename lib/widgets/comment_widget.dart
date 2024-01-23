import 'package:flutter/material.dart';
import 'package:fooderapp/models/food_model.dart';

class CommentWidget extends StatefulWidget {
  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  List<Comment> comments = [];
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(comments[index].authorId.toString()),
                subtitle: Text(comments[index].body),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(hintText: 'Add a comment'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  _addComment();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _addComment() {
    String commentText = _commentController.text;

    if (commentText.isNotEmpty) {
      Comment newComment = Comment(authorId: 1, body: commentText);
      setState(() {
        comments.add(newComment);
        _commentController.clear();
      });
    }
  }
}