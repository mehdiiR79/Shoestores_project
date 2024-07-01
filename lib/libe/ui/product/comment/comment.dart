import 'package:flutter/material.dart';
import 'package:shoestores/libe/data/comment.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  const CommentItem({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          // border: Border.all(
          //   color: Colors.grey,
          //   width: 1,
          // ),
          borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment.title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    comment.email,
                    style: TextStyle(color: Colors.grey,fontSize: 12),
                  ),
                ],
              ),
              Text(comment.date,style: TextStyle(color: Colors.grey,fontSize: 12)),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            comment.content,
            style: const TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
