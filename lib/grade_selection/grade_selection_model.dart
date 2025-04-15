import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'grade_selection_widget.dart' show GradeSelectionWidget;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GradeSelectionModel extends FlutterFlowModel<GradeSelectionWidget> {
  ///  Local state fields for this page.

  List<String> grades = [
    'Kindergarten',
    'First grade',
    'Second grade',
    'Third grade',
    'Fourth grade',
    'Fifth grade',
    'Sixth grade',
    'Seventh grade',
    'Eighth grade',
    'Ninth grade',
    'Tenth grade',
    'Eleventh grade',
    'Twelvth grade'
  ];
  void addToGrades(String item) => grades.add(item);
  void removeFromGrades(String item) => grades.remove(item);
  void removeAtIndexFromGrades(int index) => grades.removeAt(index);
  void insertAtIndexInGrades(int index, String item) =>
      grades.insert(index, item);
  void updateGradesAtIndex(int index, Function(String) updateFn) =>
      grades[index] = updateFn(grades[index]);

  List<String> subjects = ['Math', 'Social Studies', 'English', 'Science'];
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
