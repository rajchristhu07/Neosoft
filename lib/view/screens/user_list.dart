import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../model/user_model.dart';
import '../../view/common_widget/user_dialog.dart';
import '../common_widget/image_utility.dart';

class UserList extends StatefulWidget {
  User data;

  UserList(this.data, {Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return CustomUserDetailDialogBox(widget.data);
              });
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                      // optional flex property if flex is 1 because the default flex is 1
                      flex: 0,
                      child: Container(
                        padding: const EdgeInsets.all(1), // Border width
                        decoration: BoxDecoration(
                            color: HexColor("#283265"),
                            borderRadius: BorderRadius.circular(100)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(30), // Image radius
                            child: widget.data.picture != null
                                ? ImageUtility.imageFromBase64String(
                                    widget.data.picture!)
                                : Image.asset("assets/pic.jpg",
                                    height: 60.0,
                                    width: 60.0,
                                    fit: BoxFit.cover),
                          ),
                        ),
                      )),
                  const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    // optional flex property if flex is 1 because the default flex is 1
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                            // optional flex property if flex is 1 because the default flex is 1
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.data.firstName!,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: HexColor("#1C1C1C"),
                                      fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  widget.data.lastName!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: HexColor("#717171"),
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            )),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            // optional flex property if flex is 1 because the default flex is 1
                            flex: 0,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: HexColor("#555555"),
                              size: 24.0,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: HexColor("#E2E2E2"),
            )
          ],
        ));
  }
}
