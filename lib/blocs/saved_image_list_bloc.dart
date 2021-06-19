import 'dart:async';

import 'package:find_my_waifu/models/image_list_response.dart';
import 'package:find_my_waifu/models/image_response.dart';
import 'package:find_my_waifu/networking/response.dart';
import 'package:find_my_waifu/repository/image_repository.dart';

class ImageListBloc {
  ImageRepository _imageRepository = ImageRepository();
  StreamController<Response<List<String>>> _imageController = StreamController<Response<List<String>>>();

  StreamSink<Response<List<String>>> get imageSink => _imageController.sink;
  Stream<Response<List<String>>> get imageStream => _imageController.stream;

  ImageListBloc() {
    fetchImageList();
  }

  fetchImageList() async {
    imageSink.add(Response.loading('Fetching Waifu'));
    try {
      List<String> response = await _imageRepository.fetchSavedImages();
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
