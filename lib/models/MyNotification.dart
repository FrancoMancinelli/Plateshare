import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyNotification {
  final String id;
  final String data;
  final Timestamp date;
  final String image;
  final int type;
  final String usernotifier;
  MyNotification({
    required this.id,
    required this.data,
    required this.type,
    required this.date,
    required this.image,
    required this.usernotifier,
  });
}