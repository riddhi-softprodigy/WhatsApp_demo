import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_list_model.dart';
export 'chat_list_model.dart';

class ChatListWidget extends StatefulWidget {
  const ChatListWidget({Key? key}) : super(key: key);

  @override
  _ChatListWidgetState createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  late ChatListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatListModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            context.pushNamed('Activeuser');
          },
          backgroundColor: FlutterFlowTheme.of(context).secondary,
          elevation: 8.0,
          child: Icon(
            Icons.message_rounded,
            color: FlutterFlowTheme.of(context).accent4,
            size: 24.0,
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chat Messanger',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Roboto',
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.search_rounded,
                        color: FlutterFlowTheme.of(context).alternate,
                        size: 24.0,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.more_vert,
                        color: FlutterFlowTheme.of(context).alternate,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        context.pushNamed('Profile');
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: [],
            centerTitle: false,
            elevation: 2.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Column(
              children: [
                Align(
                  alignment: Alignment(0.0, 0),
                  child: TabBar(
                    labelColor: FlutterFlowTheme.of(context).primary,
                    unselectedLabelColor:
                        FlutterFlowTheme.of(context).secondary,
                    labelStyle: FlutterFlowTheme.of(context).bodyMedium,
                    indicatorColor: FlutterFlowTheme.of(context).secondary,
                    tabs: [
                      Tab(
                        text: 'CHATS',
                      ),
                      Tab(
                        text: 'STATUS',
                      ),
                      Tab(
                        text: 'CALLS',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      KeepAliveWidgetWrapper(
                        builder: (context) => Container(
                          width: MediaQuery.of(context).size.width * 1.0,
                          height: MediaQuery.of(context).size.height * 10.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: StreamBuilder<List<ChatsRecord>>(
                            stream: queryChatsRecord(
                              queryBuilder: (chatsRecord) =>
                                  chatsRecord.orderBy('last_message_time',
                                      descending: true),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 40.0,
                                    height: 40.0,
                                    child: CircularProgressIndicator(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                );
                              }
                              List<ChatsRecord> listViewChatsRecordList =
                                  snapshot.data!;
                              if (listViewChatsRecordList.isEmpty) {
                                return Center(
                                  child: Image.network(
                                    'data:image/jpeg;base64,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',
                                  ),
                                );
                              }
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                itemCount: listViewChatsRecordList.length,
                                itemBuilder: (context, listViewIndex) {
                                  final listViewChatsRecord =
                                      listViewChatsRecordList[listViewIndex];
                                  return Visibility(
                                    visible: (currentUserReference ==
                                            listViewChatsRecord.userA) ||
                                        (currentUserReference ==
                                            listViewChatsRecord.userB),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 5.0, 5.0, 5.0),
                                      child: StreamBuilder<UsersRecord>(
                                        stream: UsersRecord.getDocument(
                                            listViewChatsRecord.userB!),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 40.0,
                                                height: 40.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Color(0x00283BE2),
                                                ),
                                              ),
                                            );
                                          }
                                          final containerUsersRecord =
                                              snapshot.data!;
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                'Chat',
                                                queryParams: {
                                                  'userName': serializeParam(
                                                    containerUsersRecord
                                                        .displayName,
                                                    ParamType.String,
                                                  ),
                                                  'userEmail': serializeParam(
                                                    containerUsersRecord.email,
                                                    ParamType.String,
                                                  ),
                                                  'chatUser': serializeParam(
                                                    listViewChatsRecord
                                                        .reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                  'userRef': serializeParam(
                                                    currentUserReference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                  'userProfile': serializeParam(
                                                    containerUsersRecord
                                                        .photoUrl,
                                                    ParamType.String,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: Container(
                                              width: 100.0,
                                              height: 80.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  if (currentUserReference !=
                                                      listViewChatsRecord.user)
                                                    StreamBuilder<UsersRecord>(
                                                      stream: UsersRecord
                                                          .getDocument(
                                                              listViewChatsRecord
                                                                  .userA!),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 40.0,
                                                              height: 40.0,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Color(
                                                                    0x00283BE2),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        final circleImageUsersRecord =
                                                            snapshot.data!;
                                                        return Hero(
                                                          tag:
                                                              circleImageUsersRecord
                                                                  .photoUrl,
                                                          transitionOnUserGestures:
                                                              true,
                                                          child: Container(
                                                            width: 100.0,
                                                            height: 100.0,
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  circleImageUsersRecord
                                                                      .photoUrl,
                                                              fit: BoxFit
                                                                  .fitWidth,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  if (currentUserReference ==
                                                      listViewChatsRecord.user)
                                                    StreamBuilder<UsersRecord>(
                                                      stream: UsersRecord
                                                          .getDocument(
                                                              listViewChatsRecord
                                                                  .userB!),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 40.0,
                                                              height: 40.0,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Color(
                                                                    0x00283BE2),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        final circleImageUsersRecord =
                                                            snapshot.data!;
                                                        return Container(
                                                          width: 100.0,
                                                          height: 100.0,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                circleImageUsersRecord
                                                                    .photoUrl,
                                                            fit:
                                                                BoxFit.fitWidth,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (currentUserReference !=
                                                          listViewChatsRecord
                                                              .user)
                                                        StreamBuilder<
                                                            UsersRecord>(
                                                          stream: UsersRecord
                                                              .getDocument(
                                                                  listViewChatsRecord
                                                                      .userA!),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 40.0,
                                                                  height: 40.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Color(
                                                                        0x00283BE2),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            final textUsersRecord =
                                                                snapshot.data!;
                                                            return Text(
                                                              textUsersRecord
                                                                  .displayName,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                            );
                                                          },
                                                        ),
                                                      if (currentUserReference ==
                                                          listViewChatsRecord
                                                              .user)
                                                        StreamBuilder<
                                                            UsersRecord>(
                                                          stream: UsersRecord
                                                              .getDocument(
                                                                  listViewChatsRecord
                                                                      .userB!),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 40.0,
                                                                  height: 40.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Color(
                                                                        0x00283BE2),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            final textUsersRecord =
                                                                snapshot.data!;
                                                            return Text(
                                                              textUsersRecord
                                                                  .displayName,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                            );
                                                          },
                                                        ),
                                                      if (listViewChatsRecord
                                                              .lastMessage !=
                                                          'NA')
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      5.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            listViewChatsRecord
                                                                .lastMessage,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .accent2,
                                                                ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          dateTimeFormat(
                                                              'jm',
                                                              listViewChatsRecord
                                                                  .lastMessageTime!),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Roboto',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .accent2,
                                                                fontSize: 14.0,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      KeepAliveWidgetWrapper(
                        builder: (context) => Container(
                          width: MediaQuery.of(context).size.width * 1.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 5.0, 5.0, 5.0),
                                    child: Container(
                                      width: 100.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          AuthUserStreamWidget(
                                            builder: (context) => Container(
                                              width: 120.0,
                                              height: 120.0,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.network(
                                                currentUserPhoto,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'My Status',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  final selectedMedia =
                                                      await selectMedia(
                                                    maxWidth: 200.00,
                                                    maxHeight: 200.00,
                                                    imageQuality: 50,
                                                    mediaSource: MediaSource
                                                        .photoGallery,
                                                    multiImage: false,
                                                  );
                                                  if (selectedMedia != null &&
                                                      selectedMedia.every((m) =>
                                                          validateFileFormat(
                                                              m.storagePath,
                                                              context))) {
                                                    setState(() =>
                                                        _model.isDataUploading =
                                                            true);
                                                    var selectedUploadedFiles =
                                                        <FFUploadedFile>[];
                                                    var downloadUrls =
                                                        <String>[];
                                                    try {
                                                      showUploadMessage(
                                                        context,
                                                        'Uploading file...',
                                                        showLoading: true,
                                                      );
                                                      selectedUploadedFiles =
                                                          selectedMedia
                                                              .map((m) =>
                                                                  FFUploadedFile(
                                                                    name: m
                                                                        .storagePath
                                                                        .split(
                                                                            '/')
                                                                        .last,
                                                                    bytes:
                                                                        m.bytes,
                                                                    height: m
                                                                        .dimensions
                                                                        ?.height,
                                                                    width: m
                                                                        .dimensions
                                                                        ?.width,
                                                                    blurHash: m
                                                                        .blurHash,
                                                                  ))
                                                              .toList();

                                                      downloadUrls =
                                                          (await Future.wait(
                                                        selectedMedia.map(
                                                          (m) async =>
                                                              await uploadData(
                                                                  m.storagePath,
                                                                  m.bytes),
                                                        ),
                                                      ))
                                                              .where((u) =>
                                                                  u != null)
                                                              .map((u) => u!)
                                                              .toList();
                                                    } finally {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .hideCurrentSnackBar();
                                                      _model.isDataUploading =
                                                          false;
                                                    }
                                                    if (selectedUploadedFiles
                                                                .length ==
                                                            selectedMedia
                                                                .length &&
                                                        downloadUrls.length ==
                                                            selectedMedia
                                                                .length) {
                                                      setState(() {
                                                        _model.uploadedLocalFile =
                                                            selectedUploadedFiles
                                                                .first;
                                                        _model.uploadedFileUrl =
                                                            downloadUrls.first;
                                                      });
                                                      showUploadMessage(
                                                          context, 'Success!');
                                                    } else {
                                                      setState(() {});
                                                      showUploadMessage(context,
                                                          'Failed to upload data');
                                                      return;
                                                    }
                                                  }

                                                  final statusCreateData =
                                                      createStatusRecordData(
                                                    displayName:
                                                        currentUserDisplayName,
                                                    time: getCurrentTimestamp,
                                                    userRef:
                                                        currentUserReference,
                                                    statusUrl:
                                                        _model.uploadedFileUrl,
                                                  );
                                                  await StatusRecord.collection
                                                      .doc()
                                                      .set(statusCreateData);
                                                },
                                                child: Text(
                                                  'Tap to add the status',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    color: FlutterFlowTheme.of(context).accent4,
                                  ),
                                ],
                              ),
                              StreamBuilder<List<StatusRecord>>(
                                stream: queryStatusRecord(
                                  queryBuilder: (statusRecord) => statusRecord
                                      .orderBy('time', descending: true),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 40.0,
                                        height: 40.0,
                                        child: CircularProgressIndicator(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                        ),
                                      ),
                                    );
                                  }
                                  List<StatusRecord> columnStatusRecordList =
                                      snapshot.data!;
                                  if (columnStatusRecordList.isEmpty) {
                                    return Image.network(
                                      'data:image/jpeg;base64,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',
                                    );
                                  }
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                        columnStatusRecordList.length,
                                        (columnIndex) {
                                      final columnStatusRecord =
                                          columnStatusRecordList[columnIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 5.0, 5.0, 5.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              'Status',
                                              queryParams: {
                                                'userRef': serializeParam(
                                                  columnStatusRecord.userRef,
                                                  ParamType.DocumentReference,
                                                ),
                                                'pageIndex': serializeParam(
                                                  columnIndex,
                                                  ParamType.int,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1.0,
                                            height: 80.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                StreamBuilder<UsersRecord>(
                                                  stream:
                                                      UsersRecord.getDocument(
                                                          columnStatusRecord
                                                              .userRef!),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 40.0,
                                                          height: 40.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Color(
                                                                0x00283BE2),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    final circleImageUsersRecord =
                                                        snapshot.data!;
                                                    return InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        context.pushNamed(
                                                          'Status',
                                                          queryParams: {
                                                            'userRef':
                                                                serializeParam(
                                                              columnStatusRecord
                                                                  .userRef,
                                                              ParamType
                                                                  .DocumentReference,
                                                            ),
                                                            'pageIndex':
                                                                serializeParam(
                                                              columnIndex,
                                                              ParamType.int,
                                                            ),
                                                          }.withoutNulls,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: 120.0,
                                                        height: 120.0,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                          circleImageUsersRecord
                                                              .photoUrl,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      columnStatusRecord
                                                          .displayName,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                    Text(
                                                      dateTimeFormat(
                                                          'jm',
                                                          columnStatusRecord
                                                              .time!),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      KeepAliveWidgetWrapper(
                        builder: (context) => ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 5.0, 5.0, 5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70.0,
                                    height: 70.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_h5nToWbkX_B2hHHQfJScgYLo2Yc7cDSXRg&usqp=CAU',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Riddhi Tamrakar',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.arrow_downward_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              size: 17.0,
                                            ),
                                            Text(
                                              'Hours Ago',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Color(0xFF25D366),
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 5.0, 5.0, 5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70.0,
                                    height: 70.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlsnLFe2_AhQXJkVn1qY9ECg1zrt60SEkPfg&usqp=CAU',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '+00 5677899989',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.arrow_downward_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              size: 17.0,
                                            ),
                                            Text(
                                              'Hours Ago',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Color(0xFF25D366),
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 5.0, 5.0, 5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 70.0,
                                    height: 70.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUs73Mz3FqhV8uy2F5TGw_jGvFdzGirConJA&usqp=CAU',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '+91 456789023',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Roboto',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.arrow_downward_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              size: 17.0,
                                            ),
                                            Text(
                                              'Hours Ago',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Color(0xFF25D366),
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
