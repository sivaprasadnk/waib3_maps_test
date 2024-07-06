import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:machine_test/screens/home/bottom_nav_bar.dart';
import 'package:machine_test/screens/home/bottom_sheet_container.dart';
import 'package:machine_test/screens/home/custom_divider.dart';
import 'package:machine_test/screens/home/home_drawer.dart';
import 'package:machine_test/screens/home/textfield_container.dart';
import 'package:machine_test/screens/home/where_would_go_container.dart';
import 'package:machine_test/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  MapController? mapController = MapController.withUserPosition(
        trackUserLocation: const UserTrackingOption(
          enableTracking: true,
          unFollowUser: false,
        ),
  );

  final TextEditingController _start = TextEditingController();
  final TextEditingController _end = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {});
    });
    super.initState();
  }

  

  
  showLocation() async {

    debugPrint("showEndLocation");

    try {
      var startLocations = await addressSuggestion(_start.text);
      var startPoint = startLocations.first.point!;

      var endLocations = await addressSuggestion(_end.text);
      var endPoint = endLocations.first.point!;

      drawRoute(startPoint, endPoint);
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool showExpandedSheet = false;

  void drawRoute(GeoPoint startPoint, GeoPoint endPoint) async {
    try {
      await mapController!.drawRoad(
        startPoint,
        endPoint,
        roadType: RoadType.car,
        roadOption: const RoadOption(
          roadWidth: 10,
          roadColor: Colors.blue,
          // showMarkerOfPOI: false,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const HomeDrawer(),
      bottomSheet: BottomSheetContainer(
        isExpanded: showExpandedSheet,
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: showExpandedSheet
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const CustomDivider(),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextfieldContainer(
                            child: TextFormField(
                              controller: _start,
                              onFieldSubmitted: (value) {
                                showLocation();
                              },
                              keyboardType: TextInputType.streetAddress,
                              decoration: const InputDecoration(
                                hintText: '58 Hullbrook Road, Billesley, B13',
                                hintStyle: TextStyle(
                                  color: kGrey2Color,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextfieldContainer(
                            child: TextFormField(
                              controller: _end,
                              keyboardType: TextInputType.streetAddress,
                              onFieldSubmitted: (value) {
                                showLocation();
                              },
                              decoration: const InputDecoration(
                                hintText: '67, Grand Central Pkwy, Newyork',
                                hintStyle: TextStyle(
                                  color: kGrey2Color,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: () async {
                    setState(() {
                      showExpandedSheet = true;
                    });
                    setState(() {});
                  },
                  child: const WhereWouldGoContainer(),
                ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: OSMFlutter(
              mapIsLoading: const Center(child: CircularProgressIndicator()),
              controller: mapController!,
              osmOption: OSMOption(
                showZoomController: true,
                userTrackingOption: const UserTrackingOption(
                  enableTracking: true,
                  unFollowUser: true,
                ),
                zoomOption: const ZoomOption(
                  initZoom: 17,
                  minZoomLevel: 13,
                  maxZoomLevel: 19,
                  stepZoom: 1.0,
                ),
                userLocationMarker: UserLocationMaker(
                  personMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 55,
                    ),
                  ),
                  directionArrowMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.double_arrow,
                      size: 48,
                    ),
                  ),
                ),
                roadConfiguration: const RoadOption(
                  roadColor: Colors.yellowAccent,
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 500,
          //   width: 400,
          //   child: FlutterMap(
          //     mapController: mapController,
          //     options: const MapOptions(
          //         // initialCenter: routpoints[0],
          //         // zoom: 10,
          //         ),
          //     // nonRotatedChildren: [
          //     //   AttributionWidget.defaultWidget(source: 'OpenStreetMap contributors',
          //     //   onSourceTapped: null),
          //     // ],
          //     children: [
          //       TileLayer(
          //         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          //         userAgentPackageName: 'com.example.machine_test',
          //       ),
          //       MarkerLayer(markers: [
          //         Marker(
          //           point: routpoints.first,
          //           child: const Icon(Icons.location_pin),
          //         ),
          //         Marker(
          //           point: routpoints.last,
          //           child: const Icon(Icons.location_pin),
          //         )
          //       ]),
          //       PolylineLayer(
          //         // polylineCulling: false,
          //         polylines: [
          //           Polyline(
          //             points: routpoints,
          //             color: Colors.blue,
          //             strokeWidth: 9,
          //           )
          //         ],
          //       )
          //     ],
          //   ),
          // ),
          Positioned.fill(
            left: 30,
            top: 50,
            child: Align(
              alignment: Alignment.topLeft,
              child: Builder(builder: (context) {
                return GestureDetector(
                  onTap: () {
                    _key.currentState!.openDrawer();
                    // Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: kBlackColor,
                      ),
                    ),
                    child: const Icon(
                      Icons.menu,
                      size: 20,
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
