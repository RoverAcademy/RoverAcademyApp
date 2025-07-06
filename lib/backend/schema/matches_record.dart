import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MatchesRecord extends FirestoreRecord {
  MatchesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "isActive" field.
  bool? _isActive;
  bool get isActive => _isActive ?? false;
  bool hasIsActive() => _isActive != null;

  // "player2id" field.
  DocumentReference? _player2id;
  DocumentReference? get player2id => _player2id;
  bool hasPlayer2id() => _player2id != null;

  // "player1id" field.
  DocumentReference? _player1id;
  DocumentReference? get player1id => _player1id;
  bool hasPlayer1id() => _player1id != null;

  // "grade" field.
  int? _grade;
  int get grade => _grade ?? 0;
  bool hasGrade() => _grade != null;

  // "player1score" field.
  int? _player1score;
  int get player1score => _player1score ?? 0;
  bool hasPlayer1score() => _player1score != null;

  // "player2score" field.
  int? _player2score;
  int get player2score => _player2score ?? 0;
  bool hasPlayer2score() => _player2score != null;

  // "questions" field.
  List<DocumentReference>? _questions;
  List<DocumentReference> get questions => _questions ?? const [];
  bool hasQuestions() => _questions != null;

  void _initializeFields() {
    _isActive = snapshotData['isActive'] as bool?;
    _player2id = snapshotData['player2id'] as DocumentReference?;
    _player1id = snapshotData['player1id'] as DocumentReference?;
    _grade = castToType<int>(snapshotData['grade']);
    _player1score = castToType<int>(snapshotData['player1score']);
    _player2score = castToType<int>(snapshotData['player2score']);
    _questions = getDataList(snapshotData['questions']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('matches');

  static Stream<MatchesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MatchesRecord.fromSnapshot(s));

  static Future<MatchesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MatchesRecord.fromSnapshot(s));

  static MatchesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MatchesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MatchesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MatchesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MatchesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MatchesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMatchesRecordData({
  bool? isActive,
  DocumentReference? player2id,
  DocumentReference? player1id,
  int? grade,
  int? player1score,
  int? player2score,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'isActive': isActive,
      'player2id': player2id,
      'player1id': player1id,
      'grade': grade,
      'player1score': player1score,
      'player2score': player2score,
    }.withoutNulls,
  );

  return firestoreData;
}

class MatchesRecordDocumentEquality implements Equality<MatchesRecord> {
  const MatchesRecordDocumentEquality();

  @override
  bool equals(MatchesRecord? e1, MatchesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.isActive == e2?.isActive &&
        e1?.player2id == e2?.player2id &&
        e1?.player1id == e2?.player1id &&
        e1?.grade == e2?.grade &&
        e1?.player1score == e2?.player1score &&
        e1?.player2score == e2?.player2score &&
        listEquality.equals(e1?.questions, e2?.questions);
  }

  @override
  int hash(MatchesRecord? e) => const ListEquality().hash([
        e?.isActive,
        e?.player2id,
        e?.player1id,
        e?.grade,
        e?.player1score,
        e?.player2score,
        e?.questions
      ]);

  @override
  bool isValidKey(Object? o) => o is MatchesRecord;
}
