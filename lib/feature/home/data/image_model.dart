class ImageModel {
  ImageModel({
    required this.id,
    required this.filePath,
    this.savedAt,
    this.isFavorite = false,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      filePath: json['filePath'],
      savedAt: json['savedAt'] != null ? DateTime.parse(json['savedAt']) : null,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  final String id;
  final String filePath;
  final DateTime? savedAt;
  bool isFavorite;

  ImageModel copyWith({
    String? id,
    String? filePath,
    DateTime? savedAt,
    bool? isFavorite,
  }) {
    return ImageModel(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      savedAt: savedAt ?? this.savedAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'filePath': filePath,
        'savedAt': savedAt?.toIso8601String(),
        'isFavorite': isFavorite,
      };
}
