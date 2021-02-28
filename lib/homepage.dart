import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_parking/widgets/divider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_parking/parking_expense/parking_expenses.dart';
import 'package:maps_parking/screens/about.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/parking_show';
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController newGoogleMapController;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Position currentPosition;

  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  void locatePosition() async
  {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = new CameraPosition(
        target: latLngPosition, zoom: 14);
    newGoogleMapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition));
  }




  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  void initState() {
    super.initState();
  }
  double zoomVal=5.0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title:Text("Parking"),
      ),
      drawer: Container(
        color:Colors.white,
        width: 255,
        child: Drawer(
          child:ListView(
            children: [
              Container(
                height: 165,
                child: DrawerHeader(
                  decoration: BoxDecoration(color:Colors.white),
                  child: Row(
                    children: [
                      Image.asset("assets/images/user_icon.png", height:65,width: 65,),
                      SizedBox(height:16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Profile Name", style: TextStyle(fontSize: 16,fontFamily: "Brand-Bold"),),
                          SizedBox(height: 6,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),


              DividerWidget(),

              SizedBox(height:12),
              FlatButton(
                onPressed: () => {

                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PersonalExpenses())
                )
                },
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_circle_outline_outlined),
                    SizedBox(width: 10,),
                    Text("Parking Expenses")
                  ],
                ),
              ),


              FlatButton(
                onPressed: () => {

                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => About())
                  )
                },
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.info),
                    SizedBox(width: 10,),
                    Text("About")
                  ],
                ),
              ),

            ],
          ),

        ),
      ),


      body: Stack(
        children: <Widget>[


           _buildGoogleMap(context),
           _zoomminusfunction(),
           _zoomplusfunction(),
           _buildContainer(),
        ],




      ),







    );
  }

  Widget _zoomminusfunction() {

    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchMinus,color:Color(0xff6200ee)),
          onPressed: () {
            zoomVal--;
            _minus( zoomVal);
          }),
    );
  }
  Widget _zoomplusfunction() {

    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus,color:Color(0xff6200ee)),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(27.672355,85.314725), zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(27.672355,85.314725), zoom: zoomVal)));
  }


  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://epropertynepal.com/system/photos/12040/original_eProperty_nepal_%284%29.jpg?1584854151",
                  27.672355, 85.314725,"Kumaripati area "),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.autoncell.com/image/news-1559645280615-b46d7.jpg",
                  27.702170, 85.309787,"New road area "),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://nepalspace.com/wp-content/uploads/2020/09/19-1-1740x960-c-center.jpg",
                27.694163, 85.319897,"Maitighar area ",),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat,double long,String restaurantName) {
    return  GestureDetector(
      onTap: () {
        _gotoLocation(lat,long);
      },
      child:Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(restaurantName),
                    ),
                  ),

                ],)
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(restaurantName,
                style: TextStyle(
                    color: Color(0xff6200ee),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height:5.0),

        SizedBox(height:5.0),
        Container(
            child: Text(
              "Parking fee : Rs25/per hour ",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "Always Open ",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  // SizedBox(height:10)
  Widget _buildGoogleMap(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 0.0, top: 20.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        padding:EdgeInsets.only(bottom: bottomPaddingOfMap),
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        initialCameraPosition:  CameraPosition(target: LatLng(27.672355,85.314725), zoom: 12),



          onMapCreated:(GoogleMapController controller)
          {
            _controller.complete(controller);


            setState(() {
              bottomPaddingOfMap=265.0;
            });
            locatePosition();
          },

        markers: {
          newyork4Marker,newyork5Marker,newyork6Marker,newyork7Marker,newyork8Marker
          ,newyork9Marker,newyork10Marker,newyork11Marker,newyork12Marker,newyork13Marker,newyork14Marker
          ,newyork15Marker,gramercyMarker,bernardinMarker,blueMarker
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }
}

Marker gramercyMarker = Marker(
  markerId: MarkerId('gramercy'),
  position: LatLng(27.672355, 85.314725),
  infoWindow: InfoWindow(title: 'Kumaripati area '),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker bernardinMarker = Marker(
  markerId: MarkerId('bernardin'),
  position: LatLng(27.702170, 85.309787),
  infoWindow: InfoWindow(title: 'Le Bernardin'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker blueMarker = Marker(
  markerId: MarkerId('bluehill'),
  position: LatLng(27.694163, 85.319897),
  infoWindow: InfoWindow(title: 'Blue Hill'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

//New York Marker


Marker newyork4Marker = Marker(
  markerId: MarkerId('newyork4'),
  position: LatLng(27.633859, 85.349671),
  infoWindow: InfoWindow(title: 'lakhur futsal'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);


Marker newyork5Marker = Marker(
  markerId: MarkerId('newyork4'),
  position: LatLng(27.672355, 85.314725),
  infoWindow: InfoWindow(title: 'Near Prabhu Bank '),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);


Marker newyork6Marker = Marker(
  markerId: MarkerId('newyork4'),
  position: LatLng(27.672204, 85.315520),
  infoWindow: InfoWindow(title: 'Near Travel Expert'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);


Marker newyork7Marker = Marker(
  markerId: MarkerId('newyork4'),
  position: LatLng(27.672054, 85.316327),
  infoWindow: InfoWindow(title: 'Near Citywalk Creation '),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);


Marker newyork8Marker = Marker(
  markerId: MarkerId('newyork4'),
  position: LatLng(27.671848, 85.317634),
  infoWindow: InfoWindow(title: 'Near kocos international'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);


Marker newyork9Marker = Marker(
  markerId: MarkerId('newyork4'),
  position: LatLng(27.671473, 85.318792),
  infoWindow: InfoWindow(title: 'Near Ncell Center'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);


Marker newyork10Marker = Marker(
  markerId: MarkerId('newyork4'),
  position: LatLng(27.670789, 85.320214),
  infoWindow: InfoWindow(title: 'Near Nmb Bank'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);


Marker newyork11Marker = Marker(
  markerId: MarkerId('newyork4'),
  position: LatLng(27.702170, 85.309787),
  infoWindow: InfoWindow(title: 'Near Tamrabank Complex'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker newyork12Marker = Marker(
  markerId: MarkerId('newyork4'),
  position: LatLng(27.702894, 85.310055),
  infoWindow: InfoWindow(title: 'Near Shrestha Trade and Repair center '),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);


Marker newyork13Marker = Marker(
  markerId: MarkerId('newyork4'),
  position: LatLng(27.703057, 85.309033),
  infoWindow: InfoWindow(title: 'Near Siddhartha Bank'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker newyork14Marker = Marker(
  markerId: MarkerId('newyork4'),
  position: LatLng(27.701885, 85.308689),
  infoWindow: InfoWindow(title: 'Near Statue of Siddhi Charan Shrestha '),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);




Marker newyork15Marker = Marker(
  markerId: MarkerId('newyork4'),
  position: LatLng(27.694163, 85.319897),
  infoWindow: InfoWindow(title: 'Near Mandala Prints '),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
