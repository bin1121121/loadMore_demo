import 'package:flutter/material.dart';
import 'package:loadmore_demo/ui/home/components/home_list_posts.dart';
import 'package:loadmore_demo/ui/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    return Scaffold(
      body: viewModel.error.isEmpty
          ? HomeListPost()
          : Center(
              child: Text(
                viewModel.error,
                style: const TextStyle(color: Colors.red),
              ),
            ),
    );
  }
}
