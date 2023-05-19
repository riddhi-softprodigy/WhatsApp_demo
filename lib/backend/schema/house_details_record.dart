import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HouseDetailsRecord extends FirestoreRecord {
  HouseDetailsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "HomeName" field.
  String? _homeName;
  String get homeName => _homeName ?? '';
  bool hasHomeName() => _homeName != null;

  // "Rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "Image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "Price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "Description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "Address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "big_image" field.
  String? _bigImage;
  String get bigImage => _bigImage ?? '';
  bool hasBigImage() => _bigImage != null;

  void _initializeFields() {
    _homeName = snapshotData['HomeName'] as String?;
    _rating = castToType<double>(snapshotData['Rating']);
    _image = snapshotData['Image'] as String?;
    _price = castToType<double>(snapshotData['Price']);
    _description = snapshotData['Description'] as String?;
    _address = snapshotData['Address'] as String?;
    _bigImage = snapshotData['big_image'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('house_details');

  static Stream<HouseDetailsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => HouseDetailsRecord.fromSnapshot(s));

  static Future<HouseDetailsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => HouseDetailsRecord.fromSnapshot(s));

  static HouseDetailsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      HouseDetailsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static HouseDetailsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      HouseDetailsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'HouseDetailsRecord(reference: ${reference.path}, data: $snapshotData)';
}

Map<String, dynamic> createHouseDetailsRecordData({
  String? homeName,
  double? rating,
  String? image,
  double? price,
  String? description,
  String? address,
  String? bigImage,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'HomeName': homeName,
      'Rating': rating,
      'Image': image,
      'Price': price,
      'Description': description,
      'Address': address,
      'big_image': bigImage,
    }.withoutNulls,
  );

  return firestoreData;
}
