import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geocoding/geocoding.dart';
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
  MapController? controller;
  GeoPoint? startPoint;
  GeoPoint? endPoint;

  final TextEditingController _start = TextEditingController();
  // final TextEditingController _end = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller = MapController.withUserPosition(
        trackUserLocation: const UserTrackingOption(
          enableTracking: true,
          unFollowUser: false,
        ),
      );
      // Future.delayed(const Duration(seconds: 2)).then((_) async {
      //   if (controller != null) {
      //     var loc = await controller!.osmBaseController.myLocation();

      //     _start.text = await getAddress(
      //       loc.latitude,
      //       loc.longitude,
      //     );
      //   }
      // });

      setState(() {});
    });
    super.initState();
  }

  Future<String> getAddress(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    Placemark place = placemarks[0];
    return "${place.street}, ${place.locality}";
  }

  showStartLocation(String loc, [bool clear = true]) async {
    try {
      debugPrint("showStartLocation");

      var locations = await addressSuggestion(loc);
      if (locations.isNotEmpty) {
        // if (startPoint != null && clear) {
        //   debugPrint("b4 changing start marker");

        //   // await controller!.changeMarker(
        //   //   oldLocation: startPoint!,
        //   //   newLocation: locations.first.point!,
        //   // );
        // } else {
          debugPrint("b4 adding start marker");

          startPoint = locations.first.point!;

        await controller!.osmBaseController.addMarker(startPoint!);
        }

        // controller!.osmBaseController.
        // controller!.osmBaseController.changeLocation(startPoint!);
        setState(() {});
        // drawRoute(GeoPoint(latitude: 48.8588443, longitude: 2.2943506), point);
      // }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  showEndLocation(String loc) async {
    debugPrint("showEndLocation");

    try {
      var locations = await addressSuggestion(loc);
      if (locations.isNotEmpty) {
        if (endPoint != null) {
          debugPrint("b4 changing end marker");

          controller!.osmBaseController.changeMarker(
            oldLocation: endPoint!,
            newLocation: locations.first.point!,
          );
          setState(() {});
        } else {
          debugPrint("b4 adding end marker");

          endPoint = locations.first.point!;

          controller!.osmBaseController.addMarker(endPoint!);
        }
      }

      drawRoute(startPoint!, endPoint!);
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void drawRoute(GeoPoint startPoint, GeoPoint endPoint) async {
    try {
      await controller!.osmBaseController.drawRoad(
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

  List<StaticPositionGeoPoint> staticPoints = [];

  bool showExpandedSheet = false;

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
                                showStartLocation(value);
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
                              keyboardType: TextInputType.streetAddress,
                              onFieldSubmitted: (value) {
                                showEndLocation(value);
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
                    var loc = await controller!.osmBaseController.myLocation();

                    _start.text = await getAddress(
                      loc.latitude,
                      loc.longitude,
                    );
                    showStartLocation(_start.text, false);
                    setState(() {});
                  },
                  child: const WhereWouldGoContainer(),
                ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: controller == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: OSMFlutter(
                    mapIsLoading:
                        const Center(child: CircularProgressIndicator()),
                    controller: controller!,
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
