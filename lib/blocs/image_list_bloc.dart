import 'dart:async';

import 'package:find_my_waifu/models/image_list_response.dart';
import 'package:find_my_waifu/networking/response.dart';
import 'package:find_my_waifu/repository/image_repository.dart';

class ImageListBloc {
  ImageRepository _imageRepository = ImageRepository();
  StreamController<Response<ImageListResponse>> _imageController =
      StreamController<Response<ImageListResponse>>();

  StreamSink<Response<ImageListResponse>> get imageSink => _imageController.sink;
  Stream<Response<ImageListResponse>> get imageStream => _imageController.stream;

  ImageListBloc() {
    fetchImageList();
  }

  fetchImageList() async {
    imageSink.add(Response.loading('Fetching Waifu'));
    try {
      ImageListResponse response = await _imageRepository.fetchSfwList();
      imageSink.add(Response.completed(response));
    } catch (e) {
      imageSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  saveImage(String imageUrl) async {
    _imageRepository.saveFile(imageUrl);
  }

  dispose() {
    _imageController.close();
  }
}
