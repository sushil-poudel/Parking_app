import 'package:flutter/material.dart';
import 'package:maps_parking/parking_expense/parking_expenses.dart';
import 'package:maps_parking/widgets/divider.dart';

class About extends StatefulWidget {
  static const routeName = '/About';
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

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
      body:SingleChildScrollView(

        child: Stack(

          children: <Widget>[

            Container(

              margin: new EdgeInsets.fromLTRB(150, 80, 30, 0),
              child: Text(
                'About the app',
                style: TextStyle(
                  color: Theme.of(context).accentTextTheme.headline6.color,
                  fontSize: 20,
                  fontFamily: 'Anton',
                  fontWeight: FontWeight.normal,
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.blueGrey,
                        Colors.blue,
                      ]
                  )
              ),
            ),

            Container(
              margin: new EdgeInsets.fromLTRB(50, 150, 75, 20),
              child: Text('Sajilo parking is a parking area showing application that'
                  ' enables the users to find a parking space for their two-wheelers or four-wheelers.'
                  ' Users need to login to the app and then it automatically finds the current location of'
                  ' the user and shows the possible parking area,  with the purple marks '
                  'in the app. And when the user clicks on the marker it shows direction to the parking space.'
                  '  This app also enables the user to keep track of their parking expenses like where, when they '
                  'parked their vehicle and the amount they spent for the parking. Users can also record their other'
                  ' expenses if they wish to.'

                ,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Anton',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

            Container(
              margin: new EdgeInsets.fromLTRB(50, 550, 75, 20),
              child: Text('Searching for parking area is one of the hazardous works for the people.'
                  ' The need to manage parking is increasing day by day. People are confused where to park their vehicle.'
                  ' So, the application makes easy for people to park their vehicle and help them avoid parking in no parking zone. '
                  'People will pay less fine as parking will be more organized.'

                ,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Anton',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              margin: new EdgeInsets.fromLTRB(50, 800, 75, 20),
              child: Text('According to the Department of Transport Management,'
                  ' the number of motor vehicles in the country has reached to more than 3.08 '
                  'million and everyday people use their vehicles regularly for their use.'
                  ' When people go somewhere for their work, they have to park their vehicles and people '
                  'are confused where to park their vehicle, if they parked their vehicle in no parking zone'
                  ' or at the road side then traffic police takes vehicles and fine it.'

                ,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Anton',
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

        ],
    ),
      ),
    );
  }
}
