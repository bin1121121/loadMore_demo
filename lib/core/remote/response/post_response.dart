import 'package:json_annotation/json_annotation.dart';
part 'post_response.g.dart';

@JsonSerializable()
class PostResponse {
  final int userId;
  final int id;
  final String title;
  final String body;
  PostResponse({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);

  @override
  String toString() {
    return 'PostResponse(userId: $userId, id: $id, title: $title, body: $body)';
  }
}
