import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/blank_list_component/blank_list_component_widget.dart';
import '/components/chat/chat_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'rover_buddy_model.dart';
export 'rover_buddy_model.dart';

class RoverBuddyWidget extends StatefulWidget {
  const RoverBuddyWidget({super.key});

  static String routeName = 'RoverBuddy';
  static String routePath = '/roverBuddy';

  @override
  State<RoverBuddyWidget> createState() => _RoverBuddyWidgetState();
}

class _RoverBuddyWidgetState extends State<RoverBuddyWidget> {
  late RoverBuddyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RoverBuddyModel());

    _model.promptTextController ??= TextEditingController();
    _model.promptFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserDetailsRecord>(
      stream: UserDetailsRecord.getDocument(currentUserReference!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final roverBuddyUserDetailsRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              automaticallyImplyLeading: false,
              title: Align(
                alignment: AlignmentDirectional(-1.0, 0.0),
                child: Text(
                  currentUserEmail,
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
              actions: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(OptionsWidget.routeName);
                      },
                      child: Icon(
                        Icons.settings_rounded,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 35.0,
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                        begin: AlignmentDirectional(1.0, -1.0),
                        end: AlignmentDirectional(-1.0, 1.0),
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 770.0,
                        ),
                        decoration: BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 12.0, 24.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional(0.0, -1.0),
                                      child: Image.asset(
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? 'assets/images/logo-white.png'
                                            : 'assets/images/logo-black.png',
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.07,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 12.0, 0.0, 0.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                sigmaX: 5.0,
                                                sigmaY: 4.0,
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 7.0,
                                                        color:
                                                            Color(0x2F1D2429),
                                                        offset: Offset(
                                                          0.0,
                                                          3.0,
                                                        ),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    border: Border.all(
                                                      color: Colors.transparent,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, -1.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12.0,
                                                                  0.0,
                                                                  12.0,
                                                                  0.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final message = _model
                                                              .messages
                                                              .toList();
                                                          if (message.isEmpty) {
                                                            return Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  1.0,
                                                              child:
                                                                  BlankListComponentWidget(),
                                                            );
                                                          }

                                                          return ListView
                                                              .builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            reverse: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                message.length,
                                                            itemBuilder: (context,
                                                                messageIndex) {
                                                              final messageItem =
                                                                  message[
                                                                      messageIndex];
                                                              return Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            12.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    if (messageItem
                                                                            .role ==
                                                                        Role.user)
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(1.0, 0.0),
                                                                              child: ChatWidget(
                                                                                key: Key('Keyk8h_${messageIndex}_of_${message.length}'),
                                                                                messages: messageItem,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    if (messageItem
                                                                            .role ==
                                                                        Role.assistant)
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                              child: ChatWidget(
                                                                                key: Key('Key2ww_${messageIndex}_of_${message.length}'),
                                                                                messages: messageItem,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
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
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 12.0, 16.0, 24.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3.0,
                                      color: Color(0x33000000),
                                      offset: Offset(
                                        0.0,
                                        1.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 4.0, 10.0, 4.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 300.0,
                                          child: TextFormField(
                                            controller:
                                                _model.promptTextController,
                                            focusNode: _model.promptFocusNode,
                                            autofocus: true,
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            textInputAction:
                                                TextInputAction.send,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Your buddy is ready to answer any academic questions',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        letterSpacing: 0.0,
                                                      ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0x00000000),
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  letterSpacing: 0.0,
                                                ),
                                            maxLines: 3,
                                            minLines: 1,
                                            keyboardType:
                                                TextInputType.multiline,
                                            validator: _model
                                                .promptTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 30.0,
                                        borderWidth: 1.0,
                                        buttonSize: 60.0,
                                        icon: Icon(
                                          Icons.send_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          size: 30.0,
                                        ),
                                        showLoadingIndicator: true,
                                        onPressed: () async {
                                          if (_model.chatRef != null) {
                                            var messagesRecordReference1 =
                                                MessagesRecord.createDoc(
                                                    _model.chatRef!);
                                            await messagesRecordReference1
                                                .set(createMessagesRecordData(
                                              created: getCurrentTimestamp,
                                              role: Role.user,
                                              content: _model
                                                  .promptTextController.text,
                                            ));
                                            _model.ongoingChatNewMessage =
                                                MessagesRecord.getDocumentFromData(
                                                    createMessagesRecordData(
                                                      created:
                                                          getCurrentTimestamp,
                                                      role: Role.user,
                                                      content: _model
                                                          .promptTextController
                                                          .text,
                                                    ),
                                                    messagesRecordReference1);
                                            safeSetState(() {
                                              _model.promptTextController
                                                  ?.clear();
                                            });
                                            _model.ongoingChatUserMessage =
                                                await queryMessagesRecordOnce(
                                              parent: _model.chatRef,
                                              queryBuilder: (messagesRecord) =>
                                                  messagesRecord.orderBy(
                                                      'created',
                                                      descending: true),
                                            );
                                            _model.messages = _model
                                                .ongoingChatUserMessage!
                                                .toList()
                                                .cast<MessagesRecord>();
                                            safeSetState(() {});
                                            _model.ongoingChatResponse =
                                                await OpenAIAPICall.call(
                                              messagesJson: functions
                                                  .listMessagesToListJSON(
                                                      _model.messages.toList()),
                                            );

                                            if ((_model.ongoingChatResponse
                                                    ?.succeeded ??
                                                true)) {
                                              var messagesRecordReference2 =
                                                  MessagesRecord.createDoc(
                                                      _model.chatRef!);
                                              await messagesRecordReference2
                                                  .set(createMessagesRecordData(
                                                created: getCurrentTimestamp,
                                                role: Role.assistant,
                                                content: GptResponseStruct
                                                        .maybeFromMap((_model
                                                                .ongoingChatResponse
                                                                ?.jsonBody ??
                                                            ''))
                                                    ?.choices
                                                    ?.firstOrNull
                                                    ?.message
                                                    ?.content,
                                              ));
                                              _model.ongoingChatAssistantDoc =
                                                  MessagesRecord.getDocumentFromData(
                                                      createMessagesRecordData(
                                                        created:
                                                            getCurrentTimestamp,
                                                        role: Role.assistant,
                                                        content: GptResponseStruct
                                                                .maybeFromMap((_model
                                                                        .ongoingChatResponse
                                                                        ?.jsonBody ??
                                                                    ''))
                                                            ?.choices
                                                            ?.firstOrNull
                                                            ?.message
                                                            ?.content,
                                                      ),
                                                      messagesRecordReference2);
                                              _model.ongoingChatAllMessages =
                                                  await queryMessagesRecordOnce(
                                                parent: _model.chatRef,
                                                queryBuilder:
                                                    (messagesRecord) =>
                                                        messagesRecord.orderBy(
                                                            'created',
                                                            descending: true),
                                              );
                                              _model.messages = _model
                                                  .ongoingChatAllMessages!
                                                  .toList()
                                                  .cast<MessagesRecord>();
                                              safeSetState(() {});
                                            }
                                          } else {
                                            var chatsRecordReference =
                                                ChatsRecord.collection.doc();
                                            await chatsRecordReference
                                                .set(createChatsRecordData(
                                              uid: currentUserReference,
                                              timestamp: getCurrentTimestamp,
                                            ));
                                            _model.newChatDoc =
                                                ChatsRecord.getDocumentFromData(
                                                    createChatsRecordData(
                                                      uid: currentUserReference,
                                                      timestamp:
                                                          getCurrentTimestamp,
                                                    ),
                                                    chatsRecordReference);
                                            _model.chatRef =
                                                _model.newChatDoc?.reference;

                                            var messagesRecordReference3 =
                                                MessagesRecord.createDoc(
                                                    _model.chatRef!);
                                            await messagesRecordReference3
                                                .set(createMessagesRecordData(
                                              created: getCurrentTimestamp,
                                              role: Role.system,
                                              content:
                                                  'You are a study buddy for a learning app named RoverAcademy. Your job is to answer any questions relating to academic subjects like math, English, science, or social studies. The app is built in flutterflow and your messages will be displayed in a rich text widget, which does not support markdown. So make sure your responses are regular text messages, and include unicode characters if you need to. Do not use emojis. ',
                                            ));
                                            _model.aiInstructions = MessagesRecord
                                                .getDocumentFromData(
                                                    createMessagesRecordData(
                                                      created:
                                                          getCurrentTimestamp,
                                                      role: Role.system,
                                                      content:
                                                          'You are a study buddy for a learning app named RoverAcademy. Your job is to answer any questions relating to academic subjects like math, English, science, or social studies. The app is built in flutterflow and your messages will be displayed in a rich text widget, which does not support markdown. So make sure your responses are regular text messages, and include unicode characters if you need to. Do not use emojis. ',
                                                    ),
                                                    messagesRecordReference3);

                                            var messagesRecordReference4 =
                                                MessagesRecord.createDoc(
                                                    _model.chatRef!);
                                            await messagesRecordReference4
                                                .set(createMessagesRecordData(
                                              created: getCurrentTimestamp,
                                              role: Role.user,
                                              content: _model
                                                  .promptTextController.text,
                                            ));
                                            _model.newChatNewMessage =
                                                MessagesRecord.getDocumentFromData(
                                                    createMessagesRecordData(
                                                      created:
                                                          getCurrentTimestamp,
                                                      role: Role.user,
                                                      content: _model
                                                          .promptTextController
                                                          .text,
                                                    ),
                                                    messagesRecordReference4);
                                            safeSetState(() {
                                              _model.promptTextController
                                                  ?.clear();
                                            });
                                            _model.addToMessages(
                                                _model.aiInstructions!);
                                            _model.addToMessages(
                                                _model.newChatNewMessage!);
                                            safeSetState(() {});
                                            _model.newChatResponse =
                                                await OpenAIAPICall.call(
                                              messagesJson: functions
                                                  .listMessagesToListJSON(
                                                      _model.messages.toList()),
                                            );

                                            if ((_model.newChatResponse
                                                    ?.succeeded ??
                                                true)) {
                                              var messagesRecordReference5 =
                                                  MessagesRecord.createDoc(
                                                      _model.chatRef!);
                                              await messagesRecordReference5
                                                  .set(createMessagesRecordData(
                                                created: getCurrentTimestamp,
                                                role: Role.assistant,
                                                content: GptResponseStruct
                                                        .maybeFromMap((_model
                                                                .newChatResponse
                                                                ?.jsonBody ??
                                                            ''))
                                                    ?.choices
                                                    ?.firstOrNull
                                                    ?.message
                                                    ?.content,
                                              ));
                                              _model.newChatAssistantDoc =
                                                  MessagesRecord.getDocumentFromData(
                                                      createMessagesRecordData(
                                                        created:
                                                            getCurrentTimestamp,
                                                        role: Role.assistant,
                                                        content: GptResponseStruct
                                                                .maybeFromMap((_model
                                                                        .newChatResponse
                                                                        ?.jsonBody ??
                                                                    ''))
                                                            ?.choices
                                                            ?.firstOrNull
                                                            ?.message
                                                            ?.content,
                                                      ),
                                                      messagesRecordReference5);
                                              _model.newChatAllMessages =
                                                  await queryMessagesRecordOnce(
                                                parent: _model.chatRef,
                                                queryBuilder:
                                                    (messagesRecord) =>
                                                        messagesRecord.orderBy(
                                                            'created',
                                                            descending: true),
                                              );
                                              _model.messages = _model
                                                  .newChatAllMessages!
                                                  .toList()
                                                  .cast<MessagesRecord>();
                                              safeSetState(() {});
                                            }
                                          }

                                          safeSetState(() {});
                                        },
                                      ),
                                    ],
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
          ),
        );
      },
    );
  }
}
