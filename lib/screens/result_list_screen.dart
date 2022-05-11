import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imt_fix/screens/main_screen.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ResultListScreen extends StatefulWidget {
  const ResultListScreen({Key? key}) : super(key: key);

  @override
  State<ResultListScreen> createState() => _ResultListScreenState();
}

class _ResultListScreenState extends State<ResultListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ResultWidget());
  }
}

class ResultWidget extends StatefulWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
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
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 16),
                  child: Text(
                    'Журнал результатов:',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 175,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF1d1e33),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                                color: Colors.white,
                                height: 3,
                              ),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final DateTime date =
                                snapshot.data!.docs[index].get('date').toDate();
                            final ymd = DateFormat.yMMMMd('ru').format(date);

                            final hm = DateFormat.Hm('ru').format(date);

                            return Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '$ymd, ',
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '$hm, ',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '${snapshot.data!.docs[index].get('imt').toString().characters.getRange(0, 5)}',
                                      style: const TextStyle(
                                          fontSize: 22, color: Colors.green),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'вес: ${snapshot.data!.docs[index].get('weight').toString()} кг',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          'рост: ${snapshot.data!.docs[index].get('height').toInt().toString()} см',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                ),
                const BottomButtons()
              ],
            ),
          );
        });
  }
}

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: MaterialButton(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
              color: const Color(0xFFeb1555),
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainScreen()));
              },
              child: const Center(
                  child: Text(
                'Вернуться назад',
                style: TextStyle(fontSize: 25),
              )),
            ),
          ),
          Expanded(
            flex: 1,
            child: MaterialButton(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () async {
                final instance = FirebaseFirestore.instance;
                final batch = instance.batch();
                var collection = instance.collection('imt');
                var snapshots = await collection.get();
                for (var doc in snapshots.docs) {
                  batch.delete(doc.reference);
                }
                await batch.commit();
              },
              child: const Center(
                  child: Text(
                'Стереть',
                style: TextStyle(fontSize: 25),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
