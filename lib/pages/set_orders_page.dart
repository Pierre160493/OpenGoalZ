import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opengoalz/classes/game.dart';
import 'package:opengoalz/classes/teamComp.dart';
import 'package:opengoalz/global_variable.dart';
import 'package:opengoalz/pages/players_page.dart';
import 'package:opengoalz/widgets/appBar.dart';
import 'package:provider/provider.dart';

import '../classes/player.dart';
import '../constants.dart';

class SetOrdersPage extends StatefulWidget {
  final Game game;
  const SetOrdersPage({Key? key, required this.game}) : super(key: key);

  static Route<void> route(Game game) {
    return MaterialPageRoute(
      builder: (context) => SetOrdersPage(game: game),
    );
  }

  @override
  State<SetOrdersPage> createState() => _SetOrdersPageState();
}

class _SetOrdersPageState extends State<SetOrdersPage> {
  late final Stream<List<TeamComp>> _teamCompStream;
  late final Stream<List<Player>> _playersStream;

  @override
  void initState() {
    _teamCompStream = supabase
        .from('games_team_comp')
        .stream(primaryKey: ['id'])
        .eq('id_game', widget.game.id)
        .map((maps) => maps.map((map) => TeamComp.fromMap(map)).toList());

    _playersStream = supabase
        .from('view_players')
        .stream(primaryKey: ['id'])
        .eq('id_club', widget.game.idClub)
        .map((maps) => maps
            .map((map) => Player.fromMap(
                map: map, myUserId: supabase.auth.currentUser!.id))
            .toList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TeamComp>>(
        stream: _teamCompStream,
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
            // Get list of team compositions (should be 2, one for each club)
            final teamComp = snapshot.data ?? [];
            // Find the index of the team composition for the currently selected club
            final index = teamComp.indexWhere((comp) =>
                comp.idClub ==
                Provider.of<SessionProvider>(context).selectedClub.id_club);
            return StreamBuilder<List<Player>>(
                stream: _playersStream,
                builder: (context, playersSnapshot) {
                  if (playersSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (playersSnapshot.hasError) {
                    return Center(
                      child: Text('ERROR: ${playersSnapshot.error}'),
                    );
                  } else {
                    final players = playersSnapshot.data ?? [];
                    return Scaffold(
                      appBar: CustomAppBar(
                        pageName:
                            'Set order for game ${widget.game.id}', // Accessing game data here
                      ),
                      // drawer: const AppDrawer(),
                      body: teamComp.length != 2
                          ? const Center(
                              child: Text(
                                'ERROR in the Database: Team composition must have exactly 2 entries, one for each club', // Error message
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              buildPlayerCard('LeftStriker',
                                                  teamComp[index], players),
                                              const SizedBox(width: 6.0),
                                              buildPlayerCard('CentralStriker',
                                                  teamComp[index], players),
                                              const SizedBox(width: 6.0),
                                              buildPlayerCard('RightStriker',
                                                  teamComp[index], players),
                                            ],
                                          ),
                                          const SizedBox(
                                              height:
                                                  6.0), // Add spacing between rows
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              buildPlayerCard('LeftWinger',
                                                  teamComp[index], players),
                                              const SizedBox(width: 6.0),
                                              buildPlayerCard('LeftMidFielder',
                                                  teamComp[index], players),
                                              const SizedBox(width: 6.0),
                                              buildPlayerCard(
                                                  'CentralMidFielder',
                                                  teamComp[index],
                                                  players),
                                              const SizedBox(width: 6.0),
                                              buildPlayerCard('RightMidFielder',
                                                  teamComp[index], players),
                                              const SizedBox(width: 6.0),
                                              buildPlayerCard('RightWinger',
                                                  teamComp[index], players),
                                            ],
                                          ),
                                          const SizedBox(
                                              height:
                                                  6.0), // Add spacing between rows
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              buildPlayerCard(
                                                  'LeftWingDefender',
                                                  teamComp[index],
                                                  players),
                                              const SizedBox(width: 6.0),
                                              buildPlayerCard(
                                                  'LeftCentralDefender',
                                                  teamComp[index],
                                                  players),
                                              const SizedBox(width: 6.0),
                                              buildPlayerCard('CentralDefender',
                                                  teamComp[index], players),
                                              const SizedBox(width: 6.0),
                                              buildPlayerCard(
                                                  'RightCentralDefender',
                                                  teamComp[index],
                                                  players),
                                              const SizedBox(width: 6.0),
                                              buildPlayerCard(
                                                  'RightWingDefender',
                                                  teamComp[index],
                                                  players),
                                            ],
                                          ),
                                          const SizedBox(
                                              height:
                                                  6.0), // Add spacing between rows
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              buildPlayerCard('GoalKeeper',
                                                  teamComp[index], players),
                                            ],
                                          ),
                                          // const SizedBox(
                                          //     height: 16.0), // Add spacing between rows
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.center,
                                          //   children: [
                                          //     buildPlayerCard('Substitute 1', teamComp[index].idSub1),
                                          //     buildPlayerCard('Substitute 2', teamComp[index].idSub2),
                                          //     buildPlayerCard('Substitute 3', teamComp[index].idSub3),
                                          //     buildPlayerCard('Substitute 4', teamComp[index].idSub4),
                                          //     buildPlayerCard('Substitute 5', teamComp[index].idSub5),
                                          //     buildPlayerCard('Substitute 6', teamComp[index].idSub6),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                    );
                  }
                });
          }
        });
  }

  Widget buildPlayerCard(
      String position, TeamComp teamComp, List<Player> players) {
    int? idPlayer;
    String strPositionInDB, strPositionInUI;

    switch (position) {
      case 'GoalKeeper':
        idPlayer = teamComp.idGoalKeeper;
        strPositionInDB = 'idgoalkeeper';
        strPositionInUI = 'GoalKeeper';
        break;
      case 'LeftWingDefender':
        idPlayer = teamComp.idLeftBackWinger;
        strPositionInDB = 'idleftbackwinger';
        strPositionInUI = 'Left Back';
        break;
      case 'LeftCentralDefender':
        idPlayer = teamComp.idLeftCentralBack;
        strPositionInDB = 'idleftcentralback';
        strPositionInUI = 'Central Def';
        break;
      case 'CentralDefender':
        idPlayer = teamComp.idCentralBack;
        strPositionInDB = 'idcentralback';
        strPositionInUI = 'Central Def';
        break;
      case 'RightCentralDefender':
        idPlayer = teamComp.idRightCentralBack;
        strPositionInDB = 'idrightcentralback';
        strPositionInUI = 'Central Def';
        break;
      case 'RightWingDefender':
        idPlayer = teamComp.idRightBackWinger;
        strPositionInDB = 'idrightbackwinger';
        strPositionInUI = 'Right Back';
        break;
      case 'LeftWinger':
        idPlayer = teamComp.idLeftWinger;
        strPositionInDB = 'idleftwinger';
        strPositionInUI = 'Left Winger';
        break;
      case 'LeftMidFielder':
        idPlayer = teamComp.idLeftMidFielder;
        strPositionInDB = 'idleftmidfielder';
        strPositionInUI = 'MidFielder';
        break;
      case 'CentralMidFielder':
        idPlayer = teamComp.idCentralMidFielder;
        strPositionInDB = 'idcentralmidfielder';
        strPositionInUI = 'MidFielder';
        break;
      case 'RightMidFielder':
        idPlayer = teamComp.idRightMidFielder;
        strPositionInDB = 'idrightmidfielder';
        strPositionInUI = 'MidFielder';
        break;
      case 'RightWinger':
        idPlayer = teamComp.idRightWinger;
        strPositionInDB = 'idrightwinger';
        strPositionInUI = 'Right Winger';
        break;
      case 'LeftStriker':
        idPlayer = teamComp.idLeftStriker;
        strPositionInDB = 'idleftstriker';
        strPositionInUI = 'Striker';
        break;
      case 'CentralStriker':
        idPlayer = teamComp.idCentralStriker;
        strPositionInDB = 'idcentralstriker';
        strPositionInUI = 'Striker';
        break;
      case 'RightStriker':
        idPlayer = teamComp.idRightStriker;
        strPositionInDB = 'idrightstriker';
        strPositionInUI = 'Striker';
        break;
      default:
        throw ArgumentError('Invalid position: $position');
    }

    final Player? player = idPlayer != null
        ? players.firstWhere(
            (player) => player.id == idPlayer,
          )
        : null;

    return GestureDetector(
      onTap: () async {
        final returnedId = await Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return PlayersPage(
                idClub: widget.game.idClub,
                isReturningId: true,
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
        );

        if (returnedId != null) {
          // Use the returnedId here as needed
          print('Returned player ID: $returnedId for game: ${teamComp.id}');

          await supabase
              .from('games_team_comp')
              .update({strPositionInDB: returnedId}).match({'id': teamComp.id});
        }
      },
      child: Container(
        color: player != null ? Colors.green : Colors.blueGrey,
        child: Column(
          children: [
            Text(strPositionInUI),
            Card(
              elevation: 3.0,
              child: Container(
                width: 100.0,
                height: 100.0,
                alignment: Alignment.center,
                child: player != null
                    ? Column(
                        children: [
                          const Icon(Icons.person,
                              size: 50, color: Colors.white),
                          Text(
                            '${player.first_name[0].toUpperCase()}.${player.last_name}',
                          ),
                        ],
                      )
                    : const Icon(Icons.add,
                        size: 50,
                        color: Colors
                            .white), // Placeholder icon when player is null
                // child: Text(idPlayer != null ? idPlayer.toString() : 'NONE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}