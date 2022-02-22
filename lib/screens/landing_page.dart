import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:neosoft/screens/pages/user_list.dart';
import 'package:neosoft/screens/profile_page.dart';
import 'package:neosoft/screens/register_page.dart';

import '../model/user_model.dart';
import '../utility/dbhelper.dart';
import '../utility/theme.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}
Future<List<User>> fetchUserFromDatabase() async {
  var dbHelper = DBHelper();
  Future<List<User>> user = dbHelper.getUser();
  return user;
}
class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 1,
          shadowColor: whiteColor,
          foregroundColor: whiteColor,
          centerTitle: true,
          title: Text(
            "Users",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: blackColor, fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          backgroundColor: whiteColor,
        ),
        body: Stack(children: <Widget>[
        MediaQuery.removePadding(
        context: context,
            removeTop: true,
            child: FutureBuilder<List<User>>(
                future: fetchUserFromDatabase(),
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
                    return Text("${snapshot.error}");
                  }
                  return Container(alignment: AlignmentDirectional.center,
                    child: const CircularProgressIndicator(),);
                }),
        ),

            Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 64,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: HexColor("#283265"),
                      onPrimary: Colors.white,
                      // side: BorderSide(color: Colors.red, width: 1),
                      textStyle: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: GoogleFonts
                              .montserrat()
                              .fontFamily),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: const Text('Register'),
                  ),
                ))
       ]));
  }
}
