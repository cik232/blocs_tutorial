class Todo {
  final String id;
  final String title;
  final bool isDone;
  final String userId;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
    required this.userId,
  });

  // JSON ga aylantirish
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
      'userId': userId,
    };
  }

  // JSON dan obyekt yaratish
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'],
      userId: json['userId'],
    );
  }
}