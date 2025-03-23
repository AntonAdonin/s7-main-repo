import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:s7_front/colors/colors.dart';
import 'package:s7_front/data_provider/flights_provider.dart';
import 'package:s7_front/data_provider/landmarks_provider.dart';
import 'package:s7_front/main_screens/landmarks/detailed_landmark.dart';
import 'package:s7_front/main_screens/landmarks/landmark_list.dart';
import 'package:s7_front/main_screens/map/map.dart';
import 'package:s7_front/notifications/notification.dart';

import '../../api/back_flight.swagger.dart';

class LandmarksScreen extends StatefulWidget {
  final FlightBase flight;

  const LandmarksScreen({super.key, required this.flight});

  @override
  _LandmarksScreenState createState() => _LandmarksScreenState();
}

class _LandmarksScreenState extends State<LandmarksScreen> {
  List<Poi> landmarks = [];
  FlightsProvider flightsProvider = FlightsProvider();
  LandmarksProvider landmarksProvider = LandmarksProvider();
  late Future<List<Poi>> futureLandmarks;
  bool ready = true;

  @override
  void initState() {
    super.initState();
    updateLandmarks();
  }

  void updateLandmarks() {
    setState(() {
      futureLandmarks = flightsProvider.getPoi(widget.flight.icao24);
      futureLandmarks.then((val) {
        setState(() {
          landmarks = val;
        });
      });
    });
  }

  Future<void> openMap() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator(color: S7Color.bitterLemon.value));
      },
    );

    List<Waypoint>? res;
    try {
      res = await flightsProvider.getWayPoints(widget.flight.icao24);
      if (res.isEmpty) {
        throw Exception("No waypoints found");
      }
    } catch (e) {
      log(e.toString());
      if (!context.mounted) return;
      Navigator.pop(context);
      showError(context, "something went wrong");
      return;
    }

    if (!context.mounted) return;
    Navigator.pop(context);
    print(landmarks);
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder:
            (context) => RouteMapScreen(
              points: res!,
              flightsProvider: flightsProvider,
              landmarks: landmarks,
              flight: widget.flight,
            ),
      ),
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(milliseconds: 300));
    updateLandmarks();
  }

  Widget listFutureBuilder(context) {
    return FutureBuilder<List<Poi>>(
      future: futureLandmarks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: S7Color.bitterLemon.value));
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        return LandmarkList(
          landmarks: landmarks,
          onTap: (Poi l) async {
            final detailed = await _getDetailed(context, l.id!);
            if (!context.mounted || detailed == null) return;
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder:
                    (context) => DetailedLandmarkScreen(landmark: l, detailed: detailed, icao24: widget.flight.icao24),
              ),
            );
          },
        );
      },
    );
  }

  Future<PoiDetail?> _getDetailed(context, int landmarkId) async {
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
      log(e.toString());
      if (!context.mounted) return res;
      Navigator.pop(context);
      showError(context, "something went wrong");
    }

    if (!context.mounted) return res;
    Navigator.pop(context);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Landmarks"),
        actions: ready ? [
          Padding(
            padding: EdgeInsets.all(10),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: S7Color.sonicSilver.value),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: openMap,
              child: Text("open map", style: TextStyle(color: S7Color.sonicSilver.value)),
            ),
          ),
        ] : [],
        backgroundColor: S7Color.bitterLemon.value,
      ),
      backgroundColor: S7Color.sonicSilver.value,

      body: RefreshIndicator(onRefresh: _refreshData, child: listFutureBuilder(context)),
    );
  }
}
