import 'package:flutter/material.dart';
import 'package:loadmore_demo/ui/base/base_viewmodel.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends BaseViewModel> extends StatelessWidget {
  final T viewModel;
  final Widget Function(BuildContext context, T viewModel, Widget? child)
      builder;
  final ValueChanged<T>? onViewModelReady;
  final Widget? child;

  const BaseWidget({
    super.key,
    required this.viewModel,
    required this.builder,
    this.onViewModelReady,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    viewModel.setContext(context);
    return ChangeNotifierProvider<T>(
      create: (context) {
        onViewModelReady?.call(viewModel);
        return viewModel;
      },
      child: Consumer<T>(
        builder: builder,
        child: child,
      ),
    );
  }
}
