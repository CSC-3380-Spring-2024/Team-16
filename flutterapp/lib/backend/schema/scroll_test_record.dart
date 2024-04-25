/*import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class ScrollTestRecord extends FirestoreRecord {
  ScrollTestRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "Test" field.
  List<String>? _test;
  List<String> get test => _test ?? const [];
  bool hasTest() => _test != null;

  void _initializeFields() {
    _test = getDataList(snapshotData['Test']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ScrollTest');

  static Stream<ScrollTestRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ScrollTestRecord.fromSnapshot(s));

  static Future<ScrollTestRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ScrollTestRecord.fromSnapshot(s));

  static ScrollTestRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ScrollTestRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ScrollTestRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ScrollTestRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ScrollTestRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ScrollTestRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createScrollTestRecordData() {
  final firestoreData = mapToFirestore(
    <String, dynamic>{}.withoutNulls,
  );

  return firestoreData;
}

class ScrollTestRecordDocumentEquality implements Equality<ScrollTestRecord> {
  const ScrollTestRecordDocumentEquality();

  @override
  bool equals(ScrollTestRecord? e1, ScrollTestRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.test, e2?.test);
  }

  @override
  int hash(ScrollTestRecord? e) => const ListEquality().hash([e?.test]);

  @override
  bool isValidKey(Object? o) => o is ScrollTestRecord;
}
*/