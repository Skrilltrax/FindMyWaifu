class ImageListResponse {
  final List<String> files;

  ImageListResponse({required this.files});

  factory ImageListResponse.fromJson(Map<String, dynamic> json) {
    return ImageListResponse(files: json['files'].cast<String>());
  }
}