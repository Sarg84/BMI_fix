// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Stream {
  final Widget child;
  Stream({
    required this.child,
  });

  builder(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    final stream = FirebaseFirestore.instance
        .collection('imt')
        .orderBy('date', descending: true)
        .snapshots();
    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text('0');
          }
          return child;
        });
  }
}
