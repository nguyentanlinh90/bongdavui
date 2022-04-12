class FieldModel {
  final String name;
  final List<String> phones;

  FieldModel(this.name, this.phones);

  FieldModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phones = json['phones'];

  Map<String, Object?> toJson() =>
      {
        'name': name,
        'phones': phones
      };
}
