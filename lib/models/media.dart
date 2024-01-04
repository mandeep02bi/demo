// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    List<Category> categories;

    Welcome({
        required this.categories,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

class Category {
    String name;
    List<Video> videos;

    Category({
        required this.name,
        required this.videos,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    };
}

class Video {
    int id;
    String description;
    List<String> sources;
    Subtitle subtitle;
    String thumb;
    String title;

    Video({
        required this.id,
        required this.description,
        required this.sources,
        required this.subtitle,
        required this.thumb,
        required this.title,
    });

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        description: json["description"],
        sources: List<String>.from(json["sources"].map((x) => x)),
        subtitle: subtitleValues.map[json["subtitle"]]!,
        thumb: json["thumb"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "sources": List<dynamic>.from(sources.map((x) => x)),
        "subtitle": subtitleValues.reverse[subtitle],
        "thumb": thumb,
        "title": title,
    };
}

enum Subtitle {
    BY_BLENDER_FOUNDATION,
    BY_GARAGE419,
    BY_GOOGLE
}

final subtitleValues = EnumValues({
    "By Blender Foundation": Subtitle.BY_BLENDER_FOUNDATION,
    "By Garage419": Subtitle.BY_GARAGE419,
    "By Google": Subtitle.BY_GOOGLE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
