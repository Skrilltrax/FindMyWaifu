import 'package:find_my_waifu/models/image_response.dart';
import 'package:find_my_waifu/networking/api_base_helper.dart';

class ImageRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ImageResponse> fetchSfwImage() async {
    final response = await _helper.get("sfw/waifu");

    return ImageResponse.fromJson(response);
  }
}
