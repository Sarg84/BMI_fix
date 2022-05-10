// import 'package:cloud_firestore/cloud_firestore.dart';

// class Json {
//   final double _imt;
//   final DateTime _date;
//   DocumentReference? ref;

//   Json(this._imt, this._date, this.ref);

//   Json.fromMap(Map<String, dynamic> map, {this.ref})
//       : _imt = map['imt'],
//         _date = map['date'];

//   Json.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(snapshot.data, ref: snapshot.reference);

//   double get imt => _imt;
//   DateTime get date => _date;
// }


// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:intl/intl.dart';

// // class FireApi {
// //   late String _imt;
// //   late DateTime _ymd;
// //   late DateTime _hm;

// //   String get imt => _imt;
// //   DateTime get ymd => _ymd;
// //   DateTime get hm => _hm;

// //   void getData() {
// //     final db = FirebaseFirestore.instance;
// //     db.collection('imt').doc().collection('imt').get().then((event) {
// //       for (var doc in event.docs) {
// //         final date = doc.get('date').toDate();
// //         final imt = doc.get('imt').toString();
// //         final ymd = DateFormat.yMd().format(date);
// //         final hm = DateFormat.Hm().format(date);
// //       }
// //     });
// //   }
// // }
