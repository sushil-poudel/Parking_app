
import 'package:flutter/material.dart';
import 'package:maps_parking/services/signup_background.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maps_parking/services/already_have_an_account_acheck.dart';
import 'package:maps_parking/widgets/divider.dart';
import 'package:maps_parking/screens/login.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _passwordController = new TextEditingController();

  Map<String, String> _authData = {
    'email' : '',
    'password' : ''
  };
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            //email
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
            Divider(),

          ],
        ),
      ),
    );
  }
}