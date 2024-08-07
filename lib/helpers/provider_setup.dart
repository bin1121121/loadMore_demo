import 'package:loadmore_demo/core/remote/services/post_services.dart';
import 'package:loadmore_demo/core/repository/post_repository.dart';
import 'package:loadmore_demo/core/retrofit.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...dependentRepositories,
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: Retrofit()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<Retrofit, PostServices>(
    update: (context, retrofit, _) => PostServices(retrofit),
  ),
];

List<SingleChildWidget> dependentRepositories = [
  ProxyProvider<PostServices, PostRepository>(
    update: (context, postServices, _) =>
        PostRepository(postServices: postServices),
  ),
];
