import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuestionsRecord extends FirestoreRecord {
  QuestionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "correctAns" field.
  int? _correctAns;
  int get correctAns => _correctAns ?? 0;
  bool hasCorrectAns() => _correctAns != null;

  // "option1" field.
  String? _option1;
  String get option1 => _option1 ?? '';
  bool hasOption1() => _option1 != null;

  // "option2" field.
  String? _option2;
  String get option2 => _option2 ?? '';
  bool hasOption2() => _option2 != null;

  // "option3" field.
  String? _option3;
  String get option3 => _option3 ?? '';
  bool hasOption3() => _option3 != null;

  // "option4" field.
  String? _option4;
  String get option4 => _option4 ?? '';
  bool hasOption4() => _option4 != null;

  // "question" field.
  String? _question;
  String get question => _question ?? '';
  bool hasQuestion() => _question != null;

  // "subject" field.
  int? _subject;
  int get subject => _subject ?? 0;
  bool hasSubject() => _subject != null;

  // "grade" field.
  int? _grade;
  int get grade => _grade ?? 0;
  bool hasGrade() => _grade != null;

  void _initializeFields() {
    _correctAns = castToType<int>(snapshotData['correctAns']);
    _option1 = snapshotData['option1'] as String?;
    _option2 = snapshotData['option2'] as String?;
    _option3 = snapshotData['option3'] as String?;
    _option4 = snapshotData['option4'] as String?;
    _question = snapshotData['question'] as String?;
    _subject = castToType<int>(snapshotData['subject']);
    _grade = castToType<int>(snapshotData['grade']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('questions');

  static Stream<QuestionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => QuestionsRecord.fromSnapshot(s));

  static Future<QuestionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => QuestionsRecord.fromSnapshot(s));

  static QuestionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      QuestionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static QuestionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      QuestionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'QuestionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is QuestionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createQuestionsRecordData({
  int? correctAns,
  String? option1,
  String? option2,
  String? option3,
  String? option4,
  String? question,
  int? subject,
  int? grade,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'correctAns': correctAns,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      'question': question,
      'subject': subject,
      'grade': grade,
    }.withoutNulls,
  );

  return firestoreData;
}

class QuestionsRecordDocumentEquality implements Equality<QuestionsRecord> {
  const QuestionsRecordDocumentEquality();

  @override
  bool equals(QuestionsRecord? e1, QuestionsRecord? e2) {
    return e1?.correctAns == e2?.correctAns &&
        e1?.option1 == e2?.option1 &&
        e1?.option2 == e2?.option2 &&
        e1?.option3 == e2?.option3 &&
        e1?.option4 == e2?.option4 &&
        e1?.question == e2?.question &&
        e1?.subject == e2?.subject &&
        e1?.grade == e2?.grade;
  }

  @override
  int hash(QuestionsRecord? e) => const ListEquality().hash([
        e?.correctAns,
        e?.option1,
        e?.option2,
        e?.option3,
        e?.option4,
        e?.question,
        e?.subject,
        e?.grade
      ]);

  @override
  bool isValidKey(Object? o) => o is QuestionsRecord;
}
