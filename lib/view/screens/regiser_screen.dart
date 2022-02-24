import 'dart:io';

import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neosoft/view/common_widget/button.dart';
import 'package:neosoft/view_model/register_viewmodel.dart';

import '../../model/user_model.dart';
import '../common_widget/image_utility.dart';
import 'profile_page.dart';
import '../../utility/text_style.dart';
import '../../utility/theme.dart';
import '../common_widget/appbar.dart';
import '../common_widget/image_picker.dart';
import '../common_widget/text_field.dart';

class RegisterScreen extends StatefulWidget {



  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

//key for form
var _formKey = GlobalKey<FormState>();
ByteData? imageData;

class _RegisterScreenState extends State<RegisterScreen> {
  //image picker
  String imgString = "";
  File? _image;

  //controller
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _emailController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  //dropdown
  String _selectedGender = 'male';

  //password
  bool _obscureText = true;
  bool pas = false;
  AnimateIconController? controller;

  @override
  void initState() {
    controller = AnimateIconController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //scroll action init when keyboard open
        resizeToAvoidBottomInset: true,
        appBar: AppBarWidget.appBar("Register",
            ButtonWidget.iconButton(Icons.arrow_back, Colors.black, onPress)),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(right: 40, left: 40, bottom: 40),
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //image picker
                          Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Center(
                                  child: GestureDetector(
                                onTap: () {
                                  ImagePickerWidget.showPicker(
                                      context, galleryClick, cameraClick);
                                },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: CircleAvatar(
                                        radius: 51,
                                        backgroundColor: grayColor,
                                        child: _image != null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.file(
                                                  _image!,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                width: 100,
                                                height: 100,
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.grey[800],
                                                ),
                                              ),
                                      ),
                                    ),
                                    const Positioned(
                                        right: 0,
                                        bottom: 40,
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                          size: 24,
                                        ))
                                  ],
                                ),
                              ))),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "First Name*",
                              style: titleDefaultTextStyle,
                            ),
                          ),
                          _buildFirstName(),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "Last Name*",
                              style: titleDefaultTextStyle,
                            ),
                          ),
                          _buildLastName(),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "Phone Number*",
                              style: titleDefaultTextStyle,
                            ),
                          ),
                          _buildPhoneNo(),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "Email*",
                              style: titleDefaultTextStyle,
                            ),
                          ),
                          _buildEmail(),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "Gender*",
                              style: titleDefaultTextStyle,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio<String>(
                                value: 'male',
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value!;
                                  });
                                },
                              ),
                              Text('Male'),
                              Radio<String>(
                                value: 'female',
                                groupValue: _selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value!;
                                  });
                                },
                              ),
                              Text('Female')
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "Password*",
                              style: titleDefaultTextStyle,
                            ),
                          ),
                          _buildPassword(),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "Confirm Password",
                              style: titleDefaultTextStyle,
                            ),
                          ),
                          _buildConfirmPassword(),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              padding: EdgeInsets.only(top: 10),
                              child: ButtonWidget.button(0, primaryColor,
                                  textColor, 18, _submit, "Next")),
                        ])))));
  }

  onPress() {
    Navigator.of(context).pop();
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      if (imgString != "") {
        rootBundle
            .load(_image!.path)
            .then((data) => {setState(() => imageData = data)});
        var user = User(
            _firstNameController.text.toString(),
            _lastNameController.text.toString(),
            _phoneNoController.text.toString(),
            _emailController.text.toString(),
            _passwordController.text.toString(),
            _selectedGender,
            imgString,
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "","");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(user)),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Please add profile picture",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    _formKey.currentState!.save();
  }

  Widget _buildFirstName() {
    return TextFormFieldWidget(
      hintText: "Enter your first name here",
      obscureText: false,
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.next,
      functionValidate: nameValidation,
      controller: _firstNameController,
      onSubmitField: () {},
      parametersValidate: "Enter a valid first name!",
      prefixIcon: Icon(
        Icons.person,
        color: primaryColor,
      ),
      keys: "first_name",
    );
  }

  Widget _buildLastName() {
    return TextFormFieldWidget(
      hintText: "Enter your last name here",
      obscureText: false,
      textInputType: TextInputType.name,
      actionKeyboard: TextInputAction.next,
      functionValidate: nameValidation,
      controller: _lastNameController,
      onSubmitField: () {},
      parametersValidate: "Enter a valid last name!",
      prefixIcon: Icon(
        Icons.person,
        color: primaryColor,
      ),
      keys: "last_name",
    );
  }

  Widget _buildEmail() {
    return TextFormFieldWidget(
      hintText: "Your email goes here",
      obscureText: false,
      textInputType: TextInputType.emailAddress,
      actionKeyboard: TextInputAction.next,
      functionValidate: emailValidation,
      controller: _emailController,
      onSubmitField: () {},
      parametersValidate: "Enter a valid email id!",
      prefixIcon: Icon(
        Icons.email,
        color: primaryColor,
      ),
      keys: "email",
    );
  }

  Widget _buildPhoneNo() {
    return TextFormFieldWidget(
      hintText: "Enter your 10 digit phone number ",
      obscureText: false,
      textInputType: TextInputType.number,
      actionKeyboard: TextInputAction.next,
      functionValidate: phoneValidation,
      controller: _phoneNoController,
      onSubmitField: () {},
      parametersValidate: "Enter a valid last phoneno!",
      prefixIcon: Icon(
        Icons.phone,
        color: primaryColor,
      ),
      keys: "phoneno",
    );
  }

  Widget _buildPassword() {
    return TextFormFieldWidget(
      hintText: "Password",
      obscureText: _obscureText,
      textInputType: TextInputType.visiblePassword,
      actionKeyboard: TextInputAction.next,
      functionValidate: passwordValidation,
      controller: _passwordController,
      onSubmitField: () {},
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            _obscureText = _obscureText;
          });
        },
        child: AnimateIcons(
          startIcon: Icons.visibility_rounded,
          endIcon: Icons.visibility_off,
          size: 20.0,
          controller: controller!,
          onStartIconPress: () {
            setState(() {
              _obscureText = false;
            });
            // _obscureText = true;
            return true;
          },
          onEndIconPress: () {
            setState(() {
              _obscureText = true;
            });
            return true;
          },
          duration: Duration(milliseconds: 200),
          startIconColor: pas ? HexColor("#717171") : HexColor("#E2E2E2"),
          endIconColor: pas ? HexColor("#717171") : HexColor("#E2E2E2"),
          clockwise: false,
        ),
      ),
      parametersValidate: "Please enter password.",
      prefixIcon: Icon(
        Icons.lock,
        color: primaryColor,
      ),
      keys: "password",
    );
  }

  Widget _buildConfirmPassword() {
    return TextFormFieldWidget(
      hintText: "Password",
      obscureText: true,
      textInputType: TextInputType.visiblePassword,
      actionKeyboard: TextInputAction.done,
      functionValidate: conPasswordValidation,
      controller: _confirmpasswordController,
      onSubmitField: () {},
      parametersValidate: _passwordController.text.toString(),
      prefixIcon: Icon(
        Icons.lock,
        color: primaryColor,
      ),
      keys: "conpas",
    );
  }

  Future getImage() async {
    ImagePicker().pickImage(source: ImageSource.gallery).then((imgFile) {
      imgFile!
          .readAsBytes()
          .then((value) => imgString = ImageUtility.base64String(value));

      setState(() {
        imgString = imgString;
        _image = File(imgFile.path);
      });
    });
  }

  Future getImageCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    });
  }

  galleryClick() {
    getImage();
    Navigator.of(context).pop();
  }

  cameraClick() {
    getImageCamera();
    Navigator.of(context).pop();
  }
}
