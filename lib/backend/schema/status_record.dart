import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StatusRecord extends FirestoreRecord {
  StatusRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "time" field.
  DateTime? _time;
  DateTime? get time => _time;
  bool hasTime() => _time != null;

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "statusUrl" field.
  String? _statusUrl;
  String get statusUrl => _statusUrl ?? '';
  bool hasStatusUrl() => _statusUrl != null;

  void _initializeFields() {
    _displayName = snapshotData['display_name'] as String?;
    _time = snapshotData['time'] as DateTime?;
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _statusUrl = snapshotData['statusUrl'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('status');

  static Stream<StatusRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => StatusRecord.fromSnapshot(s));

  static Future<StatusRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => StatusRecord.fromSnapshot(s));

  static StatusRecord fromSnapshot(DocumentSnapshot snapshot) => StatusRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static StatusRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      StatusRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'StatusRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createStatusRecordData({
  String? displayName,
  DateTime? time,
  DocumentReference? userRef,
  String? statusUrl,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'display_name': displayName,
      'time': time,
      'user_ref': userRef,
      'statusUrl': statusUrl,
    }.withoutNulls,
  );

  return firestoreData;
}
