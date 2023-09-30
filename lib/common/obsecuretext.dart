import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool _isObscured = true;

Widget passwordVisibilityToggle() {
  return InkWell(
    onTap: () {
   _isObscured=!_isObscured;
    },
    child: _isObscured
        ? Icon(CupertinoIcons.eye_fill)
        : Icon(CupertinoIcons.eye_slash_fill),
  );
}
