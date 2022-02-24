import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:neosoft/view/screens/profile_page.dart';
import 'package:neosoft/view/common_widget/button.dart';
import 'package:neosoft/view/screens/regiser_screen.dart';
import 'package:neosoft/view/screens/user_list.dart';
import 'package:neosoft/view_model/register_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../model/user_model.dart';
import '../../data/dbhelper.dart';
import '../../utility/theme.dart';
import '../../view_model/register_repo.dart';
import '../common_widget/appbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterViewModel>(context, listen: false);
    final getAllUser = provider.getAllUsers;
    return Scaffold(
      appBar: AppBarWidget.appBar("Users", null),
      body: Stack(children: <Widget>[
        FutureBuilder<List<User>>(
          future: getAllUser(),
          builder: (context, snapshot) {
            // Make sure data exists and is actually loaded
            if (snapshot.hasData) {
              // If there are no notes (data), display this message.
              if (snapshot.data!.isEmpty) {
                return const Text('No users');
              }
              List<User> users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [UserList(users[index])],
                  ));
                },
              );
            }
            // If the data is loading in, display a progress indicator
            // to indicate that. You don't have to use a progress
            // indicator, but the StreamBuilder has to return a widget.
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [UserList(snapshot.data![index])],
                      ));
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 64,
                child: ButtonWidget.button(
                    0, primaryColor, whiteColor, 18, onPress, "Register")))
      ]),
    );
  }

  onPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }
}
