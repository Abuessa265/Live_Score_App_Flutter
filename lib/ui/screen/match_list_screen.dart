import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../entities/football.dart';
import '../widgets/football_score_card.dart';

class MatchListScreen extends StatefulWidget {
  const MatchListScreen({super.key});

  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Football> matchList = [];

  Future<void> _getFootballMaster() async {
    matchList.clear();
    final QuerySnapshot result =
        await firebaseFirestore.collection('football').get();
    for (QueryDocumentSnapshot doc in result.docs) {
      matchList.add(
        Football(
          matchName: doc.id,
          team1Name: doc.get('team1Name'),
          team2Name: doc.get('team2Name'),
          team1Score: doc.get('team1'),
          team2Score: doc.get('team2'),
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getFootballMaster();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Football"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: firebaseFirestore.collection('football').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData == false) {
              return Center(
                child: Text('Empty List'),
              );
            }

            matchList.clear();
            for (QueryDocumentSnapshot doc in snapshot.data?.docs ?? []) {
              matchList.add(
                Football(
                  matchName: doc.id,
                  team1Name: doc.get('team1Name'),
                  team2Name: doc.get('team2Name'),
                  team1Score: doc.get('team1'),
                  team2Score: doc.get('team2'),
                ),
              );
            }

            return ListView.builder(
                itemCount: matchList.length,
                itemBuilder: (context, index) {
                  return FootballScoreCard(
                    football: matchList[index],
                  );
                });
          }),
    );
  }
}
