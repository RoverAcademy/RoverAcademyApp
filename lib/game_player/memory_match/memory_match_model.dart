import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'memory_match_widget.dart' show MemoryMatchWidget;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MemoryMatchModel extends FlutterFlowModel<MemoryMatchWidget> {
  ///  Local state fields for this page.

  int? totalTime = 0;

  List<String> terms = [];
  void addToTerms(String item) => terms.add(item);
  void removeFromTerms(String item) => terms.remove(item);
  void removeAtIndexFromTerms(int index) => terms.removeAt(index);
  void insertAtIndexInTerms(int index, String item) =>
      terms.insert(index, item);
  void updateTermsAtIndex(int index, Function(String) updateFn) =>
      terms[index] = updateFn(terms[index]);

  bool gameOver = false;

  String? timeFormatted = '00:00';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in MemoryMatch widget.
  List<QuestionsRecord>? unfilteredQ;
  // Stores action output result for [Firestore Query - Query a collection] action in MemoryMatch widget.
  List<QuestionsRecord>? filteredQ;
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
}
