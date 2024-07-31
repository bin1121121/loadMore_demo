import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loadmore_demo/post.dart';

class Controller extends ChangeNotifier {
  int page = 0;
  int limit = 10;
  bool isLoadMore = false;
  List<Post> posts = [];
  String baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  ScrollController scrollController = ScrollController();
  String error = "";

  void onInit() {
    getPosts();
    scrollController.addListener(scrollListener);
  }

  Future getPosts() async {
    isLoadMore = true;
    try {
      var response =
          await http.get(Uri.parse("$baseUrl?_page=$page&_limit=$limit"));
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        List<Post> newPosts =
            List<Post>.from(list.map((e) => Post.fromJson(e)));
        posts.addAll(newPosts);
        page++;
        isLoadMore = false;
      } else {
        isLoadMore = false;
        throw Exception('Failed to load data');
      }
    } catch (e) {
      error = e.toString();
    }
    notifyListeners();
  }

  void scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.9) {
      getPosts();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
