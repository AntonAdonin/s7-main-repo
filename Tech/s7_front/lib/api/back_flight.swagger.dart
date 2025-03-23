// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'back_flight.enums.swagger.dart' as enums;
export 'back_flight.enums.swagger.dart';

part 'back_flight.swagger.chopper.dart';
part 'back_flight.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class BackFlight extends ChopperService {
  static BackFlight create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    Iterable<dynamic>? interceptors,
  }) {
    if (client != null) {
      return _$BackFlight(client);
    }

    final newClient = ChopperClient(
        services: [_$BackFlight()],
        converter: converter ?? $JsonSerializableConverter(),
        //interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        errorConverter: errorConverter,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$BackFlight(newClient);
  }

  ///Get Aggregated Pois
  ///@param icao24
  Future<chopper.Response<FlightPOIResponse>> poiFlightIcao24PoisPost({
    required String? icao24,
    required FilterRequest? body,
  }) {
    generatedMapping.putIfAbsent(
        FlightPOIResponse, () => FlightPOIResponse.fromJsonFactory);

    return _poiFlightIcao24PoisPost(icao24: icao24, body: body);
  }

  ///Get Aggregated Pois
  ///@param icao24
  @Post(
    path: '/poi/flight/{icao24}/pois',
    optionalBody: true,
  )
  Future<chopper.Response<FlightPOIResponse>> _poiFlightIcao24PoisPost({
    @Path('icao24') required String? icao24,
    @Body() required FilterRequest? body,
  });

  ///Get Pois Details
  Future<chopper.Response<Object>> poiPoisDetailsPost(
      {required PoiIdsRequest? body}) {
    return _poiPoisDetailsPost(body: body);
  }

  ///Get Pois Details
  @Post(
    path: '/poi/pois/details',
    optionalBody: true,
  )
  Future<chopper.Response<Object>> _poiPoisDetailsPost(
      {@Body() required PoiIdsRequest? body});

  ///Get Poi Summarizations
  Future<chopper.Response> poiSummarizePost(
      {required CompletionRequest? body}) {
    return _poiSummarizePost(body: body);
  }

  ///Get Poi Summarizations
  @Post(
    path: '/poi/summarize',
    optionalBody: true,
  )
  Future<chopper.Response> _poiSummarizePost(
      {@Body() required CompletionRequest? body});

  ///Get Flights
  ///@param page Номер страницы
  ///@param limit Количество записей на страницу
  ///@param sort_by Поле для сортировки: icao24, count, flightDuration
  ///@param order Порядок сортировки: 1 для ASC, -1 для DESC
  Future<chopper.Response<List<FlightBase>>> flightsGet({
    int? page,
    int? limit,
    String? sortBy,
    int? order,
  }) {
    generatedMapping.putIfAbsent(FlightBase, () => FlightBase.fromJsonFactory);

    return _flightsGet(page: page, limit: limit, sortBy: sortBy, order: order);
  }

  ///Get Flights
  ///@param page Номер страницы
  ///@param limit Количество записей на страницу
  ///@param sort_by Поле для сортировки: icao24, count, flightDuration
  ///@param order Порядок сортировки: 1 для ASC, -1 для DESC
  @Get(path: '/flights/')
  Future<chopper.Response<List<FlightBase>>> _flightsGet({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('sort_by') String? sortBy,
    @Query('order') int? order,
  });

  ///Get Flight Details
  ///@param icao24
  Future<chopper.Response<DetailedResponse>> flightsIcao24DetailsGet(
      {required String? icao24}) {
    generatedMapping.putIfAbsent(
        DetailedResponse, () => DetailedResponse.fromJsonFactory);

    return _flightsIcao24DetailsGet(icao24: icao24);
  }

  ///Get Flight Details
  ///@param icao24
  @Get(path: '/flights/{icao24}/details')
  Future<chopper.Response<DetailedResponse>> _flightsIcao24DetailsGet(
      {@Path('icao24') required String? icao24});
}

@JsonSerializable(explicitToJson: true)
class CompletionRequest {
  const CompletionRequest({
    this.prompt,
    this.maxTokens,
    this.poiId,
    this.icao24,
    this.model,
  });

  factory CompletionRequest.fromJson(Map<String, dynamic> json) =>
      _$CompletionRequestFromJson(json);

  static const toJsonFactory = _$CompletionRequestToJson;
  Map<String, dynamic> toJson() => _$CompletionRequestToJson(this);

  @JsonKey(name: 'prompt')
  final String? prompt;
  @JsonKey(name: 'maxTokens')
  final dynamic maxTokens;
  @JsonKey(name: 'poi_id')
  final int? poiId;
  @JsonKey(name: 'icao24')
  final dynamic icao24;
  @JsonKey(name: 'model')
  final dynamic model;
  static const fromJsonFactory = _$CompletionRequestFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $CompletionRequestExtension on CompletionRequest {
  CompletionRequest copyWith(
      {String? prompt,
      dynamic maxTokens,
      int? poiId,
      dynamic icao24,
      dynamic model}) {
    return CompletionRequest(
        prompt: prompt ?? this.prompt,
        maxTokens: maxTokens ?? this.maxTokens,
        poiId: poiId ?? this.poiId,
        icao24: icao24 ?? this.icao24,
        model: model ?? this.model);
  }

  CompletionRequest copyWithWrapped(
      {Wrapped<String?>? prompt,
      Wrapped<dynamic>? maxTokens,
      Wrapped<int?>? poiId,
      Wrapped<dynamic>? icao24,
      Wrapped<dynamic>? model}) {
    return CompletionRequest(
        prompt: (prompt != null ? prompt.value : this.prompt),
        maxTokens: (maxTokens != null ? maxTokens.value : this.maxTokens),
        poiId: (poiId != null ? poiId.value : this.poiId),
        icao24: (icao24 != null ? icao24.value : this.icao24),
        model: (model != null ? model.value : this.model));
  }
}

@JsonSerializable(explicitToJson: true)
class DetailedResponse {
  const DetailedResponse({
    required this.icao24,
    this.count,
    this.flightDuration,
    this.flightDistance,
    this.departurePlace,
    this.arrivalPlace,
    required this.firstSeen,
    required this.lastSeen,
    required this.waypoints,
  });

  factory DetailedResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailedResponseFromJson(json);

  static const toJsonFactory = _$DetailedResponseToJson;
  Map<String, dynamic> toJson() => _$DetailedResponseToJson(this);

  @JsonKey(name: 'icao24')
  final String icao24;
  @JsonKey(name: 'count')
  final dynamic count;
  @JsonKey(name: 'flightDuration')
  final dynamic flightDuration;
  @JsonKey(name: 'flightDistance')
  final dynamic flightDistance;
  @JsonKey(name: 'departurePlace')
  final dynamic departurePlace;
  @JsonKey(name: 'arrivalPlace')
  final dynamic arrivalPlace;
  @JsonKey(name: 'first_seen')
  final int firstSeen;
  @JsonKey(name: 'last_seen')
  final int lastSeen;
  @JsonKey(name: 'waypoints', defaultValue: <Waypoint>[])
  final List<Waypoint> waypoints;
  static const fromJsonFactory = _$DetailedResponseFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $DetailedResponseExtension on DetailedResponse {
  DetailedResponse copyWith(
      {String? icao24,
      dynamic count,
      dynamic flightDuration,
      dynamic flightDistance,
      dynamic departurePlace,
      dynamic arrivalPlace,
      int? firstSeen,
      int? lastSeen,
      List<Waypoint>? waypoints}) {
    return DetailedResponse(
        icao24: icao24 ?? this.icao24,
        count: count ?? this.count,
        flightDuration: flightDuration ?? this.flightDuration,
        flightDistance: flightDistance ?? this.flightDistance,
        departurePlace: departurePlace ?? this.departurePlace,
        arrivalPlace: arrivalPlace ?? this.arrivalPlace,
        firstSeen: firstSeen ?? this.firstSeen,
        lastSeen: lastSeen ?? this.lastSeen,
        waypoints: waypoints ?? this.waypoints);
  }

  DetailedResponse copyWithWrapped(
      {Wrapped<String>? icao24,
      Wrapped<dynamic>? count,
      Wrapped<dynamic>? flightDuration,
      Wrapped<dynamic>? flightDistance,
      Wrapped<dynamic>? departurePlace,
      Wrapped<dynamic>? arrivalPlace,
      Wrapped<int>? firstSeen,
      Wrapped<int>? lastSeen,
      Wrapped<List<Waypoint>>? waypoints}) {
    return DetailedResponse(
        icao24: (icao24 != null ? icao24.value : this.icao24),
        count: (count != null ? count.value : this.count),
        flightDuration: (flightDuration != null
            ? flightDuration.value
            : this.flightDuration),
        flightDistance: (flightDistance != null
            ? flightDistance.value
            : this.flightDistance),
        departurePlace: (departurePlace != null
            ? departurePlace.value
            : this.departurePlace),
        arrivalPlace:
            (arrivalPlace != null ? arrivalPlace.value : this.arrivalPlace),
        firstSeen: (firstSeen != null ? firstSeen.value : this.firstSeen),
        lastSeen: (lastSeen != null ? lastSeen.value : this.lastSeen),
        waypoints: (waypoints != null ? waypoints.value : this.waypoints));
  }
}

@JsonSerializable(explicitToJson: true)
class FilterCondition {
  const FilterCondition({
    required this.key,
    this.$operator,
    this.$value,
  });

  factory FilterCondition.fromJson(Map<String, dynamic> json) =>
      _$FilterConditionFromJson(json);

  static const toJsonFactory = _$FilterConditionToJson;
  Map<String, dynamic> toJson() => _$FilterConditionToJson(this);

  @JsonKey(name: 'key')
  final String key;
  @JsonKey(name: '\$operator')
  final dynamic $operator;
  @JsonKey(name: '\$value')
  final dynamic $value;
  static const fromJsonFactory = _$FilterConditionFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $FilterConditionExtension on FilterCondition {
  FilterCondition copyWith({String? key, dynamic $operator, dynamic $value}) {
    return FilterCondition(
        key: key ?? this.key,
        $operator: $operator ?? this.$operator,
        $value: $value ?? this.$value);
  }

  FilterCondition copyWithWrapped(
      {Wrapped<String>? key,
      Wrapped<dynamic>? $operator,
      Wrapped<dynamic>? $value}) {
    return FilterCondition(
        key: (key != null ? key.value : this.key),
        $operator: ($operator != null ? $operator.value : this.$operator),
        $value: ($value != null ? $value.value : this.$value));
  }
}

@JsonSerializable(explicitToJson: true)
class FilterRequest {
  const FilterRequest({
    this.distance,
    this.overpassFilters,
  });

  factory FilterRequest.fromJson(Map<String, dynamic> json) =>
      _$FilterRequestFromJson(json);

  static const toJsonFactory = _$FilterRequestToJson;
  Map<String, dynamic> toJson() => _$FilterRequestToJson(this);

  @JsonKey(name: 'distance')
  final int? distance;
  @JsonKey(name: 'overpass_filters', defaultValue: <FilterCondition>[])
  final List<FilterCondition>? overpassFilters;
  static const fromJsonFactory = _$FilterRequestFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $FilterRequestExtension on FilterRequest {
  FilterRequest copyWith(
      {int? distance, List<FilterCondition>? overpassFilters}) {
    return FilterRequest(
        distance: distance ?? this.distance,
        overpassFilters: overpassFilters ?? this.overpassFilters);
  }

  FilterRequest copyWithWrapped(
      {Wrapped<int?>? distance,
      Wrapped<List<FilterCondition>?>? overpassFilters}) {
    return FilterRequest(
        distance: (distance != null ? distance.value : this.distance),
        overpassFilters: (overpassFilters != null
            ? overpassFilters.value
            : this.overpassFilters));
  }
}

@JsonSerializable(explicitToJson: true)
class FlightBase {
  const FlightBase({
    required this.icao24,
    this.count,
    this.flightDuration,
    this.flightDistance,
    this.departurePlace,
    this.arrivalPlace,
  });

  factory FlightBase.fromJson(Map<String, dynamic> json) =>
      _$FlightBaseFromJson(json);

  static const toJsonFactory = _$FlightBaseToJson;
  Map<String, dynamic> toJson() => _$FlightBaseToJson(this);

  @JsonKey(name: 'icao24')
  final String icao24;
  @JsonKey(name: 'count')
  final dynamic count;
  @JsonKey(name: 'flightDuration')
  final dynamic flightDuration;
  @JsonKey(name: 'flightDistance')
  final dynamic flightDistance;
  @JsonKey(name: 'departurePlace')
  final dynamic departurePlace;
  @JsonKey(name: 'arrivalPlace')
  final dynamic arrivalPlace;
  static const fromJsonFactory = _$FlightBaseFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $FlightBaseExtension on FlightBase {
  FlightBase copyWith(
      {String? icao24,
      dynamic count,
      dynamic flightDuration,
      dynamic flightDistance,
      dynamic departurePlace,
      dynamic arrivalPlace}) {
    return FlightBase(
        icao24: icao24 ?? this.icao24,
        count: count ?? this.count,
        flightDuration: flightDuration ?? this.flightDuration,
        flightDistance: flightDistance ?? this.flightDistance,
        departurePlace: departurePlace ?? this.departurePlace,
        arrivalPlace: arrivalPlace ?? this.arrivalPlace);
  }

  FlightBase copyWithWrapped(
      {Wrapped<String>? icao24,
      Wrapped<dynamic>? count,
      Wrapped<dynamic>? flightDuration,
      Wrapped<dynamic>? flightDistance,
      Wrapped<dynamic>? departurePlace,
      Wrapped<dynamic>? arrivalPlace}) {
    return FlightBase(
        icao24: (icao24 != null ? icao24.value : this.icao24),
        count: (count != null ? count.value : this.count),
        flightDuration: (flightDuration != null
            ? flightDuration.value
            : this.flightDuration),
        flightDistance: (flightDistance != null
            ? flightDistance.value
            : this.flightDistance),
        departurePlace: (departurePlace != null
            ? departurePlace.value
            : this.departurePlace),
        arrivalPlace:
            (arrivalPlace != null ? arrivalPlace.value : this.arrivalPlace));
  }
}

@JsonSerializable(explicitToJson: true)
class FlightPOIResponse {
  const FlightPOIResponse({
    required this.aggregations,
    required this.pois,
  });

  factory FlightPOIResponse.fromJson(Map<String, dynamic> json) =>
      _$FlightPOIResponseFromJson(json);

  static const toJsonFactory = _$FlightPOIResponseToJson;
  Map<String, dynamic> toJson() => _$FlightPOIResponseToJson(this);

  @JsonKey(name: 'aggregations')
  final Map<String, dynamic> aggregations;
  @JsonKey(name: 'pois', defaultValue: <Poi>[])
  final List<Poi> pois;
  static const fromJsonFactory = _$FlightPOIResponseFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $FlightPOIResponseExtension on FlightPOIResponse {
  FlightPOIResponse copyWith(
      {Map<String, dynamic>? aggregations, List<Poi>? pois}) {
    return FlightPOIResponse(
        aggregations: aggregations ?? this.aggregations,
        pois: pois ?? this.pois);
  }

  FlightPOIResponse copyWithWrapped(
      {Wrapped<Map<String, dynamic>>? aggregations, Wrapped<List<Poi>>? pois}) {
    return FlightPOIResponse(
        aggregations:
            (aggregations != null ? aggregations.value : this.aggregations),
        pois: (pois != null ? pois.value : this.pois));
  }
}

@JsonSerializable(explicitToJson: true)
class HTTPValidationError {
  const HTTPValidationError({
    this.detail,
  });

  factory HTTPValidationError.fromJson(Map<String, dynamic> json) =>
      _$HTTPValidationErrorFromJson(json);

  static const toJsonFactory = _$HTTPValidationErrorToJson;
  Map<String, dynamic> toJson() => _$HTTPValidationErrorToJson(this);

  @JsonKey(name: 'detail', defaultValue: <ValidationError>[])
  final List<ValidationError>? detail;
  static const fromJsonFactory = _$HTTPValidationErrorFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $HTTPValidationErrorExtension on HTTPValidationError {
  HTTPValidationError copyWith({List<ValidationError>? detail}) {
    return HTTPValidationError(detail: detail ?? this.detail);
  }

  HTTPValidationError copyWithWrapped(
      {Wrapped<List<ValidationError>?>? detail}) {
    return HTTPValidationError(
        detail: (detail != null ? detail.value : this.detail));
  }
}

@JsonSerializable(explicitToJson: true)
class Poi {
  const Poi({
    this.id,
    this.name,
    this.type,
    this.description,
    this.imageUrl,
    this.website,
    this.lat,
    this.lon,
  });

  factory Poi.fromJson(Map<String, dynamic> json) => _$PoiFromJson(json);

  static const toJsonFactory = _$PoiToJson;
  Map<String, dynamic> toJson() => _$PoiToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'website')
  final String? website;
  @JsonKey(name: 'lat')
  final dynamic lat;
  @JsonKey(name: 'lon')
  final dynamic lon;
  static const fromJsonFactory = _$PoiFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PoiExtension on Poi {
  Poi copyWith(
      {int? id,
      String? name,
      String? type,
      String? description,
      String? imageUrl,
      String? website,
      dynamic lat,
      dynamic lon}) {
    return Poi(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        website: website ?? this.website,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon);
  }

  Poi copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? name,
      Wrapped<String?>? type,
      Wrapped<String?>? description,
      Wrapped<String?>? imageUrl,
      Wrapped<String?>? website,
      Wrapped<dynamic>? lat,
      Wrapped<dynamic>? lon}) {
    return Poi(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        type: (type != null ? type.value : this.type),
        description:
            (description != null ? description.value : this.description),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        website: (website != null ? website.value : this.website),
        lat: (lat != null ? lat.value : this.lat),
        lon: (lon != null ? lon.value : this.lon));
  }
}

@JsonSerializable(explicitToJson: true)
class PoiDetail {
  const PoiDetail({
    this.id,
    this.name,
    this.type,
    this.description,
    this.imageUrl,
    this.website,
    this.lat,
    this.lon,
    required this.details,
    required this.tags,
    this.inception,
  });

  factory PoiDetail.fromJson(Map<String, dynamic> json) =>
      _$PoiDetailFromJson(json);

  static const toJsonFactory = _$PoiDetailToJson;
  Map<String, dynamic> toJson() => _$PoiDetailToJson(this);

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'website')
  final String? website;
  @JsonKey(name: 'lat')
  final dynamic lat;
  @JsonKey(name: 'lon')
  final dynamic lon;
  @JsonKey(name: 'details')
  final Object details;
  @JsonKey(name: 'tags')
  final Object tags;
  @JsonKey(name: 'inception')
  final dynamic inception;
  static const fromJsonFactory = _$PoiDetailFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PoiDetailExtension on PoiDetail {
  PoiDetail copyWith(
      {int? id,
      String? name,
      String? type,
      String? description,
      String? imageUrl,
      String? website,
      dynamic lat,
      dynamic lon,
      Object? details,
      Object? tags,
      dynamic inception}) {
    return PoiDetail(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        website: website ?? this.website,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        details: details ?? this.details,
        tags: tags ?? this.tags,
        inception: inception ?? this.inception);
  }

  PoiDetail copyWithWrapped(
      {Wrapped<int?>? id,
      Wrapped<String?>? name,
      Wrapped<String?>? type,
      Wrapped<String?>? description,
      Wrapped<String?>? imageUrl,
      Wrapped<String?>? website,
      Wrapped<dynamic>? lat,
      Wrapped<dynamic>? lon,
      Wrapped<Object>? details,
      Wrapped<Object>? tags,
      Wrapped<dynamic>? inception}) {
    return PoiDetail(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        type: (type != null ? type.value : this.type),
        description:
            (description != null ? description.value : this.description),
        imageUrl: (imageUrl != null ? imageUrl.value : this.imageUrl),
        website: (website != null ? website.value : this.website),
        lat: (lat != null ? lat.value : this.lat),
        lon: (lon != null ? lon.value : this.lon),
        details: (details != null ? details.value : this.details),
        tags: (tags != null ? tags.value : this.tags),
        inception: (inception != null ? inception.value : this.inception));
  }
}

@JsonSerializable(explicitToJson: true)
class PoiIdsRequest {
  const PoiIdsRequest({
    required this.poiIds,
  });

  factory PoiIdsRequest.fromJson(Map<String, dynamic> json) =>
      _$PoiIdsRequestFromJson(json);

  static const toJsonFactory = _$PoiIdsRequestToJson;
  Map<String, dynamic> toJson() => _$PoiIdsRequestToJson(this);

  @JsonKey(name: 'poi_ids', defaultValue: <int>[])
  final List<int> poiIds;
  static const fromJsonFactory = _$PoiIdsRequestFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $PoiIdsRequestExtension on PoiIdsRequest {
  PoiIdsRequest copyWith({List<int>? poiIds}) {
    return PoiIdsRequest(poiIds: poiIds ?? this.poiIds);
  }

  PoiIdsRequest copyWithWrapped({Wrapped<List<int>>? poiIds}) {
    return PoiIdsRequest(poiIds: (poiIds != null ? poiIds.value : this.poiIds));
  }
}

@JsonSerializable(explicitToJson: true)
class ValidationError {
  const ValidationError({
    required this.loc,
    required this.msg,
    required this.type,
  });

  factory ValidationError.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorFromJson(json);

  static const toJsonFactory = _$ValidationErrorToJson;
  Map<String, dynamic> toJson() => _$ValidationErrorToJson(this);

  @JsonKey(name: 'loc', defaultValue: <Object>[])
  final List<Object> loc;
  @JsonKey(name: 'msg')
  final String msg;
  @JsonKey(name: 'type')
  final String type;
  static const fromJsonFactory = _$ValidationErrorFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $ValidationErrorExtension on ValidationError {
  ValidationError copyWith({List<Object>? loc, String? msg, String? type}) {
    return ValidationError(
        loc: loc ?? this.loc, msg: msg ?? this.msg, type: type ?? this.type);
  }

  ValidationError copyWithWrapped(
      {Wrapped<List<Object>>? loc,
      Wrapped<String>? msg,
      Wrapped<String>? type}) {
    return ValidationError(
        loc: (loc != null ? loc.value : this.loc),
        msg: (msg != null ? msg.value : this.msg),
        type: (type != null ? type.value : this.type));
  }
}

@JsonSerializable(explicitToJson: true)
class Waypoint {
  const Waypoint({
    required this.lat,
    required this.lon,
    required this.time,
    this.baroaltitude,
  });

  factory Waypoint.fromJson(Map<String, dynamic> json) =>
      _$WaypointFromJson(json);

  static const toJsonFactory = _$WaypointToJson;
  Map<String, dynamic> toJson() => _$WaypointToJson(this);

  @JsonKey(name: 'lat')
  final double lat;
  @JsonKey(name: 'lon')
  final double lon;
  @JsonKey(name: 'time')
  final int time;
  @JsonKey(name: 'baroaltitude')
  final dynamic baroaltitude;
  static const fromJsonFactory = _$WaypointFromJson;

  @override
  String toString() => jsonEncode(this);
}

extension $WaypointExtension on Waypoint {
  Waypoint copyWith(
      {double? lat, double? lon, int? time, dynamic baroaltitude}) {
    return Waypoint(
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        time: time ?? this.time,
        baroaltitude: baroaltitude ?? this.baroaltitude);
  }

  Waypoint copyWithWrapped(
      {Wrapped<double>? lat,
      Wrapped<double>? lon,
      Wrapped<int>? time,
      Wrapped<dynamic>? baroaltitude}) {
    return Waypoint(
        lat: (lat != null ? lat.value : this.lat),
        lon: (lon != null ? lon.value : this.lon),
        time: (time != null ? time.value : this.time),
        baroaltitude:
            (baroaltitude != null ? baroaltitude.value : this.baroaltitude));
  }
}

String? operatorNullableToJson(enums.Operator? operator) {
  return operator?.value;
}

String? operatorToJson(enums.Operator operator) {
  return operator.value;
}

enums.Operator operatorFromJson(
  Object? operator, [
  enums.Operator? defaultValue,
]) {
  return enums.Operator.values.firstWhereOrNull((e) => e.value == operator) ??
      defaultValue ??
      enums.Operator.swaggerGeneratedUnknown;
}

enums.Operator? operatorNullableFromJson(
  Object? operator, [
  enums.Operator? defaultValue,
]) {
  if (operator == null) {
    return null;
  }
  return enums.Operator.values.firstWhereOrNull((e) => e.value == operator) ??
      defaultValue;
}

String operatorExplodedListToJson(List<enums.Operator>? operator) {
  return operator?.map((e) => e.value!).join(',') ?? '';
}

List<String> operatorListToJson(List<enums.Operator>? operator) {
  if (operator == null) {
    return [];
  }

  return operator.map((e) => e.value!).toList();
}

List<enums.Operator> operatorListFromJson(
  List? operator, [
  List<enums.Operator>? defaultValue,
]) {
  if (operator == null) {
    return defaultValue ?? [];
  }

  return operator.map((e) => operatorFromJson(e.toString())).toList();
}

List<enums.Operator>? operatorNullableListFromJson(
  List? operator, [
  List<enums.Operator>? defaultValue,
]) {
  if (operator == null) {
    return defaultValue;
  }

  return operator.map((e) => operatorFromJson(e.toString())).toList();
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
