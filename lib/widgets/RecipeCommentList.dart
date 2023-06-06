import 'package:flutter/material.dart';
import 'package:plateshare/util/AppColors.dart';

import 'RecipeComment.dart';

class RecipeCommentList extends StatefulWidget {
  final List<Map<String, dynamic>> comments;

  RecipeCommentList({Key? key, required this.comments}) : super(key: key);

  @override
  RecipeCommentListState createState() => RecipeCommentListState();

  static RecipeCommentListState? of(BuildContext context) {
    return context.findAncestorStateOfType<RecipeCommentListState>();
  }
}

class RecipeCommentListState extends State<RecipeCommentList> {
  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    comments = widget.comments;
  }

  void updateComments(List<Map<String, dynamic>> updatedComments) {
    setState(() {
      comments = updatedComments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.greyAccentColor,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 400,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 1.5, 5, 1.5),
          child: Scrollbar(
            thickness: 5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comentario = comments[index];
                      final owner = comentario['owner'] as String;
                      final text = comentario['text'] as String;
                      final date = comentario['date'] as String;
                      return RecipeComment(
                        commentOwnerID: owner,
                        commentText: text,
                        commentDate: date,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}