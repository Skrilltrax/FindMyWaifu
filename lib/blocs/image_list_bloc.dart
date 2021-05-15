import 'dart:async';

import 'package:find_my_waifu/models/image_list_response.dart';
import 'package:find_my_waifu/models/image_response.dart';
import 'package:find_my_waifu/networking/api_response.dart';
import 'package:find_my_waifu/repository/image_repository.dart';

class ImageListBloc {
  ImageRepository _imageRepository = ImageRepository();
  StreamController<ApiResponse<ImageListResponse>> _imageController =
      StreamController<ApiResponse<ImageListResponse>>();

  StreamSink<ApiResponse<ImageListResponse>> get imageSink => _imageController.sink;
  Stream<ApiResponse<ImageListResponse>> get imageStream => _imageController.stream;

  ImageListBloc() {
    fetchImageList();
  }

  fetchImageList() async {
    imageSink.add(ApiResponse.loading('Fetching Waifu'));
    try {
      ImageListResponse response = await _imageRepository.fetchSfwList();
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
