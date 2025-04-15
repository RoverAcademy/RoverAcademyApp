import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserDetailsRecord extends FirestoreRecord {
  UserDetailsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  bool hasPassword() => _password != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "currentStreak" field.
  int? _currentStreak;
  int get currentStreak => _currentStreak ?? 0;
  bool hasCurrentStreak() => _currentStreak != null;

  // "mathLargeScore" field.
  int? _mathLargeScore;
  int get mathLargeScore => _mathLargeScore ?? 0;
  bool hasMathLargeScore() => _mathLargeScore != null;

  // "lastGameWasMath" field.
  bool? _lastGameWasMath;
  bool get lastGameWasMath => _lastGameWasMath ?? false;
  bool hasLastGameWasMath() => _lastGameWasMath != null;

  // "historyLargeScore" field.
  int? _historyLargeScore;
  int get historyLargeScore => _historyLargeScore ?? 0;
  bool hasHistoryLargeScore() => _historyLargeScore != null;

  // "gradeLevel" field.
  int? _gradeLevel;
  int get gradeLevel => _gradeLevel ?? 0;
  bool hasGradeLevel() => _gradeLevel != null;

  // "englishLargeScore" field.
  int? _englishLargeScore;
  int get englishLargeScore => _englishLargeScore ?? 0;
  bool hasEnglishLargeScore() => _englishLargeScore != null;

  // "scienceLargeScore" field.
  int? _scienceLargeScore;
  int get scienceLargeScore => _scienceLargeScore ?? 0;
  bool hasScienceLargeScore() => _scienceLargeScore != null;

  // "latestScore" field.
  int? _latestScore;
  int get latestScore => _latestScore ?? 0;
  bool hasLatestScore() => _latestScore != null;

  // "lastGameWasReading" field.
  bool? _lastGameWasReading;
  bool get lastGameWasReading => _lastGameWasReading ?? false;
  bool hasLastGameWasReading() => _lastGameWasReading != null;

  // "lastGameWasHistory" field.
  bool? _lastGameWasHistory;
  bool get lastGameWasHistory => _lastGameWasHistory ?? false;
  bool hasLastGameWasHistory() => _lastGameWasHistory != null;

  // "totalPoints" field.
  int? _totalPoints;
  int get totalPoints => _totalPoints ?? 0;
  bool hasTotalPoints() => _totalPoints != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _password = snapshotData['password'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _displayName = snapshotData['display_name'] as String?;
    _currentStreak = castToType<int>(snapshotData['currentStreak']);
    _mathLargeScore = castToType<int>(snapshotData['mathLargeScore']);
    _lastGameWasMath = snapshotData['lastGameWasMath'] as bool?;
    _historyLargeScore = castToType<int>(snapshotData['historyLargeScore']);
    _gradeLevel = castToType<int>(snapshotData['gradeLevel']);
    _englishLargeScore = castToType<int>(snapshotData['englishLargeScore']);
    _scienceLargeScore = castToType<int>(snapshotData['scienceLargeScore']);
    _latestScore = castToType<int>(snapshotData['latestScore']);
    _lastGameWasReading = snapshotData['lastGameWasReading'] as bool?;
    _lastGameWasHistory = snapshotData['lastGameWasHistory'] as bool?;
    _totalPoints = castToType<int>(snapshotData['totalPoints']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('userDetails');

  static Stream<UserDetailsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UserDetailsRecord.fromSnapshot(s));

  static Future<UserDetailsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UserDetailsRecord.fromSnapshot(s));

  static UserDetailsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UserDetailsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UserDetailsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UserDetailsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UserDetailsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UserDetailsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUserDetailsRecordData({
  String? email,
  String? password,
  String? photoUrl,
  String? uid,
  String? phoneNumber,
  DateTime? createdTime,
  String? displayName,
  int? currentStreak,
  int? mathLargeScore,
  bool? lastGameWasMath,
  int? historyLargeScore,
  int? gradeLevel,
  int? englishLargeScore,
  int? scienceLargeScore,
  int? latestScore,
  bool? lastGameWasReading,
  bool? lastGameWasHistory,
  int? totalPoints,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'password': password,
      'photo_url': photoUrl,
      'uid': uid,
      'phone_number': phoneNumber,
      'created_time': createdTime,
      'display_name': displayName,
      'currentStreak': currentStreak,
      'mathLargeScore': mathLargeScore,
      'lastGameWasMath': lastGameWasMath,
      'historyLargeScore': historyLargeScore,
      'gradeLevel': gradeLevel,
      'englishLargeScore': englishLargeScore,
      'scienceLargeScore': scienceLargeScore,
      'latestScore': latestScore,
      'lastGameWasReading': lastGameWasReading,
      'lastGameWasHistory': lastGameWasHistory,
      'totalPoints': totalPoints,
    }.withoutNulls,
  );

  return firestoreData;
}

class UserDetailsRecordDocumentEquality implements Equality<UserDetailsRecord> {
  const UserDetailsRecordDocumentEquality();

  @override
  bool equals(UserDetailsRecord? e1, UserDetailsRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.password == e2?.password &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.createdTime == e2?.createdTime &&
        e1?.displayName == e2?.displayName &&
        e1?.currentStreak == e2?.currentStreak &&
        e1?.mathLargeScore == e2?.mathLargeScore &&
        e1?.lastGameWasMath == e2?.lastGameWasMath &&
        e1?.historyLargeScore == e2?.historyLargeScore &&
        e1?.gradeLevel == e2?.gradeLevel &&
        e1?.englishLargeScore == e2?.englishLargeScore &&
        e1?.scienceLargeScore == e2?.scienceLargeScore &&
        e1?.latestScore == e2?.latestScore &&
        e1?.lastGameWasReading == e2?.lastGameWasReading &&
        e1?.lastGameWasHistory == e2?.lastGameWasHistory &&
        e1?.totalPoints == e2?.totalPoints;
  }

  @override
  int hash(UserDetailsRecord? e) => const ListEquality().hash([
        e?.email,
        e?.password,
        e?.photoUrl,
        e?.uid,
        e?.phoneNumber,
        e?.createdTime,
        e?.displayName,
        e?.currentStreak,
        e?.mathLargeScore,
        e?.lastGameWasMath,
        e?.historyLargeScore,
        e?.gradeLevel,
        e?.englishLargeScore,
        e?.scienceLargeScore,
        e?.latestScore,
        e?.lastGameWasReading,
        e?.lastGameWasHistory,
        e?.totalPoints
      ]);

  @override
  bool isValidKey(Object? o) => o is UserDetailsRecord;
}
