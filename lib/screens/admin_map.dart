import 'package:flutter/material.dart';
import 'package:flutter_map_bus/secret.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Maps extends StatefulWidget {
  Map travelers;
  Maps(this.travelers);

  @override
  _MapsState createState() => _MapsState();
}

double _originLatitude = 40.765597;
double _originLongitude = 29.940497;
double _destLatitude = 40.824251;
double _destLongitude =  29.920340;


class _MapsState extends State<Maps> {
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  MapType _currentMapType = MapType.normal;
  late GoogleMapController _controller;
  List<Point> centerList = <Point>[];

  static final CameraPosition _initalCameraPosition = CameraPosition(
    target: LatLng(_originLatitude, _originLongitude),
    zoom: 15,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPolyline();

    eliminateNulls();
    int i = 0;
    print("AAAAA");
    // print(centerList.length);
    // while(i<centerList.length) {
    //   createPoly(centerList[i]);
    //   i+=1;
    // }
    List<LatLng> polyList = [];
    while(i<centerList.length) {

      _getRoutePolyline(start: LatLng(centerList[0].lat, centerList[0].lng), finish: LatLng(0.824237, 29.920334), color: Colors.blue, id: i.toString());
      polyList.add(LatLng(centerList[0].lat, centerList[0].lng));
      i+=1;
    }
    polySel(polyList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("ADMIN MAP"),
        backgroundColor: Colors.indigo.withOpacity(0.75),
      ),
      body: GoogleMap(
        polylines: Set<Polyline>.of(polylines.values),
        markers: _cretaeMarker(),
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: _initalCameraPosition,

        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }

  Set<Marker> _cretaeMarker() {
    return <Marker>[
      Marker(
          infoWindow: InfoWindow(title: "Kordon Alsancak"),
          markerId: MarkerId("asdasd"),
          position: _initalCameraPosition.target,
          icon:
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan)),
      Marker(
          infoWindow: InfoWindow(title: "umuttepe"),
          markerId: MarkerId("asdsasdd"),
          position: LatLng(40.824237, 29.920334),
          icon:
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)),
    ].toSet();
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  goToLoc() {
    _controller
        .animateCamera(CameraUpdate.newLatLng(LatLng(38.392300, 27.047840)));
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCqjIdKswrkD3NL1KpoL-aLOacSc9VR_rM",
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print("Hata");
    }
    _addPolyLine(polylineCoordinates);
  }

  void createPoly(Point point) async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCqjIdKswrkD3NL1KpoL-aLOacSc9VR_rM",
      PointLatLng(point.lat, point.lng),
      const PointLatLng(40.824320, 29.920494),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print("Hata");
    }
    _addPolyLine(polylineCoordinates);
  }


  void eliminateNulls(){
    if(widget.travelers["Başiskele"] != 0){
      centerList.add(Point(40.714234, 29.933808));
    }
    if(widget.travelers["Çayırova"] != 0){
      centerList.add(Point(40.824038, 29.372184));
    }
    if(widget.travelers["Darıca"] != 0){
      centerList.add(Point(40.773599, 29.400671));
    }
    if(widget.travelers["Derince"] != 0){
      centerList.add(Point(40.756213, 29.831035));
    }
    if(widget.travelers["Dilovası"] != 0){
      centerList.add(Point(40.787599, 29.544157));
    }
    if(widget.travelers["Gebze"] != 0){
      centerList.add(Point(40.802589, 29.439905));
    }
    if(widget.travelers["Gölcük"] != 0){
      centerList.add(Point(40.716961, 29.817171));
    }
    if(widget.travelers["Kandıra"] != 0){
      centerList.add(Point(41.070417, 30.152257));
    }
    if(widget.travelers["Karamürsel"] != 0){
      centerList.add(Point(40.691425, 29.616438));
    }
    if(widget.travelers["Kartepe"] != 0){
      centerList.add(Point(40.753595, 30.023277));
    }
    if(widget.travelers["Körfez"] != 0){
      centerList.add(Point(40.776415, 29.737443));
    }
    if(widget.travelers["İzmit"] != 0){
      centerList.add(Point(40.765549, 29.940509));
    }

  }

  polySel(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.pink,
      points: polylineCoordinates,
      width: 8,
    );
    polylines.addAll({id: polyline});
    polylines[id] = polyline;
    setState(() {});
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.pink,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }
  Future<Polyline> _getRoutePolyline(
      {required LatLng start,
        required LatLng finish,
        required Color color,
        required String id,
        int width = 6}) async {
    // Generates every polyline between start and finish
    final polylinePoints = PolylinePoints();
    // Holds each polyline coordinate as Lat and Lng pairs
    final List<LatLng> polylineCoordinates = [];

    final startPoint = PointLatLng(start.latitude, start.longitude);
    final finishPoint = PointLatLng(finish.latitude, finish.longitude);

    final result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY,
      startPoint,
      finishPoint,
    );
    if (result.points.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      });
    }
    final polyline = Polyline(
      polylineId: PolylineId(id),
      color: color,
      points: polylineCoordinates,
      width: width,
    );
    polylines[PolylineId(id)] = polyline;
    return polyline;
  }
}

class Point{
  late double lat;
  late double lng;
  Point(this.lat, this.lng);
}