import 'dart:async';

import 'package:find_my_waifu/models/image_response.dart';
import 'package:find_my_waifu/networking/response.dart';
import 'package:find_my_waifu/repository/image_repository.dart';

class ImageBloc {
  ImageRepository _imageRepository = ImageRepository();
  StreamController<Response<ImageResponse>> _imageController =
      StreamController<Response<ImageResponse>>();

  StreamSink<Response<ImageResponse>> get imageSink => _imageController.sink;
  Stream<Response<ImageResponse>> get imageStream => _imageController.stream;

  ImageBloc() {
    fetchImage();
  }

  fetchImage() async {
    imageSink.add(Response.loading('Fetching Waifu'));
    try {
      ImageResponse response = await _imageRepository.fetchSfwImage();
      imageSink.add(Response.completed(response));
    } catch (e) {
      imageSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _imageController.close();
  }
}
