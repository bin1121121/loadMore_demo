import 'package:flutter/material.dart';
import 'package:loadmore_demo/core/remote/response/post_response.dart';
import 'package:loadmore_demo/core/repository/post_repository.dart';
import 'package:loadmore_demo/core/resource_type.dart';
import 'package:loadmore_demo/ui/base/base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  final PostRepository postRepository;
  HomeViewModel({required this.postRepository});
  int page = 1;
  int limit = 10;
  bool isLoadMore = false;
  bool isLoading = false;
  List<PostResponse> posts = [];
  ScrollController scrollController = ScrollController();
  String error = "";

  void onInit() {
    onRefresh();
  }

  Future getPosts() async {
    if (isLoading) return;
    isLoading = true;
    final response = await postRepository.getPosts(page, limit);
    if (response.code == ResourceType.requestSuccess) {
      posts.addAll(response.data!);
      stopLoadMore(response.data!.length);
      page++;
    } else {
      error = response.message;
    }
    isLoading = false;
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
    page = 1;
    posts.clear();
    isLoadMore = true;
    if (!scrollController.hasListeners) {
      scrollController.addListener(scrollListener);
    }
    notifyListeners();
    getPosts();
  }

  void scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.9) {
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
