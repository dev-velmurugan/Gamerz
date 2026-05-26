import 'package:json_annotation/json_annotation.dart';

part 'game_model.g.dart';

@JsonSerializable()
class GameModel {
  final String id;
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final String? category;
  final bool? isLive;
  final int? prizePool;
  final int? entryFee;
  final int? totalSpots;
  final int? filledSpots;

  const GameModel({
    required this.id,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.category,
    this.isLive,
    this.prizePool,
    this.entryFee,
    this.totalSpots,
    this.filledSpots,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameModelToJson(this);
}

@JsonSerializable()
class MatchModel {
  final String id;
  final String team1Name;
  final String team2Name;
  final String? team1Logo;
  final String? team2Logo;
  final String? matchTime;
  final String? matchDate;
  final String? tournament;
  final bool? isLive;

  const MatchModel({
    required this.id,
    required this.team1Name,
    required this.team2Name,
    this.team1Logo,
    this.team2Logo,
    this.matchTime,
    this.matchDate,
    this.tournament,
    this.isLive,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchModelToJson(this);
}
