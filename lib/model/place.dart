import 'dart:convert';

import 'package:Herald_flutter/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hive/hive.dart';

import 'place_type.dart';

part 'place.g.dart';

@HiveType(typeId: 1)
abstract class Place implements Built<Place, PlaceBuilder> {

  PlaceType get type;
  int get amount;
  double get costBYN;
  double get costRUB;
  double get costUSD;
  double get costEUR;

  Place._();
  factory Place([updates(PlaceBuilder b)]) = _$Place;

  String toJson() {
    return json
        .encode(serializers.serializeWith(Place.serializer, this));
  }

  static Place fromJson(String jsonString) {
    return serializers.deserializeWith(
        Place.serializer, json.decode(jsonString));
  }

  static Serializer<Place> get serializer => _$placeSerializer;

}