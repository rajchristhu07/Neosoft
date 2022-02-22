import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:neosoft/model/user_model.dart';
import 'package:neosoft/screens/address_page.dart';

import '../utility/text_style.dart';
import '../utility/theme.dart';

class ProfilePage extends StatefulWidget {
  User user;
  ProfilePage(this.user);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }
  String grade="";
  String exp="";
  Future<void> _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {

        var user = User(widget.user.firstName,widget.user.lastName,widget.user.mobileNo,widget.user.emailId,widget.user.password,widget.user.gender,widget.user.picture,"","","","","",_eduState,_yearState,grade,exp,_desiginationState,_domainState);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddressPage(user)),
        );


    }
    _formKey.currentState!.save();
  }
  var _formKey = GlobalKey<FormState>();
  final List<String> _eduList = ["Post Graduate","Graduate", "HSC/Diploma","SSC"];
  String _eduState = "Post Graduate";
  final List<String> _desiginationList = ["Software Engineer","Tester"];
  String _desiginationState = "Software Engineer";
  final List<String> _domainList = ["Software","Support"];
  String _domainState = "Software";
  final List<String> _yearList = ["2019","2020", "2021"];
  String _yearState = "2019";
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
            "Your Info",
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
                child: Form(key: _formKey, child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        "Educational Info",
        style: titleLongTextStyle,
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        "Educational*",
        style: titleDefaultTextStyle,
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
      const SizedBox(
        height: 6,
      ),
      Text(
        "Year of Passing*",
        style: titleDefaultTextStyle,
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
      const SizedBox(
        height: 6,
      ),
      Text(
        "Grade*",
        style: titleDefaultTextStyle,
      ),
      Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
        ),
        child: Container(
          height: 44,
          child: TextFormField(
            key: ValueKey('grade'),
            keyboardType: TextInputType.number,
            // validator: (value) {
            //   if (value!.isNotEmpty) {
            //     return 'Enter a valid grade!';
            //   }
            //   return null;
            // },

            onChanged: (value) {
             grade = value;
            },
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(

              hintText: 'Enter your grade of Percentage ',
              errorStyle: TextStyle(fontSize: 9, height: 0),

              errorBorder: const OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(0.0)),
                borderSide:
                BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: const OutlineInputBorder(
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
        height: 20,
      ),
      Container(
        color: grayColor,
        width: MediaQuery.of(context).size.width,
        height: 1,
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        "Professional Info",
        style: titleLongTextStyle,
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        "Experience*",
        style: titleDefaultTextStyle,
      ),
      Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
        ),
        child: Container(
          height: 44,
          child: TextFormField(
            key: ValueKey('experience'),
            keyboardType: TextInputType.number,
            // validator: (value) {
            //   if (value!.isNotEmpty) {
            //     return 'Enter a valid experience!';
            //   }
            //   return null;
            // },

            onChanged: (value) {
              exp = value;
            },
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(

              hintText: 'Enter your grade of Experience ',
              errorStyle: TextStyle(fontSize: 9, height: 0),

              errorBorder: const OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(0.0)),
                borderSide:
                BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: const OutlineInputBorder(
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
        height: 6,
      ),
      Text(
        "Designation*",
        style: titleDefaultTextStyle,
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
                value: _desiginationState,
                items: _desiginationList.map((String value) {
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
      const SizedBox(
        height: 6,
      ),
      Text(
        "Domain",
        style: titleDefaultTextStyle,
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
          Expanded(child:
      FlatButton(
        height: 40,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Previous',   style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold,color: primaryColor),
        ),
        textColor: primaryColor,
        shape: RoundedRectangleBorder(side: BorderSide(
            color: primaryColor,
            width: 1,
            style: BorderStyle.solid
        ), borderRadius: BorderRadius.circular(0)),
      )

          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(child:  FlatButton(
              minWidth: MediaQuery.of(context).size.width,
              height: 40,
              color: primaryColor,
              textColor: Colors.white,
              child: const Text(
                'Next',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                _submit();
              }),),

        ],
      ),
      const SizedBox(
        height: 40,
      ),
    ])))));
  }
}
