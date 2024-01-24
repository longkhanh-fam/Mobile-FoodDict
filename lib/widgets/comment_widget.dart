import 'package:flutter/material.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:fooderapp/models/food_model.dart';
import 'package:fooderapp/services/food_service.dart';
import 'package:fooderapp/utils/helpers.dart';

class CommentWidget extends StatefulWidget {
  final int foodId;
  final List<Comment> comments;
  const CommentWidget(this.foodId, this.comments, {super.key});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 30),
              itemCount: widget.comments.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              widget.comments[index].author!.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const HorizontalSpacer(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "@${widget.comments[index].author!.name}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(widget.comments[index].body,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 16)),
                          ],
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration:
                        const InputDecoration(hintText: 'Add a comment'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _addComment();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addComment() async {
    String commentText = _commentController.text;

    if (commentText.isNotEmpty) {
      await commentFood(widget.foodId, commentText);
      Comment newComment = Comment(
          author:
              CommentAuthor(imageUrl: defaultProfileImageUrl, name: "Trung"),
          body: commentText);
      setState(() {
        widget.comments.add(newComment);
        _commentController.clear();
      });
    }
  }
}
