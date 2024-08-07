import 'package:loadmore_demo/core/network_bound_resource.dart';
import 'package:loadmore_demo/core/remote/response/post_response.dart';
import 'package:loadmore_demo/core/remote/services/post_services.dart';
import 'package:loadmore_demo/core/resource.dart';

class PostRepository {
  final PostServices postServices;
  PostRepository({required this.postServices});

  Future<Resource<List<PostResponse>>> getPosts(int page, int limit) async {
    return await NetworkBoundResource<List<PostResponse>, List<PostResponse>>(
      createSerializedCall: () => postServices.getPosts(page, limit),
    ).getAsFuture();
  }
}
