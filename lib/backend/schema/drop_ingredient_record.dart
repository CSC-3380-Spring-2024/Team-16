import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class DropIngredientRecord extends FirestoreRecord {
  DropIngredientRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "ingredients" field.
  List<DocumentReference>? _ingredients;
  List<DocumentReference> get ingredients => _ingredients ?? const [];
  bool hasIngredients() => _ingredients != null;

  // "Apple" field.
  List<String>? _apple;
  List<String> get apple => _apple ?? const [];
  bool hasApple() => _apple != null;

  void _initializeFields() {
    _ingredients = getDataList(snapshotData['ingredients']);
    _apple = getDataList(snapshotData['Apple']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('DropIngredient');

  static Stream<DropIngredientRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DropIngredientRecord.fromSnapshot(s));

  static Future<DropIngredientRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DropIngredientRecord.fromSnapshot(s));

  static DropIngredientRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DropIngredientRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DropIngredientRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DropIngredientRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DropIngredientRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DropIngredientRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDropIngredientRecordData() {
  final firestoreData = mapToFirestore(
    <String, dynamic>{}.withoutNulls,
  );

  return firestoreData;
}

class DropIngredientRecordDocumentEquality
    implements Equality<DropIngredientRecord> {
  const DropIngredientRecordDocumentEquality();

  @override
  bool equals(DropIngredientRecord? e1, DropIngredientRecord? e2) {
    const listEquality = ListEquality();
    return listEquality.equals(e1?.ingredients, e2?.ingredients) &&
        listEquality.equals(e1?.apple, e2?.apple);
  }

  @override
  int hash(DropIngredientRecord? e) =>
      const ListEquality().hash([e?.ingredients, e?.apple]);

  @override
  bool isValidKey(Object? o) => o is DropIngredientRecord;
}
