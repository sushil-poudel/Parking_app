import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:maps_parking/services/auth.dart';
import 'package:maps_parking/parking_expense/parking_expenses.dart';
import 'package:maps_parking/screens/homescreen.dart';
import 'package:maps_parking/screens/login.dart';
import 'package:maps_parking/homepage.dart';
import 'package:maps_parking/services/already_have_an_account_acheck.dart';
import 'package:maps_parking/services/signup_background.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();

  Map<String, String> _authData = {
    'Full name':'',
    'email' : '',
    'password' : ''
  };

  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }

  Future<void> _submit() async
  {
    if(!_formKey.currentState.validate())
    {
      return;
    }
    _formKey.currentState.save();

    try{
      await Provider.of<Authentication>(context, listen: false).signUp(
          _authData['Fullname'],
          _authData['email'],
          _authData['password']
      );
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);

    } catch(error)
    {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Account'),

        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text('Login'),
                Icon(Icons.person)
              ],
            ),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[

        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/images/6.jpg"
                  ),
                  fit: BoxFit.cover
              )
          ),
        ),


          Container(
            margin: new EdgeInsets.fromLTRB(75, 80, 30, 0),
            child: Text(
              'Sajilo Parking',
              style: TextStyle(
                color: Theme.of(context).accentTextTheme.headline6.color,
                fontSize: 40,
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

           Card(
             margin: new EdgeInsets.fromLTRB(50, 200, 50, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(

                height: 450,
                width: 300,
                padding: EdgeInsets.all(16),


                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[

                    Container(

                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        // fontFamily: 'Anton',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),
                        //email

                        TextFormField(
                          decoration: InputDecoration(labelText: 'Fullname'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value.isEmpty )
                            {
                              return 'Writer your Fullname';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['Fullname'] = value;
                          },
                        ),


                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value.isEmpty || !value.contains('@'))
                            {
                              return 'invalid email';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['email'] = value;
                          },
                        ),

                        //password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value)
                          {
                            if(value.isEmpty || value.length<=5)
                            {
                              return 'invalid password';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['password'] = value;
                          },
                        ),

                        //Confirm Password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: (value)
                          {
                            if(value.isEmpty || value != _passwordController.text)
                            {
                              return 'invalid password';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {

                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          child: Text(
                              'Submit'
                          ),
                          onPressed: ()
                          {
                            _submit();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),

                        SizedBox(height: size.height * 0.03),
                        AlreadyHaveAnAccountCheck(
                          login: false,
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                },
                              ),
                            );
                          },
                        ),

                      ],
                    ),

                  ),

                ),



              ),
            ),

        ],
      ),
    );
  }
}