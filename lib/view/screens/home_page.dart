import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:neosoft/view/screens/profile_page.dart';
import 'package:neosoft/view/common_widget/button.dart';
import 'package:neosoft/view/screens/regiser_screen.dart';
import 'package:neosoft/view/screens/user_list.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import '../../utility/dbhelper.dart';
import '../../utility/theme.dart';
import '../../view_model/register_view_model.dart';
import '../common_widget/appbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget.appBar("Users", null),
        body: Stack(children: <Widget>[
          ChangeNotifierProvider(
              //create a instance of view_model/provider class
              create: (_) => RegisterViewModel(),
              //widget get the data from provider
              child: Consumer<RegisterViewModel>(
                  builder: (context, userProvider, child) {
                return FutureBuilder<List<User>>(
                  future: userProvider.fetchUserFromDatabase(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [UserList(snapshot.data![index])],
                          ));
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Container(),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              })),
          //bottom register button
          Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 64,
                  child: ButtonWidget.button(
                      0, primaryColor, whiteColor, 18, onPress, "Register")))
        ]));
  }

  onPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }
}
