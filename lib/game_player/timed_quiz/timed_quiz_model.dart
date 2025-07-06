import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'timed_quiz_widget.dart' show TimedQuizWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class TimedQuizModel extends FlutterFlowModel<TimedQuizWidget> {
  ///  Local state fields for this page.

  QuestionsRecord? problem;

  List<int> score = [0, 1];
  void addToScore(int item) => score.add(item);
  void removeFromScore(int item) => score.remove(item);
  void removeAtIndexFromScore(int index) => score.removeAt(index);
  void insertAtIndexInScore(int index, int item) => score.insert(index, item);
  void updateScoreAtIndex(int index, Function(int) updateFn) =>
      score[index] = updateFn(score[index]);

  int timer = 20000;

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

  List<int> correct = [2, 2, 2, 2];
  void addToCorrect(int item) => correct.add(item);
  void removeFromCorrect(int item) => correct.remove(item);
  void removeAtIndexFromCorrect(int index) => correct.removeAt(index);
  void insertAtIndexInCorrect(int index, int item) =>
      correct.insert(index, item);
  void updateCorrectAtIndex(int index, Function(int) updateFn) =>
      correct[index] = updateFn(correct[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in TimedQuiz widget.
  List<QuestionsRecord>? unfilteredQ;
  // Stores action output result for [Firestore Query - Query a collection] action in TimedQuiz widget.
  List<QuestionsRecord>? filteredQ;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 0;
  int timerMilliseconds = 0;
  String timerValue = StopWatchTimer.getDisplayTime(
    0,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  // Stores action output result for [Action Block - VerifyAns] action in Button widget.
  bool? isCorrect;
  // Stores action output result for [Action Block - VerifyAns] action in Button widget.
  bool? isCorrect1;
  // Stores action output result for [Action Block - VerifyAns] action in Button widget.
  bool? isCorrect2;
  // Stores action output result for [Action Block - VerifyAns] action in Button widget.
  bool? isCorrect3;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    timerController.dispose();
  }

  /// Action blocks.
  /// Verifies correct answer when one of the options is selected and generates
  /// a new question
  Future<bool?> verifyAns(
    BuildContext context, {
    required int? option,
  }) async {
    if (problem?.correctAns == option) {
      updateScoreAtIndex(
        0,
        (e) => e + 1,
      );

      await currentUserReference!.update({
        ...mapToFirestore(
          {
            'currentStreak': FieldValue.increment(1),
            'mathLargeScore': FieldValue.increment((valueOrDefault(
                            currentUserDocument?.currentStreak, 0) >
                        1) &&
                    (valueOrDefault(currentUserDocument?.currentStreak, 0) <= 2)
                ? valueOrDefault(currentUserDocument?.mathLargeScore, 0)
                : 0),
          },
        ),
      });
      return true;
    } else {
      await currentUserReference!.update(createUserDetailsRecordData(
        currentStreak: 0,
      ));
      return false;
    }
  }

  Future getQuestion(BuildContext context) async {
    QuestionsRecord? doc;

    doc = await QuestionsRecord.getDocumentOnce(questionList
        .elementAtOrNull(random_data.randomInteger(0, 99))!
        .reference);
    problem = doc;
  }
}
