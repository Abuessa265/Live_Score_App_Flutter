import 'package:flutter/material.dart';

import '../../entities/football.dart';

class FootballScoreCard extends StatelessWidget {
  const FootballScoreCard({super.key, required this.football});
  final Football football;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTeam(football.team1Name, football.team1Score),
            const Text(
              'VS',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.blue),
            ),
            _buildTeam(football.team2Name, football.team2Score),
          ],
        ),
      ),
    );
  }

  Widget _buildTeam(String teamName, int score) {
    return Column(
      children: [
        Text(
          score.toString(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        Text(
          teamName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
