import 'package:flutter/material.dart';
import 'package:loadmore_demo/core/remote/response/post_response.dart';
import 'package:loadmore_demo/core/repository/post_repository.dart';
import 'package:loadmore_demo/core/resource_type.dart';
import 'package:loadmore_demo/ui/base/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  final PostRepository postRepository;
  HomeViewModel({required this.postRepository});
  int page = 0;
  int limit = 10;
  bool isLoadMore = false;
  List<PostResponse> posts = [];
  ScrollController scrollController = ScrollController();
  String error = "";

  void onInit() {
    isLoadMore = true;
    getPosts();
    scrollController.addListener(scrollListener);
  }

  Future getPosts() async {
    final response = await postRepository.getPosts(page, limit);
    if (response.code == ResourceType.requestSuccess) {
      posts.addAll(response.data!);
      stopLoadMore(response.data!.length);
      page++;
    } else {
      error = response.message;
    }
    isLoadMore = false;
    notifyListeners();
  }

  void stopLoadMore(int dataLength) {
    if (dataLength < limit) {
      isLoadMore = false;
      scrollController.removeListener(scrollListener);
      notifyListeners();
    }
  }

  Future onRefresh() async {
    page = 0;
    posts.clear();
    isLoadMore = true;
    if (!scrollController.hasListeners) {
      scrollController.addListener(scrollListener);
    }
    notifyListeners();
    getPosts();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoadMore = true;
      notifyListeners();
      getPosts();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
