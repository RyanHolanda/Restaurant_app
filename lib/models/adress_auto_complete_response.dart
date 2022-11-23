// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

import 'package:car_app/models/adress_autocomplete_prediction.dart';

class PlaceAutocompleteResponse {
  final String? status;
  final List<AutocompletePrediction>? predictions;

  PlaceAutocompleteResponse({this.status, this.predictions});

  factory PlaceAutocompleteResponse.fromJson(Map<String, dynamic> json) {
    return PlaceAutocompleteResponse(
      status: json['status'] as String?,
      predictions: json['predictions'] != null
          ? json['predictions']
              .map<AutocompletePrediction>(
                  (json) => AutocompletePrediction.fromJson(json))
              .toList()
          : null,
    );
  }

  static PlaceAutocompleteResponse parseAutocompleteResult(
    String responsebody){
      final parsed = json.decode(responsebody).cast<String, dynamic>();

      return PlaceAutocompleteResponse.fromJson(parsed);
    }
}
