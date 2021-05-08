import 'dart:async';

import 'package:find_my_waifu/models/image_response.dart';
import 'package:find_my_waifu/networking/api_response.dart';
import 'package:find_my_waifu/repository/image_repository.dart';

class ImageBloc {
  ImageRepository _imageRepository = ImageRepository();
  StreamController<ApiResponse<ImageResponse>> _imageController =
      StreamController<ApiResponse<ImageResponse>>();

  StreamSink<ApiResponse<ImageResponse>> get imageSink => _imageController.sink;
  Stream<ApiResponse<ImageResponse>> get imageStream => _imageController.stream;

  ImageBloc() {
    fetchImage();
  }

  fetchImage() async {
    imageSink.add(ApiResponse.loading('Fetching Waifu'));
    try {
      ImageResponse response = await _imageRepository.fetchSfwImage();
      imageSink.add(ApiResponse.completed(response));
    } catch (e) {
      imageSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _imageController.close();
  }
}
