import 'dart:ui';

import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    fontFamily: "Spartan MB");

final kMessageTextFieldDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here',
  hintStyle: const TextStyle(
    color: Colors.white54,
    // fontFamily: "Catamaran",
  ),
  border: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
  enabledBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
  ),
  focusedBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
  ),
  fillColor: Colors.blueAccent.withOpacity(0.95),
  filled: true,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.white54, width: 2.0),
  ),

  // borderRadius: BorderRadius.all(
  //   Radius.circular(1),
  // ),
  color: Colors.white60,
);

final kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your email',
  hintStyle: const TextStyle(
    color: Colors.white70,
    // fontWeight: FontWeight.w500,
    fontFamily: "Catamaran",
  ),
  fillColor: Colors.black54.withOpacity(0.4),
  filled: true,
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
);
