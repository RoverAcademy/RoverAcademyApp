import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'puzzle_pop_widget.dart' show PuzzlePopWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PuzzlePopModel extends FlutterFlowModel<PuzzlePopWidget> {
  ///  Local state fields for this page.

  QuestionsRecord? problem;

  List<int> score = [0, 1];
  void addToScore(int item) => score.add(item);
  void removeFromScore(int item) => score.remove(item);
  void removeAtIndexFromScore(int index) => score.removeAt(index);
  void insertAtIndexInScore(int index, int item) => score.insert(index, item);
  void updateScoreAtIndex(int index, Function(int) updateFn) =>
      score[index] = updateFn(score[index]);

  List<QuestionsRecord> questionList = [];
  void addToQuestionList(QuestionsRecord item) => questionList.add(item);
  void removeFromQuestionList(QuestionsRecord item) =>
      questionList.remove(item);
  void removeAtIndexFromQuestionList(int index) => questionList.removeAt(index);
  void insertAtIndexInQuestionList(int index, QuestionsRecord item) =>
      questionList.insert(index, item);
  void updateQuestionListAtIndex(
          int index, Function(QuestionsRecord) updateFn) =>
      questionList[index] = updateFn(questionList[index]);

  bool gameOver = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in PuzzlePop widget.
  List<QuestionsRecord>? unfilteredQ;
  // Stores action output result for [Firestore Query - Query a collection] action in PuzzlePop widget.
  List<QuestionsRecord>? filteredQ;
  // State field(s) for Timer widget.
  final timerInitialTimeMs1 = 0;
  int timerMilliseconds1 = 0;
  String timerValue1 = StopWatchTimer.getDisplayTime(
    0,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController1 =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countUp));

  // State field(s) for Timer widget.
  final timerInitialTimeMs2 = 5000;
  int timerMilliseconds2 = 5000;
  String timerValue2 = StopWatchTimer.getDisplayTime(
    5000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController2 =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    timerController1.dispose();
    timerController2.dispose();
  }

  /// Action blocks.
  Future getQuestion(BuildContext context) async {
    QuestionsRecord? doc;

    doc = await QuestionsRecord.getDocumentOnce(questionList
        .elementAtOrNull(random_data.randomInteger(0, 99))!
        .reference);
    problem = doc;
  }
}
