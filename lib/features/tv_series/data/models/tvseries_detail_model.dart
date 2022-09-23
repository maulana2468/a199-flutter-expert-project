// To parse required this JSON data, do
//
//     final tvSeriesDetailResponse = tvSeriesDetailResponseFromJson(jsonString);

// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/tvseries_detail.dart';

TvSeriesDetailResponse tvSeriesDetailResponseFromJson(String str) =>
    TvSeriesDetailResponse.fromJson(json.decode(str));

String tvSeriesDetailResponseToJson(TvSeriesDetailResponse data) =>
    json.encode(data.toJson());

class TvSeriesDetailResponse extends Equatable {
  TvSeriesDetailResponse({
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  String backdropPath;
  List<CreatedByModel> createdBy;
  List<int> episodeRunTime;
  DateTime firstAirDate;
  List<GenreTvSeriesModel> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  DateTime lastAirDate;
  LastEpisodeToAirModel lastEpisodeToAir;
  String name;
  dynamic nextEpisodeToAir;
  List<NetworkModel> networks;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String posterPath;
  List<NetworkModel> productionCompanies;
  List<ProductionCountryModel> productionCountries;
  List<SeasonModel> seasons;
  List<SpokenLanguageModel> spokenLanguages;
  String status;
  String tagline;
  String type;
  double voteAverage;
  int voteCount;

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      backdropPath: this.backdropPath,
      createdBy: this.createdBy.map((e) => e.toEntity()).toList(),
      episodeRunTime: this.episodeRunTime,
      firstAirDate: this.firstAirDate,
      genres: this.genres.map((e) => e.toEntity()).toList(),
      homepage: this.homepage,
      id: this.id,
      inProduction: this.inProduction,
      languages: this.languages,
      lastAirDate: this.lastAirDate,
      lastEpisodeToAir: this.lastEpisodeToAir.toEntity(),
      name: this.name,
      nextEpisodeToAir: this.nextEpisodeToAir,
      networks: this.networks.map((e) => e.toEntity()).toList(),
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      productionCompanies:
          this.productionCompanies.map((e) => e.toEntity()).toList(),
      productionCountries:
          this.productionCountries.map((e) => e.toEntity()).toList(),
      seasons: this.seasons.map((e) => e.toEntity()).toList(),
      spokenLanguages: this.spokenLanguages.map((e) => e.toEntity()).toList(),
      status: this.status,
      tagline: this.tagline,
      type: this.type,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailResponse(
        backdropPath: json["backdrop_path"],
        createdBy: List<CreatedByModel>.from(
            json["created_by"].map((x) => CreatedByModel.fromJson(x))),
        episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        genres: List<GenreTvSeriesModel>.from(
            json["genres"].map((x) => GenreTvSeriesModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: DateTime.parse(json["last_air_date"]),
        lastEpisodeToAir: LastEpisodeToAirModel.fromJson(
            json["last_episode_to_air"] ?? "No Data"),
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
        networks: List<NetworkModel>.from(
            json["networks"].map((x) => NetworkModel.fromJson(x))),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<NetworkModel>.from(
            json["production_companies"].map((x) => NetworkModel.fromJson(x))),
        productionCountries: List<ProductionCountryModel>.from(
            json["production_countries"]
                .map((x) => ProductionCountryModel.fromJson(x))),
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
        spokenLanguages: List<SpokenLanguageModel>.from(json["spoken_languages"]
            .map((x) => SpokenLanguageModel.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "created_by": List<dynamic>.from(createdBy.map((x) => x.toJson())),
        "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date":
            "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "in_production": inProduction,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "last_air_date":
            "${lastAirDate.year.toString().padLeft(4, '0')}-${lastAirDate.month.toString().padLeft(2, '0')}-${lastAirDate.day.toString().padLeft(2, '0')}",
        "last_episode_to_air": lastEpisodeToAir.toJson(),
        "name": name,
        "next_episode_to_air": nextEpisodeToAir,
        "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
        "number_of_episodes": numberOfEpisodes,
        "number_of_seasons": numberOfSeasons,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies":
            List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        "production_countries":
            List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "spoken_languages":
            List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "type": type,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  @override
  List<Object?> get props => [
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        lastEpisodeToAir,
        name,
        nextEpisodeToAir,
        networks,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        seasons,
        spokenLanguages,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}

class CreatedByModel extends Equatable {
  CreatedByModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

  int? id;
  String? creditId;
  String? name;
  int? gender;
  String? profilePath;

  CreatedBy toEntity() {
    return CreatedBy(
      id: this.id ?? 0,
      creditId: this.creditId ?? "No data",
      name: this.name ?? "No data",
      gender: this.gender ?? 0,
      profilePath: this.profilePath ?? "No data",
    );
  }

  factory CreatedByModel.fromJson(Map<String, dynamic> json) => CreatedByModel(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        gender: json["gender"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "gender": gender,
        "profile_path": profilePath,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        creditId,
        name,
        gender,
        profilePath,
      ];
}

class GenreTvSeriesModel extends Equatable {
  GenreTvSeriesModel({
    required this.id,
    required this.name,
  });

  int? id;
  String? name;

  GenreTvSeries toEntity() {
    return GenreTvSeries(
      id: this.id ?? 0,
      name: this.name ?? "No data",
    );
  }

  factory GenreTvSeriesModel.fromJson(Map<String, dynamic> json) =>
      GenreTvSeriesModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
      ];
}

class LastEpisodeToAirModel extends Equatable {
  LastEpisodeToAirModel({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  DateTime? airDate;
  int? episodeNumber;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? seasonNumber;
  String? stillPath;
  double? voteAverage;
  int? voteCount;

  LastEpisodeToAir toEntity() {
    return LastEpisodeToAir(
      airDate: this.airDate ?? DateTime(0, 0, 0),
      episodeNumber: this.episodeNumber ?? 0,
      id: this.id ?? 0,
      name: this.name ?? "No data",
      overview: this.overview ?? "No data",
      productionCode: this.productionCode ?? "No data",
      seasonNumber: this.seasonNumber ?? 0,
      stillPath: this.stillPath ?? "No data",
      voteAverage: this.voteAverage ?? 0,
      voteCount: this.voteCount ?? 0,
    );
  }

  factory LastEpisodeToAirModel.fromJson(Map<String, dynamic> json) =>
      LastEpisodeToAirModel(
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        productionCode,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}

class NetworkModel extends Equatable {
  NetworkModel({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  String? name;
  int? id;
  String? logoPath;
  String? originCountry;

  Network toEntity() {
    return Network(
      name: this.name ?? "No data",
      id: this.id ?? 0,
      logoPath: this.logoPath ?? "No data",
      originCountry: this.originCountry ?? "No data",
    );
  }

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        name: json["name"],
        id: json["id"],
        logoPath: json["logo_path"] == null ? null : json["logo_path"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "logo_path": logoPath == null ? null : logoPath,
        "origin_country": originCountry,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        id,
        logoPath,
        originCountry,
      ];
}

class ProductionCountryModel extends Equatable {
  ProductionCountryModel({
    required this.iso31661,
    required this.name,
  });

  String? iso31661;
  String? name;

  ProductionCountry toEntity() {
    return ProductionCountry(
      iso31661: this.iso31661 ?? "No data",
      name: this.name ?? "No data",
    );
  }

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) =>
      ProductionCountryModel(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        iso31661,
        name,
      ];
}

class SeasonModel extends Equatable {
  SeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  DateTime? airDate;
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;

  Season toEntity() {
    return Season(
      airDate: this.airDate ?? DateTime(0, 0, 0),
      episodeCount: this.episodeCount ?? 0,
      id: this.id ?? 0,
      name: this.name ?? "No data",
      overview: this.overview ?? "No data",
      posterPath: this.posterPath ?? "No data",
      seasonNumber: this.seasonNumber ?? 0,
    );
  }

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        airDate: DateTime.parse(json["air_date"] ?? "2022-01-01"),
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}

class SpokenLanguageModel extends Equatable {
  SpokenLanguageModel({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguage toEntity() {
    return SpokenLanguage(
      englishName: this.englishName ?? "No data",
      iso6391: this.iso6391 ?? "No data",
      name: this.name ?? "No data",
    );
  }

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) =>
      SpokenLanguageModel(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        englishName,
        iso6391,
        name,
      ];
}
