import 'package:coffeewala_app/models/user.dart';
import 'package:coffeewala_app/screens/Authenticate/authenticate.dart';
import 'package:coffeewala_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
