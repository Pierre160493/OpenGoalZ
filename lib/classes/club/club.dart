//ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opengoalz/classes/game/class/game.dart';
import 'package:opengoalz/classes/league/league.dart';
import 'package:opengoalz/classes/player/players_page.dart';
import 'package:opengoalz/classes/teamComp.dart';
import 'package:opengoalz/constants.dart';
import 'package:opengoalz/pages/games_page.dart';
import 'package:opengoalz/pages/league_page.dart';
import 'package:opengoalz/pages/transfer_page.dart';
import 'package:opengoalz/provider_user.dart';
import 'package:opengoalz/pages/club_page.dart';
import 'package:opengoalz/classes/player/class/player.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'clubWidgetTeamcomp.dart';
part 'clubWidgetHelper.dart';
part 'clubWidgetFinances.dart';

class Club {
  List<TeamComp> teamComps = []; //List of the teamcomps of the club
  List<Game> games = []; //games of this club
  List<Player> players = []; // List of players of the club
  League? league; // League of the club
  int points = 0; // points of the club
  int victories = 0; // victories of the club
  int draws = 0; // draws of the club
  int defeats = 0; // defeats of the club
  int goalsScored = 0; // goals scored of the club
  int goalsTaken = 0; // goals taken of the club

  Club({
    required this.id,
    required this.createdAt,
    required this.multiverseSpeed,
    required this.idLeague,
    required this.userName,
    required this.nameClub,
    required this.staffExpanses,
    required this.lisCash,
    required this.lisRevenues,
    required this.lisSponsors,
    required this.lisExpanses,
    required this.lisTax,
    required this.lisPlayersExpanses,
    required this.lisStaffExpanses,
    required this.staffWeight,
    required this.numberFans,
    required this.idCountry,
    // required this.posSeason,
    // required this.posLastSeason,
    // required this.leaguePointsArray,
    required this.leaguePoints,
    // required this.lastResultsArray,
    required this.lastResult,
    required this.posLeague,
    required this.seasonNumber,
    required this.idLeagueNextSeason,
    this.posLeagueNextSeason,
  });

  final int id;
  final DateTime createdAt;
  final int multiverseSpeed;
  final int idLeague;
  final String? userName;
  final String nameClub;
  final int staffExpanses;
  final List<int> lisCash;
  final List<int> lisRevenues;
  final List<int> lisSponsors;
  final List<int> lisExpanses;
  final List<int> lisTax;
  final List<int> lisPlayersExpanses;
  final List<int> lisStaffExpanses;
  final double staffWeight;
  final int numberFans;
  final int idCountry;
  // final List<int>? posSeason;
  // final int? posLastSeason;
  // final List<double>? leaguePointsArray;
  final double leaguePoints;
  // final List<int>? lastResultsArray;
  final int? lastResult;
  final int posLeague;
  final int seasonNumber;
  final int? idLeagueNextSeason;
  final int? posLeagueNextSeason;

  Club.fromMap({required Map<String, dynamic> map
      // required String myUserId,
      })
      : id = map['id'],
        createdAt = DateTime.parse(map['created_at']),
        multiverseSpeed = map['multiverse_speed'],
        idLeague = map['id_league'],
        userName = map['username'],
        nameClub = map['name_club'],
        staffExpanses = map['staff_expanses'],
        lisCash = List<int>.from(map['lis_cash']),
        lisRevenues = List<int>.from(map['lis_revenues']),
        lisSponsors = List<int>.from(map['lis_sponsors']),
        lisExpanses = List<int>.from(map['lis_expanses']),
        lisTax = List<int>.from(map['lis_tax']),
        lisPlayersExpanses = List<int>.from(map['lis_players_expanses']),
        lisStaffExpanses = List<int>.from(map['lis_staff_expanses']),
        staffWeight = (map['staff_weight'] as num).toDouble(),
        numberFans = map['number_fans'],
        idCountry = map['id_country'],
        // posSeason = List<int>.from(map['posSeason'] ?? []),
        // posLastSeason = map['pos_last_season'],
        // leaguePointsArray = List<double>.from(map['league_points_array'] ?? []),
        leaguePoints = map['league_points'].toDouble(),
        // lastResultsArray = List<int>.from(map['last_results_array'] ?? []),
        lastResult = map['last_result'],
        posLeague = map['pos_league'],
        seasonNumber = map['season_number'],
        idLeagueNextSeason = map['id_league_next_season'],
        posLeagueNextSeason = map['pos_league_next_season'];
}