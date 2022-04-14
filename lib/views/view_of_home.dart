import 'package:flutter/material.dart';
import '../post_model/model_post.dart';
import 'item_of_post.dart';

Widget viewOfHome(List<Post> items, bool isLoading) {
  return Stack(
    children: [
      ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return itemOfPost(context , items[index]);
        },
      ),
      isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : const SizedBox.shrink(),
    ],
  );
}