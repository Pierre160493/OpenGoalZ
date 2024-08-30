// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:opengoalz/models/club/club.dart';
import 'package:opengoalz/models/club/getClubNameWidget.dart';
import 'package:opengoalz/models/transfer_bid.dart';
import 'package:opengoalz/constants.dart';
import 'package:opengoalz/extensionBuildContext.dart';
import 'package:opengoalz/postgresql_requests.dart';
import 'package:opengoalz/provider_user.dart';
import 'package:opengoalz/models/player/players_page.dart';
import 'package:opengoalz/widgets/countryStreamWidget.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart'
    as flutter_radar_chart;

part 'player_widget_helper.dart';
part 'player_widget_transfer.dart';
part 'player_widget_actions.dart';
part 'player_card_details.dart';
part 'player_card_stats.dart';
part 'player_card_history.dart';
part 'player_expanses_history.dart';
// part 'player_card_widget.dart';

class Player {
  Club? club;
  List<TransferBid> transferBids = [];

  Player({
    required this.id,
    required this.created_at,
    required this.idClub,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.surName,
    required this.shirtNumber,
    required this.dateBirth,
    required this.idMultiverse,
    required this.multiverseSpeed2,
    required this.idCountry,
    required this.expanses,
    required this.trainingPoints,
    required this.keeper,
    required this.defense,
    required this.playmaking,
    required this.passes,
    required this.scoring,
    required this.freekick,
    required this.winger,
    required this.dateEndInjury,
    required this.dateFiring,
    required this.dateSell,
    required this.dateArrival,
    required this.stamina,
    required this.form,
    required this.experience,
    required this.notes,
  });

  final int id;
  final DateTime created_at;
  final int? idClub;
  final String? userName;
  final String firstName;
  final String lastName;
  final String? surName;
  final int? shirtNumber;
  final DateTime dateBirth;
  final int idMultiverse;
  final int multiverseSpeed2;
  final int? idCountry; //Shouldn't be nullable
  final int expanses;
  final double trainingPoints;
  final double keeper;
  final double defense;
  final double playmaking;
  final double passes;
  final double scoring;
  final double freekick;
  final double winger;
  final DateTime? dateEndInjury;
  final DateTime? dateFiring;
  final DateTime? dateSell;
  final DateTime dateArrival;
  final double stamina;
  final double form;
  final double experience;
  final String? notes;

  Player.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        created_at = DateTime.parse(map['created_at']),
        idClub = map['id_club'],
        userName = map['username'],
        firstName = map['first_name'],
        lastName = map['last_name'],
        surName = map['surname'],
        shirtNumber = map['shirt_number'],
        dateBirth = DateTime.parse(map['date_birth']),
        idMultiverse = map['id_multiverse'],
        multiverseSpeed2 = map['multiverse_speed'],
        idCountry = map['id_country'],
        expanses = map['expanses'],
        trainingPoints = (map['training_points'] as num).toDouble(),
        keeper = (map['keeper'] as num).toDouble(),
        defense = (map['defense'] as num).toDouble(),
        playmaking = (map['playmaking'] as num).toDouble(),
        passes = (map['passes'] as num).toDouble(),
        scoring = (map['scoring'] as num).toDouble(),
        freekick = (map['freekick'] as num).toDouble(),
        winger = (map['winger'] as num).toDouble(),
        stamina = (map['stamina'] as num).toDouble(),
        form = (map['form'] as num).toDouble(),
        experience = (map['experience'] as num).toDouble(),
        dateEndInjury = map['date_end_injury'] != null
            ? DateTime.parse(map['date_end_injury'])
            : null,
        dateFiring = map['date_firing'] != null
            ? DateTime.parse(map['date_firing'])
            : null,
        dateSell =
            map['date_sell'] != null ? DateTime.parse(map['date_sell']) : null,
        dateArrival = DateTime.parse(map['date_arrival']),
        notes = map['notes'];

  double get age {
    return DateTime.now().difference(dateBirth).inDays /
        (14 * 7 / multiverseSpeed2); //14 weeks of 7 days per season
  }

  double get stats_average {
    return (keeper +
            defense +
            playmaking +
            passes +
            scoring +
            freekick +
            winger) /
        7.0;
  }

  dynamic getPropertyValue(String propertyName) {
    switch (propertyName) {
      case 'id':
        return id;
      case 'created_at':
        return created_at;
      case 'idClub':
        return idClub;
      case 'userName':
        return userName;
      case 'firstName':
        return firstName;
      case 'lastName':
        return lastName;
      case 'surName':
        return surName;
      case 'shirtNumber':
        return shirtNumber;
      case 'dateBirth':
        return dateBirth;
      case 'idMmultiverse':
        return idMultiverse;
      case 'multiverseSpeed2':
        return multiverseSpeed2;
      case 'idCountry':
        return idCountry;
      case 'expanses':
        return expanses;
      case 'trainingPoints':
        return trainingPoints;
      case 'keeper':
        return keeper;
      case 'defense':
        return defense;
      case 'playmaking':
        return playmaking;
      case 'passes':
        return passes;
      case 'scoring':
        return scoring;
      case 'freekick':
        return freekick;
      case 'winger':
        return winger;
      case 'dateEndInjury':
        return dateEndInjury;
      case 'dateFiring':
        return dateFiring;
      case 'dateSell':
        return dateSell;
      case 'dateArrival':
        return dateArrival;
      case 'stamina':
        return stamina;
      case 'form':
        return form;
      case 'experience':
        return experience;
      case 'notes':
        return notes;
      default:
        throw ArgumentError('Property not found');
    }
  }
}