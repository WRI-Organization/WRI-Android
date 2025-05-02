class CountryInfoModel {
  final bool state;
  final Data data;

  CountryInfoModel({required this.state, required this.data});

  factory CountryInfoModel.fromJson(Map<String, dynamic> json) {
    return CountryInfoModel(
      state: json['state'] ?? false,
      data: Data.fromJson(json['data'] ?? {}),
    );
  }
}

class Data {
  final String country_name;
  final String flag_url;
  final String dang_map_download_url;
  final String continent;
  final String extract;
  final int alarm_level;
  final Info info;
  final String weather;
  final String exchange_rate;

  Data({
    required this.country_name,
    required this.flag_url,
    required this.dang_map_download_url,
    required this.continent,
    required this.extract,
    required this.alarm_level,
    required this.info,
    required this.weather,
    required this.exchange_rate,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      country_name: json['country_name'] ?? '',
      flag_url: json['flag_url'] ?? '',
      dang_map_download_url: json['dang_map_download_url'] ?? '',
      continent: json['continent'] ?? '',
      extract: json['extract'] ?? '',
      alarm_level: json['alarm_level'] ?? 0,
      info: Info.fromJson(json['info'] ?? {}),
      weather: json['weather'] ?? '',
      exchange_rate: json['exchange_rate'] ?? '',
    );
  }
}

class Info {
  final String countryName;
  final String location;
  final String population;
  final String climate;
  final String area;
  final String capital;
  final String language;
  final String religion;

  Info({
    required this.countryName,
    required this.location,
    required this.population,
    required this.climate,
    required this.area,
    required this.capital,
    required this.language,
    required this.religion,
  });

  factory Info.fromJson(dynamic rawJson) {
    if (rawJson == null || rawJson['국명'] == null) {
      return Info(
        countryName: '',
        location: '',
        population: '',
        climate: '',
        area: '',
        capital: '',
        language: '',
        religion: '',
      );
    }

    final info = rawJson as Map<String, dynamic>;
    return Info(
      countryName: info['국명'] ?? '',
      location: info['위치'] ?? '',
      population: info['인구'] ?? '',
      climate: info['기후'] ?? '',
      area: info['면적'] ?? '',
      capital: info['수도'] ?? '',
      language: info['언어'] ?? '',
      religion: info['종교'] ?? '',
    );
  }
}
