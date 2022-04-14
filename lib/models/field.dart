class FieldModel {
  static String images = 'images';
  static bool active = true;

  final bool isActive;
  final String name;
  final List<String> phones;

  FieldModel(this.isActive, this.name, this.phones);

  FieldModel.fromJson(Map<String, dynamic> json)
      : isActive = json['isActive'],
        name = json['name'],
        phones = json['phones'];

  Map<String, Object?> toJson() =>
      {'isActive': isActive, 'name': name, 'phones': phones};

}
