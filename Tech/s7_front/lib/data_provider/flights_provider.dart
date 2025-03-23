import 'package:s7_front/unsplash_api/unsplash.dart';

import '../api/back_flight.swagger.dart';
import '../business_objects/flight.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";

class FlightsProvider {
  static String apiUrl = dotenv.env["API_URL"]!;

  //final localStorage = FlightsStorage();
  final apiInstance = BackFlight.create(baseUrl: Uri.parse(apiUrl));

  FlightsProvider() {
    //localStorage.init();
  }

  Future<String> resolveImage(String city) async {
    return await UnsplashApi.fetchCityPhoto(city);
  }

  Future<List<Poi>> getPoi(String icao24) async {
    FilterRequest body = FilterRequest(distance: 1000, overpassFilters: [FilterCondition(key: "place")]);
    final res = await apiInstance.poiFlightIcao24PoisPost(icao24: icao24, body: body);
    if (res.statusCode == 200 && res.body != null) {
      print(res.body!.pois);
      return res.body!.pois;
    } else {
      return [];
    }
  }

  Future<String> getSummarization(String icao24, int poiId) async {
    final res = await apiInstance.poiSummarizePost(
      body: CompletionRequest(prompt: "stre", model: "deepseek/deepseek-r1-zero:free", icao24: icao24, poiId: poiId),
    );
    return res.body;
    // final responseStream = res.body as Stream; // Получаем поток данных
    // responseStream.listen(
    //   (chunk) {
    //     print('Received chunk: $chunk');
    //   },
    //   onDone: () {
    //     print('Stream completed');
    //   },
    //   onError: (error) {
    //     print('Error: $error');
    //   },
    // );
  }

  Future<PoiDetail> getDetailedLandmark(int landmarkId) async {
    // return PoiDetail(
    //   id: landmarkId,
    //   name: "Davis Junction",
    //   tags: {
    //     "ele": "241",
    //     "gnis:feature_id": "406979",
    //     "name": "Davis Junction",
    //     "place": "village",
    //     "population": "1408",
    //     "population:date": "2006",
    //     "source:population": "US Census",
    //     "wikidata": "Q2459360",
    //     "wikipedia": "en:Davis Junction, Illinois",
    //   },
    //   details: {}, summarization: 'summarization',
    // );

    PoiIdsRequest body = PoiIdsRequest(poiIds: [landmarkId]);
    final res = await apiInstance.poiPoisDetailsPost(body: body);
    if (res.body != null) {
      final data = res.body! as Map<String, dynamic>;
      final item = data[landmarkId.toString()];
      if (item != null) {
        return PoiDetail.fromJson(item);
      } else {
        throw Exception("Not Found");
      }
    } else {
      throw Exception("Not Found");
    }
  }

  Future<List<Waypoint>> getWayPoints(String icao24) async {
    final res = await apiInstance.flightsIcao24DetailsGet(icao24: icao24);
    if (res.statusCode == 200 && res.body != null) {
      final items = res.body!.waypoints;
      return items;
    } else {
      return [];
    }
  }

  Future<List<FlightBase>> getFlights() async {
    // final url = await resolveImage("Moscow");
    // print(url);
    // return [FlightBase(icao24: "test", arrivalPlace: "Paris", departurePlace: "London")];
    final res = await apiInstance.flightsGet(
      order: -1,
      //sortBy: "count",
      //sortBy: "icao24"
      sortBy: "flightDuration",
    );
    print(res);
    if (res.body != null) {
      print(res.body!);
      return res.body!;
    } else {
      return [];
    }
    List<Future<String>> tasks = [
      resolveImage("Paris"),
      resolveImage("Moscow"),
      resolveImage("New-York"),
      //resolveImage("Novosibirsk"),
      //resolveImage("Dublin"),
    ];
    Map<String, String> urls = {};
    await Future.wait(tasks).then(
      (values) => {
        for (int i = 0; i < values.length; i++)
          {
            urls["Paris"] = values[0],
            urls["Moscow"] = values[1],
            urls["New-York"] = values[2],
            //urls["Novosibirsk"] = values[3],
            //urls["Dublin"] = values[4],
          },
      },
    );

    // List<Flight> flights = [
    //   Flight(
    //     flightDate: DateTime(2025, 1, 2, 10, 20),
    //     ico24: "AS209",
    //     destination: "Paris",
    //     path: Path([]),
    //     imageUrl: urls["Paris"],
    //   ),
    //   Flight(
    //     flightDate: DateTime(2025, 10, 3, 23, 5),
    //     ico24: "NF234",
    //     destination: "Moscow",
    //     path: Path([]),
    //     imageUrl: urls["Moscow"],
    //   ),
    //   Flight(
    //     flightDate: DateTime(2025, 3, 2, 6, 40),
    //     ico24: "LO543",
    //     destination: "New-York",
    //     path: Path([]),
    //     imageUrl: urls["New-York"],
    //   ),
    //   // Flight(
    //   //   flightDate: DateTime(2024, 1, 2, 15, 20),
    //   //   ico24: "SD423",
    //   //   destination: "Dublin",
    //   //   path: Path([]),
    //   //   imageUrl: urls["Dublin"],
    //   // ),
    //   // Flight(
    //   //   flightDate: DateTime(2025, 1, 4, 6, 40),
    //   //   ico24: "LK421",
    //   //   destination: "Novosibirsk",
    //   //   path: Path([]),
    //   //   imageUrl: urls["Novosibirsk"],
    //   // ),
    // ];
    //
    // flights.sort((f1, f2) => -f1.flightDate.compareTo(f2.flightDate));
    //
    // //return localStorage.getFlights();
  }

  // Future<void> addFlight(Flight flight) async {
  //   await localStorage.addFlight(flight);
  // }

  Future<Flight?> getFlight(String ico24) async {
    final parisImg = await resolveImage("London");

    final flight = Flight(
      flightDate: DateTime(2025, 10, 8),
      ico24: ico24,
      path: Path([]),
      destination: "London",
      imageUrl: parisImg,
    );
    //
    // Flight? flight = await  localStorage.getFlight(ico24);
    // if (flight == null) {
    //   flight = FlightsApi().getFlight(ico24);
    //   if (flight != null) {
    //     localStorage.addFlight(flight);
    //   }
    // }
    // return flight;

    return Future.delayed(Duration(milliseconds: 200), () => flight);
  }
}
