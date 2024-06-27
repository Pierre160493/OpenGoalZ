import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opengoalz/classes/league.dart';
import 'package:opengoalz/classes/ranking.dart';
import 'package:opengoalz/global_variable.dart';
import 'package:opengoalz/pages/club_page.dart';
import 'package:opengoalz/widgets/appDrawer.dart';
import 'package:opengoalz/widgets/max_width_widget.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class RankingPage extends StatefulWidget {
  final int idLeague; // Add idLeague as an input parameter
  const RankingPage({Key? key, required this.idLeague}) : super(key: key);

  static Route<void> route(int idLeague) {
    return MaterialPageRoute<void>(
      builder: (context) => RankingPage(idLeague: idLeague),
    );
  }

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  Stream<League> _leagueStream = Stream.empty();
  late final Stream<List<Ranking>> _rankingStream;

  @override
  void initState() {
    // Fetch the league data
    _leagueStream = supabase
        .from('leagues')
        .stream(primaryKey: ['id'])
        .eq('id', widget.idLeague) // Access idLeague via widget
        .map((maps) => maps.map((map) => League.fromMap(map)).first);

    _rankingStream =
        _fetchRankingStream(widget.idLeague); // Access idLeague via widget

    super.initState();
  }

  Stream<List<Ranking>> _fetchRankingStream(int idLeague) async* {
    // Use id_league to make the query
    var query = supabase
        .from('view_ranking')
        .stream(primaryKey: ['id_club']).eq('id_league', idLeague);

    // Yield the result of the query
    yield* query
        .map((maps) => maps.map((map) => Ranking.fromMap(map)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<League>(
        stream: _leagueStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('ERROR: ${snapshot.error}'),
            );
          } else {
            League league = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text('Rankings Page for league ${league.id.toString()}'),
              ),
              drawer: const AppDrawer(),
              body: Column(
                children: [
                  Text(
                    'Rankings for league ${league.id.toString()}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text('Speed: ${league.multiverseSpeed.toString()}'),
                  Text('Season: ${league.seasonNumber.toString()}'),
                  MaxWidthContainer(
                    child: StreamBuilder<List<Ranking>>(
                      stream: _rankingStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('ERROR: ${snapshot.error}'),
                          );
                        } else {
                          final rankings = snapshot.data ?? [];
                          if (rankings.isEmpty) {
                            return const Center(
                              child: Text('ERROR: No rankings found'),
                            );
                          } else {
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('Pos')),
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Points')),
                                  DataColumn(label: Text('Goal Diff')),
                                  // DataColumn(label: Text('W')),
                                  // DataColumn(label: Text('T')),
                                  // DataColumn(label: Text('L')),
                                  // DataColumn(label: Text('+')),
                                  // DataColumn(label: Text('-')),
                                ],
                                rows: rankings.take(6).map((ranking) {
                                  final index = rankings.indexOf(ranking) + 1;
                                  var color =
                                      index.isOdd ? Colors.blueGrey : null;
                                  if (ranking.idClub ==
                                      Provider.of<SessionProvider>(context)
                                          .selectedClub
                                          .id_club) color = Colors.green;
                                  return DataRow(
                                    color: WidgetStateProperty.all(color),
                                    onSelectChanged: (_) {
                                      Navigator.push(
                                        context,
                                        ClubPage.route(ranking.idClub),
                                      );
                                    },
                                    cells: [
                                      DataCell(Text(index.toString())),
                                      DataCell(
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth:
                                                120, // Set the maximum width here
                                          ),
                                          child: Flexible(
                                            child: Text(ranking.nameClub,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 12)),
                                          ),
                                        ),
                                      ),

                                      DataCell(Row(
                                        children: [
                                          Text(
                                            ranking.nPoints.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(' '),
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            color: Colors
                                                .black, // Set the background color here
                                            child: Row(
                                              children: [
                                                Text(
                                                  ranking.nVictories.toString(),
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                Text(' / '),
                                                Text(
                                                  ranking.nDraws.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(' / '),
                                                Text(
                                                  ranking.nDefeats.toString(),
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                      // DataCell(Text(ranking.totalGoalAverage.toString())),
                                      DataCell(Row(
                                        children: [
                                          Text(
                                            ranking.totalGoalAverage.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(' '),
                                          Container(
                                            padding: EdgeInsets.all(4),
                                            color: Colors
                                                .black, // Set the background color here
                                            child: Row(
                                              children: [
                                                Text(
                                                  ranking.goalsScored
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                Text(' / '),
                                                Text(
                                                  ranking.goalsTaken.toString(),
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                      // DataCell(Text(ranking.nVictories.toString())),
                                      // DataCell(Text(ranking.nDraws.toString())),
                                      // DataCell(Text(ranking.nDefeats.toString())),
                                      // DataCell(Text(ranking.goalsScored.toString())),
                                      // DataCell(Text(ranking.goalsTaken.toString())),
                                    ],
                                  );
                                }).toList(),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
