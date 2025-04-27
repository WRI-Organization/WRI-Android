import 'package:flutter/material.dart';
import 'package:wri/data/model/country_info_model.dart';
import 'package:wri/data/service/country_info_service.dart';

CountryInfoProvider countryInfoProvider = CountryInfoProvider(CountryInfoService());

class CountryInfoProvider extends ChangeNotifier {

  bool isTextOverFlow = false;

  CountryInfoModel? countryInfoModel;
  final CountryInfoService service;
  CountryInfoProvider(this.service);

  Future<void> loadCountryInfoModel({required String titles}) async {
    final res = await service.getCountryInfoModel(titles: titles);
    countryInfoModel = res;
    notifyListeners();
  }

}