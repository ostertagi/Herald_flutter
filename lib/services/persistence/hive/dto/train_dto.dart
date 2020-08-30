import 'package:Herald_flutter/model/place.dart';
import 'package:Herald_flutter/model/train.dart';
import 'package:built_collection/built_collection.dart';
import 'package:hive/hive.dart';

import 'hive_type_ids.dart';
import 'place_dto.dart';
import 'train_type_dto.dart';

part 'train_dto.g.dart';

@HiveType(typeId: HiveTypeId.trainId)
class TrainDto {
  @HiveField(0)
  final String trainId;
  @HiveField(1)
  final TrainTypeDto type;
  @HiveField(2)
  final String departStation;
  @HiveField(3)
  final String arriveStation;
  @HiveField(4)
  final DateTime departTime;
  @HiveField(5)
  final List<PlaceDto> places;
  @HiveField(6)
  final bool reserved;
  @HiveField(7)
  final bool comfort;
  @HiveField(8)
  final bool speed;
  @HiveField(9)
  final bool accessible;
  @HiveField(10)
  final int duration;

  TrainDto(
      this.trainId,
      this.type,
      this.departStation,
      this.arriveStation,
      this.departTime,
      this.places,
      this.reserved,
      this.comfort,
      this.speed,
      this.accessible,
      this.duration);

  Train convertDtoToEntity() {
    return Train((b) => {
          b
            ..trainId = trainId
            ..type = convertTrainTypeToEntity(type)
            ..departStation = departStation
            ..arriveStation = arriveStation
            ..departTime = departTime
            ..places =
                BuiltList<Place>.from(places.map((e) => e.convertToEntity()).toList())
                    .toBuilder()
            ..reserved = reserved
            ..comfort = comfort
            ..speed = speed
            ..accessible = accessible
            ..duration = Duration(minutes: duration)
        });
  }

  static TrainDto convertEntityToDto(Train entity) {
    return TrainDto(
        entity.trainId,
        convertTrainTypeToDto(entity.type),
        entity.departStation,
        entity.arriveStation,
        entity.departTime,
        entity.places.map((e) => PlaceDto.convertToDto(e)).toList(),
        entity.reserved,
        entity.comfort,
        entity.speed,
        entity.accessible,
        entity.duration.inMinutes);
  }
}
