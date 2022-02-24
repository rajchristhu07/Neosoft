import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neosoft/view/screens/home_page.dart';
import 'package:neosoft/view_model/register_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../container/injection_container.dart';
import '../../model/user_model.dart';
import '../../data/dbhelper.dart';
import '../../utility/text_style.dart';
import '../../utility/theme.dart';
import '../common_widget/text_field.dart';

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
  String address = "";
  String landmark = "";
  String city = "";
  String state = "";
  String pincode = "";

  //controller
  final __pincodeController = TextEditingController();
  final __cityController = TextEditingController();
  final __addressController = TextEditingController();
  final __landmarkController = TextEditingController();

  void _submit(RegisterViewModel provider) {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      var user = User(
        widget.user.firstName,
        widget.user.lastName,
        widget.user.mobileNo,
        widget.user.emailId,
        widget.user.password,
        widget.user.gender,
        widget.user.picture,
        __addressController.text.toString(),
        __landmarkController.text.toString(),
        __cityController.text.toString(),
        _currentState,
        __pincodeController.text.toString(),
        widget.user.educational,
        widget.user.year,
        widget.user.grade,
        widget.user.exp,
        widget.user.desigination,
        widget.user.domain,
      );
      provider.addUser(user);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>  ChangeNotifierProvider(
            child: HomePage(),
            create: (ctx) => RegisterViewModel(serviceLocater()),
          ),),
          (route) => false);
    }
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterViewModel>(context, listen: false);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                      _buildAddress(),
                      _buildLandmark(),
                      _buildCity(),
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
                      _buildPincode(),
                      Container(
                          padding: EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                              ),
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                _submit(provider);
                              })),
                    ],
                  ),
                ))));
  }

  Widget _buildLandmark() {
    return TextFormFieldWidget(
      hintText: "Landmark",
      obscureText: false,
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.next,
      functionValidate: nameValidation,
      controller: __landmarkController,
      onSubmitField: () {},
      parametersValidate: "Enter a valid landmark!",
      prefixIcon: Icon(
        Icons.business,
        color: primaryColor,
      ),
      keys: "landmark",
    );
  }

  Widget _buildAddress() {
    return TextFormFieldWidget(
      hintText: "Address",
      obscureText: false,
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.next,
      functionValidate: nameValidation,
      controller: __addressController,
      onSubmitField: () {},
      parametersValidate: "Enter a valid Address!",
      prefixIcon: Icon(
        Icons.business,
        color: primaryColor,
      ),
      keys: "address",
    );
  }

  Widget _buildCity() {
    return TextFormFieldWidget(
      hintText: "City",
      obscureText: false,
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.next,
      functionValidate: nameValidation,
      controller: __cityController,
      onSubmitField: () {},
      parametersValidate: "Enter a valid City!",
      prefixIcon: Icon(
        Icons.business,
        color: primaryColor,
      ),
      keys: "city",
    );
  }

  Widget _buildPincode() {
    return TextFormFieldWidget(
      hintText: "Pincode",
      obscureText: false,
      textInputType: TextInputType.number,
      actionKeyboard: TextInputAction.next,
      functionValidate: nameValidation,
      controller: __pincodeController,
      onSubmitField: () {},
      parametersValidate: "Enter a valid pincode!",
      prefixIcon: Icon(
        Icons.business,
        color: primaryColor,
      ),
      keys: "pincode",
    );
  }
}
