import 'package:coffeewala_app/screens/services/auth.dart';
import 'package:coffeewala_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();

  final Function toggleView;
  Register({this.toggleView});
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Register'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label:
                        Text("Validate", style: TextStyle(color: Colors.white)))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.darken),
                    image: AssetImage('assets/coffee_register.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          }
                          );
                          email = email + '@google.com';
                          password = email;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Bill No.",
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      // TextFormField(
                      //   validator: (val) => val.length < 2
                      //       ? 'Enter a password 2+ char long'
                      //       : null,
                      //   onChanged: (val) {
                      //     setState(() {
                      //       password = val;
                      //     });
                      //   },
                      //   style: TextStyle(color: Colors.white),
                      //   decoration: InputDecoration(
                      //       hintText: "Password",
                      //       hintStyle: TextStyle(color: Colors.white54)),
                      // ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        child: Text("Register"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Enter valid credentials';
                                loading = false;
                              });
                            }
                          }
                        },
                        splashColor: Colors.brown[400],
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 16.0),
                      )
                    ],
                  ),
                )),
          );
  }
}
