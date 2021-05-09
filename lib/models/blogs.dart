// To parse this JSON data, do
//
//     final blogsModel = blogsModelFromJson(jsonString);

import 'dart:convert';

BlogsModel blogsModelFromJson(String str) => BlogsModel.fromJson(json.decode(str));

String blogsModelToJson(BlogsModel data) => json.encode(data.toJson());

class BlogsModel {
  BlogsModel({
    this.blogs,
  });

  List<Blog> blogs;

  factory BlogsModel.fromJson(Map<String, dynamic> json) => BlogsModel(
    blogs: List<Blog>.from(json["blogs"].map((x) => Blog.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "blogs": List<dynamic>.from(blogs.map((x) => x.toJson())),
  };
}

class Blog {
  Blog({
    this.id,
    this.title,
    this.description,
    this.coverPhoto,
    this.categories,
    this.author,
  });

  int id;
  String title;
  String description;
  String coverPhoto;
  List<String> categories;
  Author author;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    coverPhoto: json["cover_photo"],
    categories: List<String>.from(json["categories"].map((x) => x)),
    author: Author.fromJson(json["author"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "cover_photo": coverPhoto,
    "categories": List<dynamic>.from(categories.map((x) => x)),
    "author": author.toJson(),
  };
}

class Author {
  Author({
    this.id,
    this.name,
    this.avatar,
    this.profession,
  });

  int id;
  String name;
  String avatar;
  String profession;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
    profession: json["profession"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "profession": profession,
  };
}
