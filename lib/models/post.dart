import 'dart:html';

class Like {
  late final int likes;
  late final List<String> usernames;

  Like({required this.likes, required this.usernames});

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
        usernames: (json['usernames'] as List).map((e) => e as String).toList(),
        likes: json['likes']);
  }

  Map<String, dynamic> toJson() {
    return {'likes': this.likes, 'username': this.usernames};
  }
}

class Comment {
  late final String username;
  late final String comment;
  late final String userImage;

  Comment(
      {required this.username, required this.comment, required this.userImage});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        username: json['username'],
        comment: json['comment'],
        userImage: json['userImage']);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': this.username,
      'comment': this.comment,
      'userImage': this.userImage
    };
  }
}

class Post {
  late final String id;
  late final String userId;
  final String title;
  final String imageUrl;
  final String description;
  final List<Comment> comments;
  final Like like;

  Post(
      {required this.userId,
      required this.title,
      required this.comments,
      required this.description,
      required this.id,
      required this.imageUrl,
      required this.like});
}
