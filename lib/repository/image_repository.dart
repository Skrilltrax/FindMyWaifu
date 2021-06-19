import 'dart:io';

import 'package:find_my_waifu/models/image_list_response.dart';
import 'package:find_my_waifu/models/image_response.dart';
import 'package:find_my_waifu/networking/api_base_helper.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageRepository {
  static const String imageDirectoryName = "saved_images";
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ImageResponse> fetchSfwImage() async {
    final response = await _helper.get("sfw/waifu");

    return ImageResponse.fromJson(response);
  }

  Future<ImageListResponse> fetchSfwList() async {
    final response = await _helper.post("many/sfw/waifu");

    return ImageListResponse.fromJson(response);
  }

  Future<List<String>> fetchSavedImages() async {
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final imageDir =
        Directory(join(appDocumentsDirectory.path, imageDirectoryName));
    if (!imageDir.existsSync()) return List.empty();

    final files = imageDir.listSync();
    final paths = files.map((e) => e.path);

    return paths.toList();
  }

  void saveFile(String imageUrl) async {
    // Create imageDir if it does not exist
    final appDocumentsDirectory = await getApplicationDocumentsDirectory();
    final imageDir =
        Directory(join(appDocumentsDirectory.path, imageDirectoryName));
    if (!imageDir.existsSync()) imageDir.createSync(recursive: true);

    // Parse the string as uri
    final uri = Uri.parse(imageUrl);

    // Create file if it does not exist
    final imageName = uri.pathSegments.last;
    final imageFile = new File(join(imageDir.path, imageName));
    if (imageFile.existsSync()) return;
    imageFile.createSync(recursive: true);

    // Fetch the file from url and write it to dist
    final response = await http.get(uri);
    imageFile.writeAsBytesSync(response.bodyBytes);
  }
}
