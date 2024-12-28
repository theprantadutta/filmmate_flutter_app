import 'dart:convert';

import '../constants/urls.dart';
import '../dtos/application_info_dto.dart';
import 'http_service.dart';

class AppInfoService {
  Future<ApplicationInfoDto> getAppUpdateInfo() async {
    final response = await HttpService.get('$kApiUrl/$kAppUpdateInfo');
    if (response.statusCode == 200) {
      return ApplicationInfoDto.fromJson(json.decode(response.data));
    }
    throw Exception('Failed to get app update info');
  }
}
