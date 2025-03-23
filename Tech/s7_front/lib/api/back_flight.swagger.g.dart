// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'back_flight.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletionRequest _$CompletionRequestFromJson(Map<String, dynamic> json) =>
    CompletionRequest(
      prompt: json['prompt'] as String?,
      maxTokens: json['maxTokens'],
      poiId: (json['poi_id'] as num?)?.toInt(),
      icao24: json['icao24'],
      model: json['model'],
    );

Map<String, dynamic> _$CompletionRequestToJson(CompletionRequest instance) =>
    <String, dynamic>{
      'prompt': instance.prompt,
      'maxTokens': instance.maxTokens,
      'poi_id': instance.poiId,
      'icao24': instance.icao24,
      'model': instance.model,
    };

DetailedResponse _$DetailedResponseFromJson(Map<String, dynamic> json) =>
    DetailedResponse(
      icao24: json['icao24'] as String,
      count: json['count'],
      flightDuration: json['flightDuration'],
      flightDistance: json['flightDistance'],
      departurePlace: json['departurePlace'],
      arrivalPlace: json['arrivalPlace'],
      firstSeen: (json['first_seen'] as num).toInt(),
      lastSeen: (json['last_seen'] as num).toInt(),
      waypoints: (json['waypoints'] as List<dynamic>?)
              ?.map((e) => Waypoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DetailedResponseToJson(DetailedResponse instance) =>
    <String, dynamic>{
      'icao24': instance.icao24,
      'count': instance.count,
      'flightDuration': instance.flightDuration,
      'flightDistance': instance.flightDistance,
      'departurePlace': instance.departurePlace,
      'arrivalPlace': instance.arrivalPlace,
      'first_seen': instance.firstSeen,
      'last_seen': instance.lastSeen,
      'waypoints': instance.waypoints.map((e) => e.toJson()).toList(),
    };

FilterCondition _$FilterConditionFromJson(Map<String, dynamic> json) =>
    FilterCondition(
      key: json['key'] as String,
      $operator: json[r'$operator'],
      $value: json[r'$value'],
    );

Map<String, dynamic> _$FilterConditionToJson(FilterCondition instance) =>
    <String, dynamic>{
      'key': instance.key,
      r'$operator': instance.$operator,
      r'$value': instance.$value,
    };

FilterRequest _$FilterRequestFromJson(Map<String, dynamic> json) =>
    FilterRequest(
      distance: (json['distance'] as num?)?.toInt(),
      overpassFilters: (json['overpass_filters'] as List<dynamic>?)
              ?.map((e) => FilterCondition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$FilterRequestToJson(FilterRequest instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'overpass_filters':
          instance.overpassFilters?.map((e) => e.toJson()).toList(),
    };

FlightBase _$FlightBaseFromJson(Map<String, dynamic> json) => FlightBase(
      icao24: json['icao24'] as String,
      count: json['count'],
      flightDuration: json['flightDuration'],
      flightDistance: json['flightDistance'],
      departurePlace: json['departurePlace'],
      arrivalPlace: json['arrivalPlace'],
    );

Map<String, dynamic> _$FlightBaseToJson(FlightBase instance) =>
    <String, dynamic>{
      'icao24': instance.icao24,
      'count': instance.count,
      'flightDuration': instance.flightDuration,
      'flightDistance': instance.flightDistance,
      'departurePlace': instance.departurePlace,
      'arrivalPlace': instance.arrivalPlace,
    };

FlightPOIResponse _$FlightPOIResponseFromJson(Map<String, dynamic> json) =>
    FlightPOIResponse(
      aggregations: json['aggregations'] as Map<String, dynamic>,
      pois: (json['pois'] as List<dynamic>?)
              ?.map((e) => Poi.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$FlightPOIResponseToJson(FlightPOIResponse instance) =>
    <String, dynamic>{
      'aggregations': instance.aggregations,
      'pois': instance.pois.map((e) => e.toJson()).toList(),
    };

HTTPValidationError _$HTTPValidationErrorFromJson(Map<String, dynamic> json) =>
    HTTPValidationError(
      detail: (json['detail'] as List<dynamic>?)
              ?.map((e) => ValidationError.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$HTTPValidationErrorToJson(
        HTTPValidationError instance) =>
    <String, dynamic>{
      'detail': instance.detail?.map((e) => e.toJson()).toList(),
    };

Poi _$PoiFromJson(Map<String, dynamic> json) => Poi(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      type: json['type'] as String?,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      website: json['website'] as String?,
      lat: json['lat'],
      lon: json['lon'],
    );

Map<String, dynamic> _$PoiToJson(Poi instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'website': instance.website,
      'lat': instance.lat,
      'lon': instance.lon,
    };

PoiDetail _$PoiDetailFromJson(Map<String, dynamic> json) => PoiDetail(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      type: json['type'] as String?,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      website: json['website'] as String?,
      lat: json['lat'],
      lon: json['lon'],
      details: json['details'] as Object,
      tags: json['tags'] as Object,
      inception: json['inception'],
    );

Map<String, dynamic> _$PoiDetailToJson(PoiDetail instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'website': instance.website,
      'lat': instance.lat,
      'lon': instance.lon,
      'details': instance.details,
      'tags': instance.tags,
      'inception': instance.inception,
    };

PoiIdsRequest _$PoiIdsRequestFromJson(Map<String, dynamic> json) =>
    PoiIdsRequest(
      poiIds: (json['poi_ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
    );

Map<String, dynamic> _$PoiIdsRequestToJson(PoiIdsRequest instance) =>
    <String, dynamic>{
      'poi_ids': instance.poiIds,
    };

ValidationError _$ValidationErrorFromJson(Map<String, dynamic> json) =>
    ValidationError(
      loc: (json['loc'] as List<dynamic>?)?.map((e) => e as Object).toList() ??
          [],
      msg: json['msg'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$ValidationErrorToJson(ValidationError instance) =>
    <String, dynamic>{
      'loc': instance.loc,
      'msg': instance.msg,
      'type': instance.type,
    };

Waypoint _$WaypointFromJson(Map<String, dynamic> json) => Waypoint(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      time: (json['time'] as num).toInt(),
      baroaltitude: json['baroaltitude'],
    );

Map<String, dynamic> _$WaypointToJson(Waypoint instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'time': instance.time,
      'baroaltitude': instance.baroaltitude,
    };
