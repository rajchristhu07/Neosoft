import 'dart:typed_data';

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? emailId;
  String? password;
  String? gender;
  String? picture;
  String? address;
  String? landmark;
  String? city;
  String? state;
  String? pincode;
  String? educational;
  String? year;
  String? grade;
  String? exp;
  String? desigination;
  String? domain;

  User(
    this.firstName,
    this.lastName,
    this.mobileNo,
    this.emailId,
    this.password,
    this.gender,
    this.picture,
    this.address,
    this.landmark,
    this.city,
    this.state,
    this.pincode,
    this.educational,
    this.year,
    this.grade,
    this.exp,
    this.desigination,
    this.domain,
  );

  User.fromMap(Map map) {
    id = map[id];
    firstName = map[firstName];
    lastName = map[lastName];
    mobileNo = map[mobileNo];
    emailId = map[emailId];
    password = map[password];
    gender = map[gender];
    picture = map[picture];
    address = map[address];
    landmark = map[landmark];
    city = map[city];
    state = map[state];
    pincode = map[pincode];
    educational = map[educational];
    year = map[year];
    grade = map[grade];
    exp = map[exp];
    desigination = map[desigination];
    domain = map[domain];
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "mobileNo": mobileNo,
        "emailId": emailId,
        "password": password,
        "gender": gender,
        "picture": picture,
        "address": address,
        "landmark": landmark,
        "city": city,
        "state": state,
        "pincode": pincode,
        "educational": educational,
        "year": year,
        "grade": grade,
        "exp": exp,
        "desigination": desigination,
        "domain": domain,
      };
}
