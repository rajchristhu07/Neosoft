import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utility/text_style.dart';
import '../../utility/theme.dart';

class AppBarWidget {
  static AppBar appBar(title,leading) {
    return AppBar(
      leading:leading,
      toolbarHeight: 60,
      elevation: 0,

      centerTitle: true,
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: appbarTextStyle,
      ),
      backgroundColor: whiteColor,
    );
  }


}
