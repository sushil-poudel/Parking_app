import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_parking/widgets/divider.dart';
import 'package:maps_parking/screens/about.dart';
import 'package:maps_parking/homepage.dart';
import 'package:maps_parking/models/transaction.dart';
import 'package:maps_parking/widgets/chart.dart';
import 'package:maps_parking/widgets/chart_bar.dart';
import 'package:maps_parking/widgets/new_transaction.dart';
import 'package:maps_parking/widgets/transaction_list.dart';
import 'package:maps_parking/services/auth.dart';


class  PersonalExpenses  extends StatelessWidget  {

  static const routeName = '/parking';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking Expenses',
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.lightBlue,
          //errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            button: TextStyle(color: Colors.white),
          ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),



      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }


  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showChart=false;
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List <Widget> _buildLandscapeContent(MediaQueryData mediaQuery,AppBar appBar, Widget txListWidget){
    return [Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children: <Widget>[
        Text('show chart',
          style:Theme.of(context).textTheme.headline6,),
        Switch.adaptive(
          value: _showChart,
          onChanged:(val){
            setState(() {
              _showChart=val;
            });
          },
        ),
      ],
    ), _showChart
        ?Container(
        height:(MediaQuery.of(context).size.height-
            appBar.preferredSize.height-
            MediaQuery.of(context).padding.top)*0.7,
        child: Chart(_recentTransactions))
        :txListWidget];
  }
  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery,AppBar appBar, Widget txListWidget){
    return  [Container(
        height:(mediaQuery.size.height-
            appBar.preferredSize.height-
            mediaQuery.padding.top)*0.3,
        child: Chart(_recentTransactions)), txListWidget];

  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery= MediaQuery.of(context);
    final isLandscape=mediaQuery.orientation== Orientation.landscape;
    final PreferredSizeWidget appBar= Platform.isIOS? CupertinoNavigationBar(
      middle: Text(
        'Personal Expenses',
      ),
      trailing: Row(
        mainAxisSize:MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child:Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          ),
        ],
      ),
    ): AppBar(
      title: Text(
        'Personal Expenses',
      ),


      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    final txListWidget=Container(
        height:(mediaQuery.size.height-
            appBar.preferredSize.height-
            mediaQuery.padding.top)*0.7,
        child:TransactionList(_userTransactions, _deleteTransaction));

    final pageBody= SafeArea(child:SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandscape)
            ..._buildLandscapeContent(mediaQuery,appBar,txListWidget),


          if(!isLandscape)
            ..._buildPortraitContent(mediaQuery,appBar,txListWidget),



        ],
      ),
    ),
    );


    return Platform.isIOS? CupertinoPageScaffold(
      child:pageBody,
      navigationBar :appBar,
    )
        : Scaffold(
      appBar: appBar,

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
                      MaterialPageRoute(builder: (context) => HomePage())
                  )
                },
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.map),
                    SizedBox(width: 10,),
                    Text("View parking areas")
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




      body:pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
      Platform.isIOS?
      Container():
      FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
