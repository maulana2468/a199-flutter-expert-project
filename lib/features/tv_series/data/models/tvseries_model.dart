// ignore_for_file: must_be_immutable

import 'package:ditonton/features/tv_series/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  TvSeriesModel({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  String? posterPath;
  double? popularity;
  int? id;
  String? backdropPath;
  double? voteAverage;
  String? overview;
  String? firstAirDate;
  List<String>? originCountry;
  List<int>? genreIds;
  String? originalLanguage;
  int? voteCount;
  String? name;
  String? originalName;

  TvSeries toEntity() {
    return TvSeries(
      posterPath: this.posterPath ?? "",
      popularity: this.popularity ?? 0,
      id: this.id ?? 0,
      backdropPath: this.backdropPath ?? "",
      voteAverage: this.voteAverage ?? 0,
      overview: this.overview ?? "",
      firstAirDate: this.firstAirDate ?? "",
      originCountry: this.originCountry ?? [],
      genreIds: this.genreIds ?? [],
      originalLanguage: this.originalLanguage ?? "",
      voteCount: this.voteCount ?? 0,
      name: this.name ?? "",
      originalName: this.originalName ?? "",
    );
  }

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        popularity: json["popularity"].toDouble(),
        id: json["id"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        firstAirDate: json["first_air_date"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"],
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath == null ? null : posterPath,
        "popularity": popularity,
        "id": id,
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "vote_average": voteAverage,
        "overview": overview,
        "first_air_date": firstAirDate,
        // "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "origin_country": List<dynamic>.from(originCountry!.map((x) => x)),
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "original_language": originalLanguage,
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
      };

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        originCountry,
        genreIds,
        originalLanguage,
        voteCount,
        name,
        originalName,
      ];
}
