class VideoModel {
  String? url;
  String? thumbnailUrl;
  int? duration; // in seconds
  int? size; // in bytes
  String? fileName;
  
  VideoModel({
    this.url,
    this.thumbnailUrl,
    this.duration,
    this.size,
    this.fileName,
  });

  VideoModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
    duration = json['duration'];
    size = json['size'];
    fileName = json['fileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['thumbnailUrl'] = thumbnailUrl;
    data['duration'] = duration;
    data['size'] = size;
    data['fileName'] = fileName;
    return data;
  }

  VideoModel copyWith({
    String? url,
    String? thumbnailUrl,
    int? duration,
    int? size,
    String? fileName,
  }) {
    return VideoModel(
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      duration: duration ?? this.duration,
      size: size ?? this.size,
      fileName: fileName ?? this.fileName,
    );
  }
}