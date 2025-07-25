import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'timed_quiz_model.dart';
export 'timed_quiz_model.dart';

class TimedQuizWidget extends StatefulWidget {
  const TimedQuizWidget({
    super.key,
    required this.subject,
    required this.grade,
  });

  final int? subject;
  final int? grade;

  static String routeName = 'TimedQuiz';
  static String routePath = '/timedQuiz';

  @override
  State<TimedQuizWidget> createState() => _TimedQuizWidgetState();
}

class _TimedQuizWidgetState extends State<TimedQuizWidget>
    with TickerProviderStateMixin {
  late TimedQuizModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TimedQuizModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget!.subject == 4) {
        _model.unfilteredQ = await queryQuestionsRecordOnce(
          queryBuilder: (questionsRecord) => questionsRecord.where(
            'grade',
            isEqualTo: widget!.grade,
          ),
        );
        _model.questionList =
            _model.unfilteredQ!.toList().cast<QuestionsRecord>();
      } else {
        _model.filteredQ = await queryQuestionsRecordOnce(
          queryBuilder: (questionsRecord) => questionsRecord
              .where(
                'subject',
                isEqualTo: widget!.subject,
              )
              .where(
                'grade',
                isEqualTo: widget!.grade,
              ),
        );
        _model.questionList =
            _model.filteredQ!.toList().cast<QuestionsRecord>();
      }

      await _model.getQuestion(context);
      safeSetState(() {});
      _model.timerController.onStartTimer();
    });

    animationsMap.addAll({
      'buttonOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 1000.0.ms,
            begin: 1.0,
            end: 0.605,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Text(
              'Timed Quiz',
              style: FlutterFlowTheme.of(context).displaySmall.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).displaySmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).displaySmall.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).displaySmall.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).displaySmall.fontStyle,
                  ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  FlutterFlowTheme.of(context).primaryBackground,
                  Theme.of(context).brightness == Brightness.dark
                      ? Color(0xFF1A0000)
                      : Color(0xFFFFFEE1),
                  Theme.of(context).brightness == Brightness.dark
                      ? Color(0xFF330000)
                      : Color(0xFFFFD5A0)
                ],
                stops: [0.0, 0.5, 1.0],
                begin: AlignmentDirectional(0.0, -1.0),
                end: AlignmentDirectional(0, 1.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 30.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1.0, -1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30.0, 0.0, 0.0, 0.0),
                                    child: FlutterFlowTimer(
                                      initialTime: _model.timer,
                                      getDisplayTime: (value) =>
                                          StopWatchTimer.getDisplayTime(
                                        value,
                                        hours: false,
                                        milliSecond: false,
                                      ),
                                      controller: _model.timerController,
                                      updateStateInterval:
                                          Duration(milliseconds: 100),
                                      onChanged:
                                          (value, displayTime, shouldUpdate) {
                                        _model.timerMilliseconds = value;
                                        _model.timerValue = displayTime;
                                        if (shouldUpdate) safeSetState(() {});
                                      },
                                      onEnded: () async {
                                        _model.timerController.onStopTimer();
                                      },
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .displaySmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .displaySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .displaySmall
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentDirectional(1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: LinearPercentIndicator(
                                        percent: _model.timerMilliseconds >
                                                (_model.timer - 5000)
                                            ? 1.0
                                            : (_model.timerMilliseconds
                                                    .toDouble() /
                                                (_model.timer.toDouble() -
                                                    5000)),
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.6,
                                        lineHeight: 20.0,
                                        animation: true,
                                        animateFromLastPercent: true,
                                        progressColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .accent4,
                                        barRadius: Radius.circular(10.0),
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: valueOrDefault<String>(
                                      _model.problem?.question,
                                      'Loading...',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .displayLarge
                                        .override(
                                          font: GoogleFonts.roboto(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .displayLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .displayLarge
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 30.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .displayLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .displayLarge
                                                  .fontStyle,
                                        ),
                                  )
                                ],
                                style: FlutterFlowTheme.of(context)
                                    .displayLarge
                                    .override(
                                      font: GoogleFonts.roboto(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .displayLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .displayLarge
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 30.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .displayLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .displayLarge
                                          .fontStyle,
                                    ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                _model.timerController.onStopTimer();
                                _model.isCorrect = await _model.verifyAns(
                                  context,
                                  option: 0,
                                );
                                _model.updateCorrectAtIndex(
                                  _model.problem!.correctAns,
                                  (_) => 1,
                                );
                                _model.updateCorrectAtIndex(
                                  0,
                                  (_) => _model.isCorrect! ? 1 : 0,
                                );
                                safeSetState(() {});
                                await Future.delayed(
                                    const Duration(milliseconds: 2000));
                                _model.updateScoreAtIndex(
                                  1,
                                  (e) => e + 1,
                                );
                                await _model.getQuestion(context);
                                _model.correct = [2, 2, 2, 2];
                                safeSetState(() {});
                                _model.timerController.onStartTimer();

                                safeSetState(() {});
                              },
                              text: valueOrDefault<String>(
                                _model.problem?.option1,
                                'Loading...',
                              ),
                              options: FFButtonOptions(
                                width: 300.0,
                                height: 100.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: () {
                                  if (_model.correct.firstOrNull == 2) {
                                    return FlutterFlowTheme.of(context)
                                        .secondaryBackground;
                                  } else if (_model.correct.firstOrNull == 1) {
                                    return FlutterFlowTheme.of(context).success;
                                  } else {
                                    return FlutterFlowTheme.of(context).error;
                                  }
                                }(),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.readexPro(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: _model.correct.firstOrNull != 2
                                          ? Colors.white
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: _model.correct.firstOrNull != 2
                                      ? Colors.transparent
                                      : FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              showLoadingIndicator: false,
                            ).animateOnActionTrigger(
                              animationsMap['buttonOnActionTriggerAnimation']!,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                _model.timerController.onStopTimer();
                                _model.isCorrect1 = await _model.verifyAns(
                                  context,
                                  option: 1,
                                );
                                _model.updateCorrectAtIndex(
                                  _model.problem!.correctAns,
                                  (_) => 1,
                                );
                                _model.updateCorrectAtIndex(
                                  1,
                                  (_) => _model.isCorrect1! ? 1 : 0,
                                );
                                safeSetState(() {});
                                await Future.delayed(
                                    const Duration(milliseconds: 2000));
                                _model.updateScoreAtIndex(
                                  1,
                                  (e) => e + 1,
                                );
                                safeSetState(() {});
                                await _model.getQuestion(context);
                                _model.correct = [2, 2, 2, 2];
                                safeSetState(() {});
                                _model.timerController.onStartTimer();

                                safeSetState(() {});
                              },
                              text: valueOrDefault<String>(
                                _model.problem?.option2,
                                'Loading...',
                              ),
                              options: FFButtonOptions(
                                width: 300.0,
                                height: 100.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: () {
                                  if (_model.correct.elementAtOrNull(1) == 2) {
                                    return FlutterFlowTheme.of(context)
                                        .secondaryBackground;
                                  } else if (_model.correct
                                          .elementAtOrNull(1) ==
                                      1) {
                                    return FlutterFlowTheme.of(context).success;
                                  } else {
                                    return FlutterFlowTheme.of(context).error;
                                  }
                                }(),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.readexPro(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color:
                                          _model.correct.elementAtOrNull(1) != 2
                                              ? Colors.white
                                              : FlutterFlowTheme.of(context)
                                                  .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: _model.correct.elementAtOrNull(1) != 2
                                      ? Colors.transparent
                                      : FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              showLoadingIndicator: false,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                _model.timerController.onStopTimer();
                                _model.isCorrect2 = await _model.verifyAns(
                                  context,
                                  option: 2,
                                );
                                _model.updateCorrectAtIndex(
                                  _model.problem!.correctAns,
                                  (_) => 1,
                                );
                                _model.updateCorrectAtIndex(
                                  2,
                                  (_) => _model.isCorrect2! ? 1 : 0,
                                );
                                safeSetState(() {});
                                await Future.delayed(
                                    const Duration(milliseconds: 2000));
                                _model.updateScoreAtIndex(
                                  1,
                                  (e) => e + 1,
                                );
                                safeSetState(() {});
                                await _model.getQuestion(context);
                                _model.correct = [2, 2, 2, 2];
                                safeSetState(() {});
                                _model.timerController.onStartTimer();

                                safeSetState(() {});
                              },
                              text: valueOrDefault<String>(
                                _model.problem?.option3,
                                'Loading...',
                              ),
                              options: FFButtonOptions(
                                width: 300.0,
                                height: 100.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: () {
                                  if (_model.correct.elementAtOrNull(2) == 2) {
                                    return FlutterFlowTheme.of(context)
                                        .secondaryBackground;
                                  } else if (_model.correct
                                          .elementAtOrNull(2) ==
                                      1) {
                                    return FlutterFlowTheme.of(context).success;
                                  } else {
                                    return FlutterFlowTheme.of(context).error;
                                  }
                                }(),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.readexPro(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color:
                                          _model.correct.elementAtOrNull(2) != 2
                                              ? Colors.white
                                              : FlutterFlowTheme.of(context)
                                                  .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: _model.correct.elementAtOrNull(2) != 2
                                      ? Colors.transparent
                                      : FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              showLoadingIndicator: false,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                _model.timerController.onStopTimer();
                                _model.isCorrect3 = await _model.verifyAns(
                                  context,
                                  option: 3,
                                );
                                _model.updateCorrectAtIndex(
                                  _model.problem!.correctAns,
                                  (_) => 1,
                                );
                                _model.updateCorrectAtIndex(
                                  3,
                                  (_) => _model.isCorrect3! ? 1 : 0,
                                );
                                safeSetState(() {});
                                await Future.delayed(
                                    const Duration(milliseconds: 2000));
                                _model.updateScoreAtIndex(
                                  1,
                                  (e) => e + 1,
                                );
                                safeSetState(() {});
                                await _model.getQuestion(context);
                                _model.correct = [2, 2, 2, 2];
                                safeSetState(() {});
                                _model.timerController.onStartTimer();

                                safeSetState(() {});
                              },
                              text: valueOrDefault<String>(
                                _model.problem?.option4,
                                'Loading...',
                              ),
                              options: FFButtonOptions(
                                width: 300.0,
                                height: 100.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: () {
                                  if (_model.correct.lastOrNull == 2) {
                                    return FlutterFlowTheme.of(context)
                                        .secondaryBackground;
                                  } else if (_model.correct.lastOrNull == 1) {
                                    return FlutterFlowTheme.of(context).success;
                                  } else {
                                    return FlutterFlowTheme.of(context).error;
                                  }
                                }(),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.readexPro(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: _model.correct.lastOrNull != 2
                                          ? Colors.white
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: _model.correct.lastOrNull != 2
                                      ? Colors.transparent
                                      : FlutterFlowTheme.of(context).alternate,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              showLoadingIndicator: false,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      90.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Score: ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.readexPro(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 30.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                                Text(
                                  '${_model.score.firstOrNull?.toString()}/${_model.score.lastOrNull?.toString()}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.readexPro(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 30.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 20.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed(HomeWidget.routeName);
                                  },
                                  text: 'Exit',
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Colors.black,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.readexPro(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if ((_model.timerMilliseconds == 0) ||
                          (_model.timerMilliseconds > (_model.timer - 5000)))
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                FlutterFlowTheme.of(context).primaryBackground,
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color(0xFF1A0000)
                                    : Color(0xFFFFFEE1),
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color(0xFF330000)
                                    : Color(0xFFFFD5A0)
                              ],
                              stops: [0.0, 0.5, 1.0],
                              begin: AlignmentDirectional(0.0, -1.0),
                              end: AlignmentDirectional(0, 1.0),
                            ),
                          ),
                          child: Stack(
                            children: [
                              AnimatedOpacity(
                                opacity: _model.timerMilliseconds >
                                        (_model.timer - 3000)
                                    ? 1.0
                                    : 0.0,
                                duration: 500.0.ms,
                                curve: Curves.easeInOut,
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Text(
                                      'Answer as many questions as you possibly can!',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .displaySmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .displaySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .displaySmall
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                opacity: (_model.timerMilliseconds >
                                            (_model.timer - 5000)) &&
                                        (_model.timerMilliseconds <
                                            (_model.timer - 3000))
                                    ? 1.0
                                    : 0.0,
                                duration: 1000.0.ms,
                                curve: Curves.easeInOut,
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Text(
                                      'Good Luck!',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .displaySmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .displaySmall
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .displaySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .displaySmall
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              if (_model.timerMilliseconds <
                                  (_model.timer - 3000))
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Lottie.asset(
                                    'assets/jsons/Animation_-_1743645683801.json',
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height:
                                        MediaQuery.sizeOf(context).height * 1.0,
                                    fit: BoxFit.fill,
                                    frameRate: FrameRate(30.0),
                                    repeat: false,
                                    animate: true,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      if (_model.timerMilliseconds == 0)
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                            ),
                            child: Container(
                              width: 300.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 40.0,
                                    color: Color(0x33000000),
                                    offset: Offset(
                                      0.0,
                                      2.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, -1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Text(
                                        'Time\'s Up!',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Your final score was: ${_model.score.firstOrNull?.toString()}/${((_model.score.lastOrNull!) - 1).toString()}',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.readexPro(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 17.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Flexible(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 30.0, 0.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                if (widget!.subject == 0) {
                                                  await currentUserReference!
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'mathLargeScore':
                                                            FieldValue.increment(
                                                                _model.score
                                                                    .firstOrNull!),
                                                      },
                                                    ),
                                                  });
                                                } else {
                                                  if (widget!.subject == 1) {
                                                    await currentUserReference!
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'historyLargeScore':
                                                              FieldValue.increment(
                                                                  _model.score
                                                                      .firstOrNull!),
                                                        },
                                                      ),
                                                    });
                                                  } else {
                                                    if (widget!.subject == 2) {
                                                      await currentUserReference!
                                                          .update({
                                                        ...mapToFirestore(
                                                          {
                                                            'englishLargeScore':
                                                                FieldValue.increment(
                                                                    _model.score
                                                                        .firstOrNull!),
                                                          },
                                                        ),
                                                      });
                                                    } else {
                                                      await currentUserReference!
                                                          .update({
                                                        ...mapToFirestore(
                                                          {
                                                            'scienceLargeScore':
                                                                FieldValue.increment(
                                                                    _model.score
                                                                        .firstOrNull!),
                                                          },
                                                        ),
                                                      });
                                                    }
                                                  }
                                                }

                                                await currentUserReference!.update(
                                                    createUserDetailsRecordData(
                                                  latestScore:
                                                      _model.score.firstOrNull,
                                                  totalPoints: (valueOrDefault(
                                                              currentUserDocument
                                                                  ?.mathLargeScore,
                                                              0) +
                                                          valueOrDefault(
                                                              currentUserDocument
                                                                  ?.englishLargeScore,
                                                              0) +
                                                          valueOrDefault(
                                                              currentUserDocument
                                                                  ?.historyLargeScore,
                                                              0) +
                                                          valueOrDefault(
                                                              currentUserDocument
                                                                  ?.scienceLargeScore,
                                                              0))
                                                      .toInt(),
                                                ));

                                                context.pushNamed(
                                                    HomeWidget.routeName);
                                              },
                                              text: 'Quit',
                                              options: FFButtonOptions(
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color: Colors.black,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                                elevation: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 30.0, 10.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                if (widget!.subject == 0) {
                                                  await currentUserReference!
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'mathLargeScore':
                                                            FieldValue.increment(
                                                                _model.score
                                                                    .firstOrNull!),
                                                      },
                                                    ),
                                                  });
                                                } else {
                                                  if (widget!.subject == 1) {
                                                    await currentUserReference!
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'historyLargeScore':
                                                              FieldValue.increment(
                                                                  _model.score
                                                                      .firstOrNull!),
                                                        },
                                                      ),
                                                    });
                                                  } else {
                                                    if (widget!.subject == 2) {
                                                      await currentUserReference!
                                                          .update({
                                                        ...mapToFirestore(
                                                          {
                                                            'englishLargeScore':
                                                                FieldValue.increment(
                                                                    _model.score
                                                                        .firstOrNull!),
                                                          },
                                                        ),
                                                      });
                                                    } else {
                                                      await currentUserReference!
                                                          .update({
                                                        ...mapToFirestore(
                                                          {
                                                            'scienceLargeScore':
                                                                FieldValue.increment(
                                                                    _model.score
                                                                        .firstOrNull!),
                                                          },
                                                        ),
                                                      });
                                                    }
                                                  }
                                                }

                                                await currentUserReference!.update(
                                                    createUserDetailsRecordData(
                                                  latestScore:
                                                      _model.score.firstOrNull,
                                                ));

                                                context.goNamed(
                                                  TimedQuizWidget.routeName,
                                                  queryParameters: {
                                                    'subject': serializeParam(
                                                      widget!.subject,
                                                      ParamType.int,
                                                    ),
                                                    'grade': serializeParam(
                                                      widget!.grade,
                                                      ParamType.int,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              text: 'Play Again',
                                              options: FFButtonOptions(
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color: Colors.black,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                                elevation: 0.0,
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
