import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'leaderboard_t_itle_model.dart';
export 'leaderboard_t_itle_model.dart';

class LeaderboardTItleWidget extends StatefulWidget {
  const LeaderboardTItleWidget({super.key});

  @override
  State<LeaderboardTItleWidget> createState() => _LeaderboardTItleWidgetState();
}

class _LeaderboardTItleWidgetState extends State<LeaderboardTItleWidget> {
  late LeaderboardTItleModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LeaderboardTItleModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).brightness == Brightness.dark
                ? FlutterFlowTheme.of(context).secondaryBackground
                : Color(0xFFFFF3E0),
            Theme.of(context).brightness == Brightness.dark
                ? FlutterFlowTheme.of(context).secondaryBackground
                : Color(0xFFD7CCC8)
          ],
          stops: [0.0, 1.0],
          begin: AlignmentDirectional(0.87, -1.0),
          end: AlignmentDirectional(-0.87, 1.0),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Align(
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.emoji_events,
                      color: Color(0xFFF9CF58),
                      size: 24.0,
                    ),
                    Text(
                      'Leaderboard',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Inter',
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                    Icon(
                      Icons.emoji_events,
                      color: Color(0xFFF9CF58),
                      size: 24.0,
                    ),
                  ].divide(SizedBox(width: 16.0)),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AuthUserStreamWidget(
                    builder: (context) => Text(
                      'Grade: ${_model.grades.elementAtOrNull(valueOrDefault(currentUserDocument?.gradeLevel, 0))}',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Readex Pro',
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 1.0)),
          ),
        ),
      ),
    );
  }
}
