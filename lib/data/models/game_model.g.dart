// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameModel _$GameModelFromJson(Map<String, dynamic> json) => GameModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      imageUrl: json['imageUrl'] as String?,
      category: json['category'] as String?,
      isLive: json['isLive'] as bool?,
      prizePool: (json['prizePool'] as num?)?.toInt(),
      entryFee: (json['entryFee'] as num?)?.toInt(),
      totalSpots: (json['totalSpots'] as num?)?.toInt(),
      filledSpots: (json['filledSpots'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GameModelToJson(GameModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      'isLive': instance.isLive,
      'prizePool': instance.prizePool,
      'entryFee': instance.entryFee,
      'totalSpots': instance.totalSpots,
      'filledSpots': instance.filledSpots,
    };

MatchModel _$MatchModelFromJson(Map<String, dynamic> json) => MatchModel(
      id: json['id'] as String,
      team1Name: json['team1Name'] as String,
      team2Name: json['team2Name'] as String,
      team1Logo: json['team1Logo'] as String?,
      team2Logo: json['team2Logo'] as String?,
      matchTime: json['matchTime'] as String?,
      matchDate: json['matchDate'] as String?,
      tournament: json['tournament'] as String?,
      isLive: json['isLive'] as bool?,
    );

Map<String, dynamic> _$MatchModelToJson(MatchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'team1Name': instance.team1Name,
      'team2Name': instance.team2Name,
      'team1Logo': instance.team1Logo,
      'team2Logo': instance.team2Logo,
      'matchTime': instance.matchTime,
      'matchDate': instance.matchDate,
      'tournament': instance.tournament,
      'isLive': instance.isLive,
    };
