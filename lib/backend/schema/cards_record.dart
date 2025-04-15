import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CardsRecord extends FirestoreRecord {
  CardsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "isAnswer" field.
  bool? _isAnswer;
  bool get isAnswer => _isAnswer ?? false;
  bool hasIsAnswer() => _isAnswer != null;

  // "isSelected" field.
  bool? _isSelected;
  bool get isSelected => _isSelected ?? false;
  bool hasIsSelected() => _isSelected != null;

  // "isVisible" field.
  bool? _isVisible;
  bool get isVisible => _isVisible ?? false;
  bool hasIsVisible() => _isVisible != null;

  // "value" field.
  String? _value;
  String get value => _value ?? '';
  bool hasValue() => _value != null;

  void _initializeFields() {
    _isAnswer = snapshotData['isAnswer'] as bool?;
    _isSelected = snapshotData['isSelected'] as bool?;
    _isVisible = snapshotData['isVisible'] as bool?;
    _value = snapshotData['value'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cards');

  static Stream<CardsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CardsRecord.fromSnapshot(s));

  static Future<CardsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CardsRecord.fromSnapshot(s));

  static CardsRecord fromSnapshot(DocumentSnapshot snapshot) => CardsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CardsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CardsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CardsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CardsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCardsRecordData({
  bool? isAnswer,
  bool? isSelected,
  bool? isVisible,
  String? value,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'isAnswer': isAnswer,
      'isSelected': isSelected,
      'isVisible': isVisible,
      'value': value,
    }.withoutNulls,
  );

  return firestoreData;
}

class CardsRecordDocumentEquality implements Equality<CardsRecord> {
  const CardsRecordDocumentEquality();

  @override
  bool equals(CardsRecord? e1, CardsRecord? e2) {
    return e1?.isAnswer == e2?.isAnswer &&
        e1?.isSelected == e2?.isSelected &&
        e1?.isVisible == e2?.isVisible &&
        e1?.value == e2?.value;
  }

  @override
  int hash(CardsRecord? e) => const ListEquality()
      .hash([e?.isAnswer, e?.isSelected, e?.isVisible, e?.value]);

  @override
  bool isValidKey(Object? o) => o is CardsRecord;
}
