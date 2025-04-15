import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/congratulate_box/congratulate_box_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  Local state fields for this page.

  bool canUpgrade = true;

  List<String> grades = [
    'Kindergarten',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  void addToGrades(String item) => grades.add(item);
  void removeFromGrades(String item) => grades.remove(item);
  void removeAtIndexFromGrades(int index) => grades.removeAt(index);
  void insertAtIndexInGrades(int index, String item) =>
      grades.insert(index, item);
  void updateGradesAtIndex(int index, Function(String) updateFn) =>
      grades[index] = updateFn(grades[index]);

  List<String> subjects = ['Math', 'Social Studies', 'Reading', 'Science'];
  void addToSubjects(String item) => subjects.add(item);
  void removeFromSubjects(String item) => subjects.remove(item);
  void removeAtIndexFromSubjects(int index) => subjects.removeAt(index);
  void insertAtIndexInSubjects(int index, String item) =>
      subjects.insert(index, item);
  void updateSubjectsAtIndex(int index, Function(String) updateFn) =>
      subjects[index] = updateFn(subjects[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
