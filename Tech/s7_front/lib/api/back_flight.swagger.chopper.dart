// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'back_flight.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$BackFlight extends BackFlight {
  _$BackFlight([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = BackFlight;

  @override
  Future<Response<FlightPOIResponse>> _poiFlightIcao24PoisPost({
    required String? icao24,
    required FilterRequest? body,
  }) {
    final Uri $url = Uri.parse('/poi/flight/${icao24}/pois');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<FlightPOIResponse, FlightPOIResponse>($request);
  }

  @override
  Future<Response<Object>> _poiPoisDetailsPost({required PoiIdsRequest? body}) {
    final Uri $url = Uri.parse('/poi/pois/details');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Object, Object>($request);
  }

  @override
  Future<Response<dynamic>> _poiSummarizePost(
      {required CompletionRequest? body}) {
    final Uri $url = Uri.parse('/poi/summarize');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<FlightBase>>> _flightsGet({
    int? page,
    int? limit,
    String? sortBy,
    int? order,
  }) {
    final Uri $url = Uri.parse('/flights/');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
      'sort_by': sortBy,
      'order': order,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<FlightBase>, FlightBase>($request);
  }

  @override
  Future<Response<DetailedResponse>> _flightsIcao24DetailsGet(
      {required String? icao24}) {
    final Uri $url = Uri.parse('/flights/${icao24}/details');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<DetailedResponse, DetailedResponse>($request);
  }
}
