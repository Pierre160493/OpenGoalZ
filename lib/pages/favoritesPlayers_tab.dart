// import 'package:flutter/material.dart';
// import 'package:opengoalz/extensionBuildContext.dart';
// import 'package:opengoalz/functions/stringFunctions.dart';
// import 'package:opengoalz/models/club/class/club.dart';
// import 'package:opengoalz/constants.dart';
// import 'package:opengoalz/models/club/class/club_data.dart';
// import 'package:opengoalz/postgresql_requests.dart';
// import 'package:opengoalz/provider_user.dart';
// import 'package:opengoalz/widgets/appDrawer.dart';
// import 'package:opengoalz/widgets/goBackToolTip.dart';
// import 'package:opengoalz/widgets/graphWidget.dart';
// import 'package:opengoalz/widgets/max_width_widget.dart';
// import 'package:opengoalz/widgets/scoutsDialogBox.dart';
// import 'package:opengoalz/widgets/tab_widget_with_icon.dart';
// import 'package:provider/provider.dart';

// class FavoritePlayersTab extends StatefulWidget {
//   final Club club;
//   const FavoritePlayersTab({Key? key, required this.club}) : super(key: key);

//   static Route<void> route(Club club) {
//     return MaterialPageRoute(
//       builder: (context) => FavoritePlayersTab(club: club),
//     );
//   }

//   @override
//   State<FavoritePlayersTab> createState() => _FavoritePlayersPageState();
// }

// class _FavoritePlayersPageState extends State<FavoritePlayersTab> {
//   late final Stream<Club> _favoritePlayersStream;

//   @override
//   void initState() {
//     _favoritePlayersStream = supabase

//         /// Fetch the club
//         .from('players_favorite')
//         .stream(primaryKey: ['id'])
//         .eq('id_club', widget.club.id)
//         .map((maps) => maps.map((map) => Club.fromMap(map)).toList()).switchMap((Profile user) {
//             return supabase
//                 .from('players')
//                 .stream(primaryKey: ['id'])
//                 .eq('username', user.username)
//                 .map((maps) => maps.map((map) => Player.fromMap(map)).toList())
//                 .map((List<Player> players) {
//                   user.players = players;
//                   return user;
//                 });
//           });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<Club>(
//       stream: _favoritePlayersStream,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Error occurred: ${snapshot.error}'));
//         } else if (!snapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           Club club = snapshot.data!;
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Scouting Network'),
//               actions: [
//                 Tooltip(
//                   message: 'Help',
//                   child: IconButton(
//                     icon: Icon(Icons.help_outline, color: Colors.green),
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text('Scouting System Help'),
//                             content: Text(
//                               'The scouting system allows you to manage and track the expenses and skills of your scouting network.\n\n'
//                               'Every week, you can invest a sum of money into the scouting network to build up its strength.\n\n'
//                               'The expenses dedicated to scouting are theoretical and represent the amount you plan to spend each week, if your finances permit it !\n\n'
//                               'As you continue to invest, the scouting network strength will increase.\n\n'
//                               'Once the scouting strength reaches ${_costForNewPlayer}, you can call the scouts to find a new player.\n\n'
//                               'You can also view the historical data of scouting expenses and the strength of your scouting network over time.',
//                             ),
//                             actions: <Widget>[
//                               TextButton(
//                                 child: Text('Close'),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//               leading: goBackIconButton(context),
//             ),
//             body: MaxWidthContainer(
//               child: DefaultTabController(
//                 length: 2,
//                 child: Column(
//                   children: [
//                     TabBar(
//                       tabs: [
//                         buildTabWithIcon(
//                             icon: iconScouts, text: 'Scouting network'),
//                         buildTabWithIcon(
//                             icon: iconFavorite, text: 'Favorite players'),
//                       ],
//                     ),
//                     Expanded(
//                       child: TabBarView(
//                         children: [
//                           _getScoutsTab(club),
//                           Center(
//                             child: Text('test'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }

//   Widget _getScoutsTab(Club club) {
//     return Column(
//       children: [
//         ListTile(
//           leading: Icon(iconScouts, size: iconSizeMedium, color: Colors.green),
//           title: Row(
//             children: [
//               Text('Scouting Network expenses: '),
//               Icon(
//                 iconMoney,
//                 size: iconSizeSmall,
//               ),
//               SizedBox(width: 3.0),
//               Text(
//                 stringValueSeparated(club.clubData.expensesScoutsTarget),
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           subtitle: const Text(
//             'Theoretical Expenses dedicated for scouting network per week',
//             style: styleItalicBlueGrey,
//           ),
//           shape: shapePersoRoundedBorder(),
//           trailing: IconButton(
//               onPressed: () async {
//                 final TextEditingController controller = TextEditingController(
//                     text: club.clubData.expensesScoutsTarget.toString());

//                 await showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: Text('Update Scouting Network Expenses'),
//                       content: TextField(
//                         controller: controller,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                             hintText: "Enter new scouting network expenses"),
//                       ),
//                       actions: <Widget>[
//                         TextButton(
//                           child: Text('Cancel'),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         TextButton(
//                           child: Text('Update'),
//                           onPressed: () async {
//                             int? newExpenses = int.tryParse(controller.text);
//                             if (newExpenses == null) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                       'Input could not be parsed as an integer'),
//                                 ),
//                               );
//                             } else if (newExpenses ==
//                                 club.clubData.expensesScoutsTarget) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                       'Scouting Network expenses is already set at ${club.clubData.expensesScoutsTarget} per week'),
//                                 ),
//                               );
//                             } else {
//                               bool isOK = await operationInDB(
//                                   context, 'UPDATE', 'clubs',
//                                   data: {'expenses_scouts_target': newExpenses},
//                                   matchCriteria: {'id': club.id});

//                               if (isOK) {
//                                 context.showSnackBarSuccess(
//                                     'Successfully updated the scouting network expenses target to $newExpenses per week');
//                                 Navigator.of(context).pop(); // Close the dialog
//                               }
//                             }
//                           },
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//               icon: Icon(Icons.currency_exchange, color: Colors.orange)),
//           onTap: () async {
//             ClubData.showClubHistoryChartDialog(
//               context,
//               club.id,
//               'expenses_scouts_applied',
//               'Scouting Network Expenses',
//             );
//           },
//         ),

//         /// Scouting Network weight
//         ListTile(
//           leading:
//               Icon(Icons.thermostat, size: iconSizeMedium, color: Colors.green),
//           title: Row(
//             children: [
//               Text('Scouting Network Strength: '),
//               Text(
//                 stringValueSeparated(club.clubData.scoutsWeight.round()),
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           subtitle: const Text(
//             'Strength of the scouting network for searching young players',
//             style: styleItalicBlueGrey,
//           ),
//           shape: shapePersoRoundedBorder(),
//           onTap: () async {
//             ClubData.showClubHistoryChartDialog(
//               context,
//               club.id,
//               'scouts_weight',
//               'Scouting Network Strength',
//             );
//           },
//         ),

//         /// Fetch a new player
//         if (club.id ==
//             Provider.of<SessionProvider>(context, listen: false)
//                 .user!
//                 .selectedClub!
//                 .id)
//           ListTile(
//             leading: Icon(Icons.phone,
//                 size: iconSizeMedium,
//                 color: club.clubData.scoutsWeight < _costForNewPlayer
//                     ? Colors.orange
//                     : Colors.green),
//             title: Text('Call the scouts !'),
//             subtitle: Text(
//               'Spend ${_costForNewPlayer.toString()} scouting strength to find a new player',
//               style: styleItalicBlueGrey,
//             ),
//             shape: shapePersoRoundedBorder(
//                 club.clubData.scoutsWeight < _costForNewPlayer
//                     ? Colors.red
//                     : Colors.green),
//             onTap: club.clubData.scoutsWeight < _costForNewPlayer
//                 ? null
//                 : () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return ScoutsDialog(club: club);
//                       },
//                     );
//                   },
//           ),
//       ],
//     );
//   }
// }