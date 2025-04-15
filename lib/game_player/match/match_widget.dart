import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'match_model.dart';
export 'match_model.dart';

class MatchWidget extends StatefulWidget {
  const MatchWidget({
    super.key,
    required this.subject,
    required this.grade,
  });

  final int? subject;
  final int? grade;

  static String routeName = 'Match';
  static String routePath = '/match';

  @override
  State<MatchWidget> createState() => _MatchWidgetState();
}

class _MatchWidgetState extends State<MatchWidget> {
  late MatchModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MatchModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.randomIndexes = functions.randArrange().toList().cast<int>();
      _model.questions = await queryQuestionsRecordOnce(
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
      _model.terms = functions
          .getMatchTerms(_model.questions!.toList())
          .toList()
          .cast<String>();
      safeSetState(() {});
      _model.timerController.onStartTimer();
    });

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
              'Matching Game',
              style: FlutterFlowTheme.of(context).displaySmall.override(
                    fontFamily: 'Inter',
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            FlutterFlowTheme.of(context).primaryBackground,
                            Theme.of(context).brightness == Brightness.dark
                                ? FlutterFlowTheme.of(context).primaryBackground
                                : Color(0xFFFFFEE1),
                            Theme.of(context).brightness == Brightness.dark
                                ? FlutterFlowTheme.of(context).primaryBackground
                                : Color(0xFFFFD5A0)
                          ],
                          stops: [0.0, 0.5, 1.0],
                          begin: AlignmentDirectional(0.0, -1.0),
                          end: AlignmentDirectional(0, 1.0),
                        ),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: GridView(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 10.0,
                                        childAspectRatio: 1.0,
                                      ),
                                      scrollDirection: Axis.vertical,
                                      children: [
                                        if (!_model.hidden.elementAtOrNull(0)!)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await _model.onTileClick(
                                                context,
                                                index: 1,
                                              );
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width:
                                                      _model.selectedIndex == 1
                                                          ? 5.0
                                                          : 3.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.terms
                                                        .elementAtOrNull(_model
                                                            .randomIndexes
                                                            .firstOrNull!),
                                                    'Loading...',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF333333),
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!_model.hidden.elementAtOrNull(1)!)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await _model.onTileClick(
                                                context,
                                                index: 2,
                                              );
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width:
                                                      _model.selectedIndex == 2
                                                          ? 5.0
                                                          : 3.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.terms
                                                        .elementAtOrNull(_model
                                                            .randomIndexes
                                                            .elementAtOrNull(
                                                                1)!),
                                                    'Loading...',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF333333),
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!_model.hidden.elementAtOrNull(2)!)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await _model.onTileClick(
                                                context,
                                                index: 3,
                                              );
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width:
                                                      _model.selectedIndex == 3
                                                          ? 5.0
                                                          : 3.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.terms
                                                        .elementAtOrNull(_model
                                                            .randomIndexes
                                                            .elementAtOrNull(
                                                                2)!),
                                                    'Loading...',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF333333),
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!_model.hidden.elementAtOrNull(3)!)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await _model.onTileClick(
                                                context,
                                                index: 4,
                                              );
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width:
                                                      _model.selectedIndex == 4
                                                          ? 5.0
                                                          : 3.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.terms
                                                        .elementAtOrNull(_model
                                                            .randomIndexes
                                                            .elementAtOrNull(
                                                                3)!),
                                                    'Loading...',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF333333),
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!_model.hidden.elementAtOrNull(4)!)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await _model.onTileClick(
                                                context,
                                                index: 5,
                                              );
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width:
                                                      _model.selectedIndex == 5
                                                          ? 5.0
                                                          : 3.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.terms
                                                        .elementAtOrNull(_model
                                                            .randomIndexes
                                                            .elementAtOrNull(
                                                                4)!),
                                                    'Loading...',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF333333),
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!_model.hidden.elementAtOrNull(5)!)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await _model.onTileClick(
                                                context,
                                                index: 6,
                                              );
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width:
                                                      _model.selectedIndex == 6
                                                          ? 5.0
                                                          : 3.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.terms
                                                        .elementAtOrNull(_model
                                                            .randomIndexes
                                                            .elementAtOrNull(
                                                                5)!),
                                                    'Loading...',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF333333),
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!_model.hidden.elementAtOrNull(6)!)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await _model.onTileClick(
                                                context,
                                                index: 7,
                                              );
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width:
                                                      _model.selectedIndex == 7
                                                          ? 5.0
                                                          : 3.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.terms
                                                        .elementAtOrNull(_model
                                                            .randomIndexes
                                                            .elementAtOrNull(
                                                                6)!),
                                                    'Loading...',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF333333),
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!_model.hidden.elementAtOrNull(7)!)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await _model.onTileClick(
                                                context,
                                                index: 8,
                                              );
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width:
                                                      _model.selectedIndex == 8
                                                          ? 5.0
                                                          : 3.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.terms
                                                        .elementAtOrNull(_model
                                                            .randomIndexes
                                                            .elementAtOrNull(
                                                                7)!),
                                                    'Loading...',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF333333),
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!_model.hidden.elementAtOrNull(8)!)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await _model.onTileClick(
                                                context,
                                                index: 9,
                                              );
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width:
                                                      _model.selectedIndex == 9
                                                          ? 5.0
                                                          : 3.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.terms
                                                        .elementAtOrNull(_model
                                                            .randomIndexes
                                                            .elementAtOrNull(
                                                                8)!),
                                                    'Loading...',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF333333),
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!_model.hidden.elementAtOrNull(9)!)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await _model.onTileClick(
                                                context,
                                                index: 10,
                                              );
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width:
                                                      _model.selectedIndex == 10
                                                          ? 5.0
                                                          : 3.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.terms
                                                        .elementAtOrNull(_model
                                                            .randomIndexes
                                                            .elementAtOrNull(
                                                                9)!),
                                                    'Loading...',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF333333),
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!_model.hidden.elementAtOrNull(10)!)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await _model.onTileClick(
                                                context,
                                                index: 11,
                                              );
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width:
                                                      _model.selectedIndex == 11
                                                          ? 5.0
                                                          : 3.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.terms
                                                        .elementAtOrNull(_model
                                                            .randomIndexes
                                                            .elementAtOrNull(
                                                                10)!),
                                                    'Loading...',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF333333),
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (!_model.hidden.elementAtOrNull(11)!)
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              await _model.onTileClick(
                                                context,
                                                index: 12,
                                              );
                                              safeSetState(() {});
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width:
                                                      _model.selectedIndex == 12
                                                          ? 5.0
                                                          : 3.0,
                                                ),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  valueOrDefault<String>(
                                                    _model.terms
                                                        .elementAtOrNull(_model
                                                            .randomIndexes
                                                            .lastOrNull!),
                                                    'Loading...',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFF333333),
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 20.0, 20.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed(HomeWidget.routeName);
                                  },
                                  text: 'Exit',
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsets.all(0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Colors.black,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.81,
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              color: Color(0x00FFFFFF),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Container(
                                      width: 200.0,
                                      height: 200.0,
                                      child: Stack(
                                        children: [
                                          if (!_model.correct &&
                                              _model.gameStarted)
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/ChatGPT_Image_Apr_3,_2025,_01_46_27_PM_(1).png',
                                                width: 300.0,
                                                height: 300.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          if (_model.correct &&
                                              _model.gameStarted)
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/ChatGPT_Image_Apr_3,_2025,_01_09_59_PM_(1).png',
                                                width: 300.0,
                                                height: 300.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          if (!_model.gameStarted)
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 1.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/Match-icon.png',
                                                  width: 300.0,
                                                  height: 300.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Opacity(
                                    opacity: 0.0,
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.selectedIndex = 0;
                                          safeSetState(() {});
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (((List<bool> list) {
                        return list[0] &&
                            list[1] &&
                            list[2] &&
                            list[3] &&
                            list[4] &&
                            list[5] &&
                            list[6] &&
                            list[7] &&
                            list[8] &&
                            list[9] &&
                            list[10] &&
                            list[11];
                      }(_model.hidden.toList())) ||
                      (_model.timerMilliseconds != 0))
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            FlutterFlowTheme.of(context).primaryBackground,
                            Theme.of(context).brightness == Brightness.dark
                                ? FlutterFlowTheme.of(context).primaryBackground
                                : Color(0xFFFFFEE1),
                            Theme.of(context).brightness == Brightness.dark
                                ? FlutterFlowTheme.of(context).primaryBackground
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
                            opacity:
                                _model.timerMilliseconds > 2000 ? 1.0 : 0.0,
                            duration: 500.0.ms,
                            curve: Curves.easeInOut,
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                child: Text(
                                  'Match each question to its corresponding answer!',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .override(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: (_model.timerMilliseconds != 0) &&
                                    (_model.timerMilliseconds < 2000)
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
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          if (_model.timerMilliseconds < 2000)
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Lottie.asset(
                                'assets/jsons/Animation_-_1743645683801.json',
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: MediaQuery.sizeOf(context).height * 1.0,
                                fit: BoxFit.fill,
                                frameRate: FrameRate(30.0),
                                repeat: false,
                                animate: true,
                              ),
                            ),
                        ],
                      ),
                    ),
                  if ((List<bool> list) {
                    return list[0] &&
                        list[1] &&
                        list[2] &&
                        list[3] &&
                        list[4] &&
                        list[5] &&
                        list[6] &&
                        list[7] &&
                        list[8] &&
                        list[9] &&
                        list[10] &&
                        list[11];
                  }(_model.hidden.toList()))
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 0.0),
                                  child: Text(
                                    'Game Over!',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ),
                              Text(
                                'Your final score was: ${((List<bool> list) {
                                  return list
                                      .where((element) => element)
                                      .length;
                                }(_model.isMatched.toList())).toString()}/6',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 17.0,
                                      letterSpacing: 0.0,
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 30.0, 0.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            _model.score = valueOrDefault<int>(
                                              (List<bool> list) {
                                                return list
                                                    .where((element) => element)
                                                    .length;
                                              }(_model.isMatched.toList()),
                                              0,
                                            );
                                            safeSetState(() {});
                                            if (widget!.subject == 0) {
                                              await currentUserReference!
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'mathLargeScore':
                                                        FieldValue.increment(
                                                            _model.score!),
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
                                                              _model.score!),
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
                                                                _model.score!),
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
                                                                _model.score!),
                                                      },
                                                    ),
                                                  });
                                                }
                                              }
                                            }

                                            context.pushNamed(
                                                HomeWidget.routeName);

                                            unawaited(
                                              () async {
                                                await currentUserReference!.update(
                                                    createUserDetailsRecordData(
                                                  latestScore: _model.score,
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
                                              }(),
                                            );

                                            context.pushNamed(
                                                HomeWidget.routeName);
                                          },
                                          text: 'Quit',
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Colors.black,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
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
                                      alignment: AlignmentDirectional(1.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 40.0, 10.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            if (widget!.subject == 0) {
                                              await currentUserReference!
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'mathLargeScore':
                                                        FieldValue.increment(
                                                            _model.score!),
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
                                                              _model.score!),
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
                                                                _model.score!),
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
                                                                _model.score!),
                                                      },
                                                    ),
                                                  });
                                                }
                                              }
                                            }

                                            context.goNamed(
                                              MatchWidget.routeName,
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
                                          text: 'Replay',
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Colors.black,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
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
                  Opacity(
                    opacity: 0.0,
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: FlutterFlowTimer(
                        initialTime: _model.timerInitialTimeMs,
                        getDisplayTime: (value) =>
                            StopWatchTimer.getDisplayTime(
                          value,
                          hours: false,
                          milliSecond: false,
                        ),
                        controller: _model.timerController,
                        updateStateInterval: Duration(milliseconds: 1000),
                        onChanged: (value, displayTime, shouldUpdate) {
                          _model.timerMilliseconds = value;
                          _model.timerValue = displayTime;
                          if (shouldUpdate) safeSetState(() {});
                        },
                        onEnded: () async {
                          _model.timerController.onStopTimer();
                        },
                        textAlign: TextAlign.start,
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
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
    );
  }
}
