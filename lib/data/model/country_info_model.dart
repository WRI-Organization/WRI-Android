class CountryInfoModel {
  final Map<String, CountryPage> pages;

  CountryInfoModel({required this.pages});

  factory CountryInfoModel.fromJson(Map<String, dynamic> json) {
    final pagesMap = (json['query']['pages'] as Map<String, dynamic>?)?.map(
      (key, value) => MapEntry(key, CountryPage.fromJson(value)),
    );
    return CountryInfoModel(pages: pagesMap ?? {});
  }
}

class CountryPage {
  final int pageid;
  final int ns;
  final String title;
  final String extract;

  CountryPage({
    required this.pageid,
    required this.ns,
    required this.title,
    required this.extract,
  });

  factory CountryPage.fromJson(Map<String, dynamic> json) {
    return CountryPage(
      pageid: json['pageid'] ?? 0,
      ns: json['ns'] ?? 0,
      title: json['title'] ?? '',
      extract: json['extract'] ?? '',
    );
  }
}
