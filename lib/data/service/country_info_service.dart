import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

import '../model/country_info_model.dart';

class CountryInfoService {

  final client = Client();

  Future<CountryInfoModel?> getCountryInfoModel({required String titles}) async {
    try {
      final response = await client.get(Uri.parse('https://ko.wikipedia.org/w/api.php?action=query&prop=extracts&titles=$titles&format=json&exintro=1&explaintext=1&origin=*'), );

      if (response.statusCode != 200) {
        log('response is not 200 : ${response.statusCode}');
        return null;
      }

      final json = jsonDecode(response.body);
      final jsonBody = CountryInfoModel.fromJson(json);

      return jsonBody;

    } catch (e, t) {
      log('getCountryInfoModel', error: e, stackTrace: t);
      return null;
    }
  }

}