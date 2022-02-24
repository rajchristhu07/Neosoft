import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:neosoft/model/user_model.dart';
import 'package:neosoft/view/screens/address_page.dart';
import 'package:provider/provider.dart';

import '../../container/injection_container.dart';
import '../../utility/text_style.dart';
import '../../utility/theme.dart';
import '../../view_model/register_viewmodel.dart';
import '../common_widget/appbar.dart';
import '../common_widget/button.dart';
import '../common_widget/text_field.dart';

class ProfilePage extends StatefulWidget {
  User user;
  ProfilePage(this.user);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _gradeController = TextEditingController();
  final _experienceController = TextEditingController();

  Future<void> _submit() async {
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
          "",
          "",
          "",
          "",
          "",
          _eduState,
          _yearState,
          _gradeController.text.toString(),
          _experienceController.text.toString(),
          _desiginationState,
          _domainState);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
          child: AddressPage(user),
          create: (ctx) => RegisterViewModel(serviceLocater()),
        ),)
      );
    }
    _formKey.currentState!.save();
  }

  var _formKey = GlobalKey<FormState>();
  final List<String> _eduList = [
    "Post Graduate",
    "Graduate",
    "HSC/Diploma",
    "SSC"
  ];
  String _eduState = "Post Graduate";
  final List<String> _desiginationList = ["Software Engineer", "Tester"];
  String _desiginationState = "Software Engineer";
  final List<String> _domainList = ["Software", "Support"];
  String _domainState = "Software";
  final List<String> _yearList = ["2019", "2020", "2021"];
  String _yearState = "2019";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarWidget.appBar("Your Info",
            ButtonWidget.iconButton(Icons.arrow_back, Colors.black, onPress)),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(right: 40, left: 40),
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              "Educational Info",
                              style: titleLongTextStyle,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              "Educational*",
                              style: titleDefaultTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: blackColor,
                                      // set border color
                                      width: 1.0),
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(0.0)),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 44,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _eduState,
                                    items: _eduList.map((String value) {
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
                                        _eduState = value!;
                                      });
                                    },
                                  ),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "Year of Passing*",
                              style: titleDefaultTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: blackColor,
                                      // set border color
                                      width: 1.0),
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(0.0)),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 44,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _yearState,
                                    items: _yearList.map((String value) {
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
                                        _yearState = value!;
                                      });
                                    },
                                  ),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "Grade*",
                              style: titleDefaultTextStyle,
                            ),
                          ),
                          _buildGrade(),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Container(
                              color: grayColor,
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              "Professional Info",
                              style: titleLongTextStyle,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              "Experience",
                              style: titleDefaultTextStyle,
                            ),
                          ),
                          _buildExp(),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "Designation*",
                              style: titleDefaultTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: blackColor,
                                      // set border color
                                      width: 1.0),
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(0.0)),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 44,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _desiginationState,
                                    items:
                                        _desiginationList.map((String value) {
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
                                        _desiginationState = value!;
                                      });
                                    },
                                  ),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Text(
                              "Domain",
                              style: titleDefaultTextStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: blackColor,
                                      // set border color
                                      width: 1.0),
                                  shape: BoxShape.rectangle,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(0.0)),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 44,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _domainState,
                                    items: _domainList.map((String value) {
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
                                        _domainState = value!;
                                      });
                                    },
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: FlatButton(
                                height: 40,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Previous',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                                textColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: primaryColor,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(0)),
                              )),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: primaryColor,
                                        ),
                                        child: const Text(
                                          'Next',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          _submit();
                                        })),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ])))));
  }

  onPress() {
    Navigator.of(context).pop();
  }

  Widget _buildGrade() {
    return TextFormFieldWidget(
      hintText: "Enter your grade of Percentage",
      obscureText: false,
      textInputType: TextInputType.number,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: _gradeController,
      onSubmitField: () {},
      parametersValidate: "Enter a valid grade!",
      keys: "grade",
    );
  }

  Widget _buildExp() {
    return TextFormFieldWidget(
      hintText: "Enter your grade of Experience ",
      obscureText: false,
      textInputType: TextInputType.number,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: _experienceController,
      onSubmitField: () {},
      parametersValidate: "Enter a valid experience!",
      keys: "experience",
    );
  }
}
