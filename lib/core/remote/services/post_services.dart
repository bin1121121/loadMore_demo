import 'package:dio/dio.dart';
import 'package:loadmore_demo/core/remote/response/post_response.dart';
import 'package:loadmore_demo/utils/app_const.dart';
import 'package:retrofit/retrofit.dart';

part 'post_services.g.dart';

@RestApi(baseUrl: AppConst.baseUrl)
abstract class PostServices {
  factory PostServices(Dio dio, {String baseUrl}) = _PostServices;

  @GET('/posts')
  Future<List<PostResponse>> getPosts(
    @Query('_page') int page,
    @Query('_limit') int limit,
  );
}
