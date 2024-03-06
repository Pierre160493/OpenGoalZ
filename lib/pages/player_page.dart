import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opengoalz/widgets/appBar.dart';
import 'package:opengoalz/widgets/appDrawer.dart';
import 'package:opengoalz/widgets/player_card_single.dart';

import '../classes/player.dart';
import '../constants.dart';

class PlayerPage extends StatefulWidget {
  final int idPlayer;

  const PlayerPage({Key? key, required this.idPlayer}) : super(key: key);

  static Route<void> route(int idPlayer) {
    return MaterialPageRoute<void>(
      builder: (context) => PlayerPage(idPlayer: idPlayer),
    );
  }

  @override
  State<PlayerPage> createState() => _HomePageState();
}

class _HomePageState extends State<PlayerPage> {
  late final Stream<List<Player>> _playerStream;

  @override
  void initState() {
    final myUserId = supabase.auth.currentUser!.id;

    _playerStream = _fetchPlayersStream(myUserId, widget.idPlayer);

    super.initState();
  }

  Stream<List<Player>> _fetchPlayersStream(String myUserId, int idPlayer) {
    var query = supabase
        .from('view_players')
        .stream(primaryKey: ['id'])
        .eq('id', idPlayer)
        .order('created_at');

    return query.map((maps) => maps
        .map((map) => Player.fromMap(map: map, myUserId: myUserId))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        pageName: 'Player Page',
      ),
      // drawer: const AppDrawer(),
      body: StreamBuilder<List<Player>>(
        stream: _playerStream,
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
            final players = snapshot.data ?? [];
            if (players.isEmpty) {
              return const Center(
                child: Text('ERROR: No players found'),
              );
            }
            if (players.length != 1) {
              return Center(
                child: Text('ERROR: ${players.length} players found'),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: players.length,
                      itemBuilder: (context, index) {
                        final player = players[index];
                        return PlayerCardSingle(player: player);
                      },
                    ),
                  )
                ],
              );
            }
          }
        },
      ),
    );
  }
}