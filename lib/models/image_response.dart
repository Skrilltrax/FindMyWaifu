class ImageResponse {
  final String url;

  ImageResponse({required this.url});

  factory ImageResponse.fromJson(Map<String, dynamic> json) {
    return ImageResponse(url: json['url']);
  }
}