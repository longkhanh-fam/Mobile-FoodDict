import 'package:flutter/material.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:fooderapp/models/food_model.dart';
import 'package:fooderapp/services/food_service.dart';
import 'package:fooderapp/utils/helpers.dart';

class CommentWidget extends StatefulWidget {
  final int foodId;
  final List<Comment> comments;

  const CommentWidget(this.foodId, this.comments, {Key? key}) : super(key: key);

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
          const Text(
            'Comments',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  widget.comments != null && widget.comments.isNotEmpty
                      ? ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 30),
                          itemCount: widget.comments.length,
                          itemBuilder: (context, index) {
                            Comment comment = widget.comments[index];
                            CommentAuthor author = comment.author!;

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      "@${author.name}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      comment.body,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        )
                      : const Text(
                          'No comments yet.',
                          style: TextStyle(fontSize: 16),
                        ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(hintText: 'Add a comment'),
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
          author: CommentAuthor(
              imageUrl: defaultProfileImageUrl, name: "Trung"),
          body: commentText);
      setState(() {
        widget.comments.add(newComment);
        _commentController.clear();
      });
    }
  }
}
