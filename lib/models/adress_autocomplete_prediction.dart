class AutocompletePrediction {
  final String? description;
  final StructuredFormatting? structuredFormatting;
  final String? placeID;

  final String? reference;
  AutocompletePrediction({
    this.description,
    this.structuredFormatting,
    this.placeID,
    this.reference
  });

  factory AutocompletePrediction.fromJson(Map<String, dynamic> json) {
    return AutocompletePrediction(
      description: json['description'] as String?,
      placeID: json['place_id'] as String?,
      reference: json['reference'] as String?,
      structuredFormatting: json['structured_formatting'] != null
      ? StructuredFormatting.fromJson(json['structured_formatting']) : null
    );
  }
}

class StructuredFormatting {
  final String? mainText;
  final String? secondaryText;
  final List? city;

  StructuredFormatting({this.mainText, this.secondaryText, this.city});

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['main_text'] as String?,
      secondaryText: json['secondary_text'] as String?,
      city: json['terms'] as List?
    );
  }
}