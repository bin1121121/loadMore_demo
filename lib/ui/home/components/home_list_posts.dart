import 'package:flutter/material.dart';
import 'package:loadmore_demo/ui/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeListPost extends StatelessWidget {
  const HomeListPost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    return RefreshIndicator(
      onRefresh: viewModel.onRefresh,
      child: ListView.builder(
        controller: viewModel.scrollController,
        itemCount: viewModel.posts.length + (viewModel.isLoadMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < viewModel.posts.length) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(viewModel.posts[index].id.toString()),
                ),
                title: Text(viewModel.posts[index].title),
                subtitle: Text(viewModel.posts[index].body),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
