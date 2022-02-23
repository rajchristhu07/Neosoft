import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../model/user_model.dart';
import '../utility/dbhelper.dart';
import '../utility/text_style.dart';
import '../utility/theme.dart';
import 'landing_page.dart';

class AddressPage extends StatefulWidget {
  User user;
  AddressPage(this.user);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final List<String> _stateList = ["Mumbai", "Chennai"];
   String _currentState = "Mumbai";
  var _formKey = GlobalKey<FormState>();
  String address="";
  String landmark="";
  String city="";
  String state="";
  String pincode="";

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    else{
      var user = User(widget.user.firstName,widget.user.lastName,widget.user.mobileNo,widget.user.emailId,widget.user.password,widget.user.gender,widget.user.picture,address,landmark,city,_currentState,pincode, widget.user.educational,
        widget.user.year,
        widget.user.grade,
        widget.user.exp,
        widget.user.desigination,
        widget.user.domain,);

      var dbHelper = DBHelper.instance;
      dbHelper.saveUser(user);
      Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) =>  LandingPage()),
      (route) => false);

    }
    _formKey.currentState!.save();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          toolbarHeight: 60,
          elevation: 0,
          shadowColor: whiteColor,
          foregroundColor: whiteColor,
          centerTitle: true,
          title: Text(
            "Your Address",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: blackColor, fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          backgroundColor: whiteColor,
        ),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Container(
                padding: EdgeInsets.only(right: 40, left: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: Container(
                          height: 44,
                          child: TextFormField(
                            key: ValueKey('email'),
                            validator: (value) {
                              if (value!.length<3) {
                                return 'Enter a valid landmark!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s"))
                            ],
                            onChanged: (value) {
                              address = value;
                            },
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.business,
                                color: primaryColor,
                              ),
                              hintText: 'Address',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: HexColor("#383838"),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500),

                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              errorStyle: TextStyle(fontSize: 9, height: 0),

                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0.0)),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1),
                              ),
                              focusedErrorBorder:  const OutlineInputBorder(

                                borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                                borderSide:
                                BorderSide(color: Colors.red, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(0.0)),
                                borderSide:
                                    BorderSide(color: blackColor, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0.0)),
                                borderSide:
                                    BorderSide(color: blackColor, width: 1),
                              ),
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.all(Radius.circular(6.0)),
                              //     borderSide: BorderSide(color: HexColor("#E2E2E2"), width: 1),
                              //
                              // ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: Container(
                          height: 44,
                          child: TextFormField(
                            key: ValueKey('landmark'),
                            validator: (value) {
                              if (value!.length<3) {
                                return 'Enter a valid landmark!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s"))
                            ],
                            onChanged: (value) {
                              landmark = value;
                            },
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.business,
                                color: primaryColor,
                              ),
                              errorStyle: TextStyle(fontSize: 9, height: 0),
                              focusedErrorBorder:  const OutlineInputBorder(

                                borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                                borderSide:
                                BorderSide(color: Colors.red, width: 1),
                              ),

                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                                borderSide:
                                BorderSide(color: Colors.red, width: 1),
                              ),
                              hintText: 'Landmark',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: HexColor("#383838"),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(0.0)),
                                borderSide:
                                    BorderSide(color: blackColor, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0.0)),
                                borderSide:
                                    BorderSide(color: blackColor, width: 1),
                              ),
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.all(Radius.circular(6.0)),
                              //     borderSide: BorderSide(color: HexColor("#E2E2E2"), width: 1),
                              //
                              // ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: Container(
                          height: 44,
                          child: TextFormField(
                            key: ValueKey('city'),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.length<3) {
                                return 'Enter a valid city!';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s"))
                            ],
                            onChanged: (value) {
                              city = value;
                            },
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.business,
                                color: primaryColor,
                              ),
                              hintText: 'City',
                              errorStyle: TextStyle(fontSize: 9, height: 0),
                              focusedErrorBorder:  const OutlineInputBorder(

                                borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                                borderSide:
                                BorderSide(color: Colors.red, width: 1),
                              ),

                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                                borderSide:
                                BorderSide(color: Colors.red, width: 1),
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: HexColor("#383838"),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(0.0)),
                                borderSide:
                                    BorderSide(color: blackColor, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0.0)),
                                borderSide:
                                    BorderSide(color: blackColor, width: 1),
                              ),
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.all(Radius.circular(6.0)),
                              //     borderSide: BorderSide(color: HexColor("#E2E2E2"), width: 1),
                              //
                              // ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: Container(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: blackColor,
                                  // set border color
                                  width: 1.0),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(0.0)),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 44,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _currentState,
                                items: _stateList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: HexColor("#383838")),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _currentState = value!;
                                  });
                                },
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: Container(
                          height: 44,
                          child: TextFormField(
                            key: ValueKey('pincode'),
                            validator: (value) {
                              if (value!.length<6) {
                                return 'Enter a valid pincode!';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'))
                            ],
                            onChanged: (value) {
                              pincode = value;
                            },
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.business,
                                color: primaryColor,
                              ),
                              hintText: 'Pincode',
                              errorStyle: TextStyle(fontSize: 9, height: 0),
                              focusedErrorBorder:  const OutlineInputBorder(

                                borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                                borderSide:
                                BorderSide(color: Colors.red, width: 1),
                              ),

                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(0.0)),
                                borderSide:
                                BorderSide(color: Colors.red, width: 1),
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: HexColor("#383838"),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(0.0)),
                                borderSide:
                                    BorderSide(color: blackColor, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0.0)),
                                borderSide:
                                    BorderSide(color: blackColor, width: 1),
                              ),
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.all(Radius.circular(6.0)),
                              //     borderSide: BorderSide(color: HexColor("#E2E2E2"), width: 1),
                              //
                              // ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FlatButton(
                          minWidth: MediaQuery.of(context).size.width,
                          height: 50,
                          color: primaryColor,
                          textColor: Colors.white,
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            _submit();
                          }),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ))));
  }
}
