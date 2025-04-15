import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'leaderboard_t_itle_widget.dart' show LeaderboardTItleWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LeaderboardTItleModel extends FlutterFlowModel<LeaderboardTItleWidget> {
  ///  Local state fields for this component.

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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
