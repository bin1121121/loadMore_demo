import 'package:flutter/material.dart';
import 'package:loadmore_demo/core/repository/post_repository.dart';
import 'package:loadmore_demo/ui/base/base_widget.dart';
import 'package:loadmore_demo/ui/home/components/home_view.dart';
import 'package:loadmore_demo/ui/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      viewModel: HomeViewModel(
        postRepository: Provider.of<PostRepository>(context),
      ),
      onViewModelReady: (viewModel) => viewModel.onInit(),
      builder: (context, viewModel, child) {
        return HomeView();
      },
    );
  }
}
