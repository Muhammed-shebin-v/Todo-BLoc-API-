

class TodoModel {
  final String id;
  final DateTime createAt;
  final String title;
  final String description;
  final bool isCompleted;

  TodoModel({
    required this.id,
    required this.createAt,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['_id'] ?? '',
      createAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(), 
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      isCompleted: json['is_completed'] ?? false, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'created_at': createAt.toIso8601String(),
      'title': title,
      'description': description,
      'is_completed': isCompleted,
    };
  }
}

