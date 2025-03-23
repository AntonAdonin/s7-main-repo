import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:s7_front/api/back_flight.swagger.dart';
import 'package:s7_front/data_provider/flights_provider.dart';
import 'package:s7_front/main_screens/landmarks/detailed_landmark.dart';

import '../../colors/colors.dart';
import '../../notifications/notification.dart';

// class PoiDot {
//   final int id;
//   final LatLng latLng;
//
//   const PoiDot({required this.id, required this.latLng});
// }

class RouteMapScreen extends StatefulWidget {
  final List<Waypoint> points;
  final List<Poi> landmarks;
  final FlightsProvider flightsProvider;
  final FlightBase flight;

  const RouteMapScreen({
    Key? key,
    required this.points,
    required this.flightsProvider,
    required this.flight,
    this.landmarks = const [],
  }) : super(key: key);

  @override
  RouteMapScreenState createState() => RouteMapScreenState();
}

class RouteMapScreenState extends State<RouteMapScreen> {
  late final MapController _mapController;
  double _currentZoom = 13.0; // Начальный зум

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    // Следим за изменением масштаба
    _mapController.mapEventStream.listen((event) {
      if (event is MapEventMove) {
        setState(() {
          _currentZoom = _mapController.camera.zoom;
        });
      }
    });
  }

  LatLng toLatLng(Waypoint point) => LatLng(point.lat ?? 0, point.lon ?? 0);

  List<LatLng> toLatLngList(List<Waypoint> points) => points.map(toLatLng).toList();

  List<Waypoint> get points => widget.points;

  List<Poi> get landmarks => widget.landmarks;

  FlightsProvider get flightsProvider => widget.flightsProvider;

  LatLng get firstPoint => toLatLng(points.first);

  LatLng get lastPoint => toLatLng(points.last);

  Future<PoiDetail?> getDetailed(context, int landmarkId) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator(color: S7Color.bitterLemon.value));
      },
    );

    PoiDetail? res;
    try {
      res = await flightsProvider.getDetailedLandmark(landmarkId);
    } catch (e) {
      print(e.toString());
      if (!context.mounted) return res;
      Navigator.pop(context);
      showError(context, "something went wrong");
    }

    if (!context.mounted) return res;
    Navigator.pop(context);
    return res;
  }

  double calculateClusterSize(double zoom) {
    double A = 288.26;
    double B = 22.86;
    double C = -10.74;

    return A / (B + exp(C * zoom));
  }

  List<Marker> getFilteredLandmarksMarkers() {
    LatLngBounds? bounds;
    try {
      bounds = _mapController.camera.visibleBounds;
    } catch (e) {
      print(e);
    }

    if (landmarks.isEmpty) return [];
    double clusterSize = 70;
    if (_currentZoom > 13) {
      clusterSize = 0.1;
    } else if (_currentZoom > 12) {
      clusterSize = 0.7;
    } else if (_currentZoom > 11) {
      clusterSize = 2;
    } else if (_currentZoom > 10) {
      clusterSize = 3;
    } else if (_currentZoom > 9) {
      clusterSize = 4;
    } else if (_currentZoom > 8) {
      clusterSize = 4.5;
    } else if (_currentZoom > 7) {
      clusterSize = 11;
    } else if (_currentZoom > 6) {
      clusterSize = 15;
    } else if (_currentZoom > 5) {
      clusterSize = 30;
    } else if (_currentZoom > 4) {
      clusterSize = 60;
    }

    List<Marker> filteredMarkers = [];
    List<LatLng> clusteredPoints = [];

    for (var l in landmarks) {
      if (l.lat == null || l.lon == null) continue;

      LatLng point = LatLng(l.lat, l.lon);
      if (bounds != null && !bounds.contains(point)) continue;

      // Оставляем только один маркер из кластера
      bool isTooClose = clusteredPoints.any((p) => isNearby(p, point, clusterSize));
      if (isTooClose) continue; // На маленьком зуме показываем только один маркер

      clusteredPoints.add(point);
      double size = calculateMarkerSize(_currentZoom);

      filteredMarkers.add(
        Marker(
          point: point,
          height: size,
          width: size,
          child: InkWell(
            child: imgWithName(l, size - 10),
            onTap: () async {
              if (l.id == null) return;
              PoiDetail? detailed = await getDetailed(context, l.id!);
              if (detailed == null || !context.mounted) return;

              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder:
                      (context) =>
                          DetailedLandmarkScreen(landmark: l, detailed: detailed, icao24: widget.flight.icao24),
                ),
              );
            },
          ),
        ),
      );
    }

    return filteredMarkers;
  }

  bool isNearby(LatLng a, LatLng b, double threshold) {
    return distanceBetween(a, b) <= threshold;
  }

  // Функция для вычисления расстояния между точками (грубая оценка)
  double distanceBetween(LatLng a, LatLng b) {
    const double earthRadius = 6371; // Радиус Земли в километрах
    double dLat = (b.latitude - a.latitude) * pi / 180;
    double dLon = (b.longitude - a.longitude) * pi / 180;
    double lat1 = a.latitude * pi / 180;
    double lat2 = b.latitude * pi / 180;

    double aFormula = sin(dLat / 2) * sin(dLat / 2) + sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
    double c = 2 * atan2(sqrt(aFormula), sqrt(1 - aFormula));
    return earthRadius * c; // Расстояние в километрах
  }

  double calculateMarkerSize(double zoom) {
    double baseSize = 40; // Минимальный размер
    double maxSize = 200; // Максимальный размер
    double z0 = 16.5; // Центр быстрого роста
    double k = 1.2; // Степень сглаженности (чем выше, тем резче)

    // Сигмоидная функция для плавного увеличения
    double scale = 1 / (1 + exp(-k * (zoom - z0)));

    // Интерполяция между baseSize и maxSize
    double size = baseSize + (maxSize - baseSize) * scale;

    return size;
  }

  List<Marker> getLandmarksMarkers(context) {
    List<Marker> res = [];
    for (var l in widget.landmarks) {
      if (l.lat != null && l.lon != null) {
        double size = calculateMarkerSize(_currentZoom);

        res.add(
          Marker(
            point: LatLng(l.lat, l.lon),
            height: size,
            width: size,
            child: InkWell(
              child: imgWithName(l, size - 10),
              onTap: () async {
                if (l.id == null) return;
                PoiDetail? detailed = await getDetailed(context, l.id!);
                if (detailed == null || !context.mounted) return;

                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder:
                        (context) =>
                            DetailedLandmarkScreen(landmark: l, detailed: detailed, icao24: widget.flight.icao24),
                  ),
                );
              },
            ),
          ),
        );
      }
    }
    return res;
  }

  Widget imgWithName(Poi p, double size) {
    final imgSize = size * 0.8;
    final textSize = size - imgSize;
    return SizedBox(
      height: size,
      width: size,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: textSize,
              width: size,
              child: Center(
                child: Text(
                  p.name ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: textSize / 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                errorWidget: (context, _, __) => Icon(Icons.pin_drop_rounded, color: S7Color.bitterLemon.value),
                placeholder: (context, url) => Icon(Icons.pin_drop_rounded, color: S7Color.bitterLemon.value),
                imageUrl: p.imageUrl ?? "",
                fit: BoxFit.cover,
                height: imgSize,
                width: size,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Route Map")),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: widget.points.isNotEmpty ? toLatLng(widget.points.first) : LatLng(0, 0),
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: ['a', 'b', 'c']),
          PolylineLayer(
            polylines: [
              Polyline(
                points: toLatLngList(widget.points),
                strokeCap: StrokeCap.round,
                strokeWidth: 4.0,
                color: S7Color.bitterLemon.value,
              ),
            ],
          ),
          MarkerLayer(markers: getFilteredLandmarksMarkers()),
        ],
      ),
    );
  }
}
