// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) {
  return EventModel(
    id: json['id'] as String,
    sportGenreId: json['sportGenreId'] as String,
    sportGenreName: json['sportGenreName'] as String,
    title: json['title'] as String,
    subTitle: json['subTitle'] as String,
    isContest: json['isContest'] as bool,
    eventStartTime: parseDate(json['eventStartTime'] as String),
    eventEndTime: parseDate(json['eventEndTime'] as String),
    startRegisterTime: parseDate(json['startRegisterTime'] as String),
    endRegisterTime: parseDate(json['endRegisterTime'] as String),
    status: json['status'] as String,
    address: json['address'] as String,
    details: json['details'] as String,
    clubName: json['clubName'] as String,
    clubPhone: json['clubPhone'] as String,
    isPrivate: json['isPrivate'] as bool,
    coverUrl: (json['coverUrl'] as List).map((e) => e as String).toList(),
    compilation: json['compilation'] as String,
    miniPeople: json['miniPeople'] as int,
    maxPeople: json['maxPeople'] as int,
    price: (json['price'] as num).toDouble(),
    isCancel: json['isCancel'] as bool,
  );
}

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sportGenreId': instance.sportGenreId,
      'sportGenreName': instance.sportGenreName,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'isContest': instance.isContest,
      'eventStartTime': instance.eventStartTime.toIso8601String(),
      'eventEndTime': instance.eventEndTime.toIso8601String(),
      'startRegisterTime': instance.startRegisterTime.toIso8601String(),
      'endRegisterTime': instance.endRegisterTime.toIso8601String(),
      'status': instance.status,
      'address': instance.address,
      'details': instance.details,
      'clubName': instance.clubName,
      'clubPhone': instance.clubPhone,
      'isPrivate': instance.isPrivate,
      'coverUrl': instance.coverUrl,
      'compilation': instance.compilation,
      'miniPeople': instance.miniPeople,
      'maxPeople': instance.maxPeople,
      'price': instance.price,
      'isCancel': instance.isCancel,
    };
