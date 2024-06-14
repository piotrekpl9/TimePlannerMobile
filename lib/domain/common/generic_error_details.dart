class GenericErrorDetails {
  final String name;
  final String code;
  final String description;

  GenericErrorDetails(
      {required this.name, required this.code, required this.description});

  factory GenericErrorDetails.fromJson(Map<String, dynamic> json) {
    return GenericErrorDetails(
      name: json['name'],
      code: json['code'],
      description: json['description'],
    );
  }
}
