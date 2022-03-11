class CountryModel {
  String name;
  String flag;
  int population;
  String? capital;
  String region;
  String subregion;
  List<dynamic>? borders;

  CountryModel(
      {required this.name,
        required this.flag,
        required this.population,
        this.capital,
        required this.region,
        required this.subregion,
        this.borders
      });

  static CountryModel fromJSON(Map<String, dynamic> map) {
    return CountryModel(
        name: map['name'],
        flag: map['flag'],
        population: map['population'],
        capital: map['capital'],
        region: map['region'],
        subregion: map['subregion'],
        borders: map['borders']
    );
  }
}