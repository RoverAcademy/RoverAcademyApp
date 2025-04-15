import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'match_widget.dart' show MatchWidget;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MatchModel extends FlutterFlowModel<MatchWidget> {
  ///  Local state fields for this page.

  int selectedIndex = 0;

  List<bool> isMatched = [false, false, false, false, false, false];
  void addToIsMatched(bool item) => isMatched.add(item);
  void removeFromIsMatched(bool item) => isMatched.remove(item);
  void removeAtIndexFromIsMatched(int index) => isMatched.removeAt(index);
  void insertAtIndexInIsMatched(int index, bool item) =>
      isMatched.insert(index, item);
  void updateIsMatchedAtIndex(int index, Function(bool) updateFn) =>
      isMatched[index] = updateFn(isMatched[index]);

  List<bool> hidden = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  void addToHidden(bool item) => hidden.add(item);
  void removeFromHidden(bool item) => hidden.remove(item);
  void removeAtIndexFromHidden(int index) => hidden.removeAt(index);
  void insertAtIndexInHidden(int index, bool item) =>
      hidden.insert(index, item);
  void updateHiddenAtIndex(int index, Function(bool) updateFn) =>
      hidden[index] = updateFn(hidden[index]);

  bool correct = false;

  int? score = 0;

  List<String> terms = [];
  void addToTerms(String item) => terms.add(item);
  void removeFromTerms(String item) => terms.remove(item);
  void removeAtIndexFromTerms(int index) => terms.removeAt(index);
  void insertAtIndexInTerms(int index, String item) =>
      terms.insert(index, item);
  void updateTermsAtIndex(int index, Function(String) updateFn) =>
      terms[index] = updateFn(terms[index]);

  List<int> randomIndexes = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  void addToRandomIndexes(int item) => randomIndexes.add(item);
  void removeFromRandomIndexes(int item) => randomIndexes.remove(item);
  void removeAtIndexFromRandomIndexes(int index) =>
      randomIndexes.removeAt(index);
  void insertAtIndexInRandomIndexes(int index, int item) =>
      randomIndexes.insert(index, item);
  void updateRandomIndexesAtIndex(int index, Function(int) updateFn) =>
      randomIndexes[index] = updateFn(randomIndexes[index]);

  bool gameStarted = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Match widget.
  List<QuestionsRecord>? questions;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 5000;
  int timerMilliseconds = 5000;
  String timerValue = StopWatchTimer.getDisplayTime(
    5000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    timerController.dispose();
  }

  /// Action blocks.
  Future onTileClick(
    BuildContext context, {
    /// The index of the tile that was clicked
    required int? index,
  }) async {
    if (selectedIndex == 0) {
      selectedIndex = index!;
    } else {
      if (selectedIndex != index) {
        updateHiddenAtIndex(
          (index!) - 1,
          (_) => true,
        );
        updateHiddenAtIndex(
          selectedIndex - 1,
          (_) => true,
        );
        if (random_data.randomInteger(0, 0) ==
            ((randomIndexes.elementAtOrNull(selectedIndex - 1)!) % 2)) {
          if ((randomIndexes.elementAtOrNull((index!) - 1)!) -
                  (randomIndexes.elementAtOrNull(selectedIndex - 1)!) ==
              1) {
            updateIsMatchedAtIndex(
              index! > selectedIndex ? (selectedIndex - 1) : ((index!) - 1),
              (_) => true,
            );
            correct = true;
          } else {
            correct = false;
          }
        } else {
          if ((randomIndexes.elementAtOrNull(selectedIndex - 1)!) -
                  (randomIndexes.elementAtOrNull((index!) - 1)!) ==
              1) {
            updateIsMatchedAtIndex(
              index! > selectedIndex ? (selectedIndex - 1) : ((index!) - 1),
              (_) => true,
            );
            correct = true;
          } else {
            correct = false;
          }
        }

        selectedIndex = 0;
        gameStarted = true;
      }
    }
  }
}
