import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opengoalz/models/club/class/club.dart';
import 'package:opengoalz/constants.dart';
import 'package:opengoalz/models/playerSearchCriterias.dart';
import 'package:opengoalz/models/profile.dart';
import 'package:opengoalz/pages/calendar_page.dart';
import 'package:opengoalz/pages/mails_page.dart';
import 'package:opengoalz/pages/scouts_page.dart';
import 'package:opengoalz/pages/staff_page.dart';
import 'package:opengoalz/pages/teamCompsPage.dart';
import 'package:opengoalz/provider_user.dart';
import 'package:opengoalz/pages/chat_page.dart';
import 'package:opengoalz/pages/fans_page.dart';
import 'package:opengoalz/pages/finances_page.dart';
import 'package:opengoalz/pages/games_page.dart';
import 'package:opengoalz/pages/user_page.dart';
import 'package:opengoalz/pages/transfer_page.dart';
import 'package:opengoalz/models/player/players_page.dart';
import 'package:opengoalz/pages/league_page.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the selected club
    Profile user = Provider.of<SessionProvider>(context, listen: false).user!;
    Club? selectedClub = user.selectedClub;

    if (selectedClub == null) {
      return const Drawer(
        child: Center(
          child: Text('No club selected'),
        ),
      );
    }

    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: user.getUserName(context),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserPage(),
                ),
              );
            },
            subtitle: !user.isConnectedUser
                ? Text('Currently visiting this profile')
                : null,
            trailing: !user.isConnectedUser
                ? user.returnToConnectedUserIconButton(context)
                : null,
          ),
          buildDrawerTitle(
              Row(children: [selectedClub.getClubNameClickable(context)])),
          ListTile(
            leading: Icon(iconClub, size: iconSizeMedium, color: Colors.green),
            title: selectedClub.getClubNameClickable(context),
            shape: shapePersoRoundedBorder(Colors.green),
            subtitle: selectedClub.getClubRankingRow(context),
          ),
          buildDrawerListTile(context, iconCalendar, 'Calendar',
              CalendarPage(idClub: selectedClub.id)), // Add the finances page
          buildDrawerListTile(
              context,
              iconMails,
              'Mails (${Provider.of<SessionProvider>(context, listen: false).user!.mails.where((mail) => mail.dateDelete == null && mail.isRead == false).length}) (${(Provider.of<SessionProvider>(context, listen: false).user!.selectedClub != null ? Provider.of<SessionProvider>(context, listen: false).user!.selectedClub!.mails.where((mail) => mail.dateDelete == null && mail.isRead == false).length : 0)})',
              MailsPage(idClub: selectedClub.id)), // Add the finances page
          // buildDrawerListTile(
          //     context,
          //     icon_finance,
          //     'Finances:     ${NumberFormat.decimalPattern().format(selectedClub.cash)} €',
          //     FinancesPage(idClub: selectedClub.id)), // Add the finances page
          ListTile(
            leading: Icon(iconCash,
                size: iconSizeMedium,
                color: selectedClub.clubData.cash >= 0
                    ? Colors.green
                    : Colors.red),
            title: Text(
              'Finances',
            ),
            subtitle: Row(
              children: [
                Icon(iconMoney),
                formSpacer6,
                Text(
                  NumberFormat.decimalPattern()
                      .format(selectedClub.clubData.cash),
                  style: TextStyle(
                    color: selectedClub.clubData.cash >= 0
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FinancesPage(club: selectedClub),
              ),
            ),
          ),
          // buildDrawerListTile(
          //     context,
          //     iconFans,
          //     'Fans (${selectedClub.numberFans})',
          //     FansPage(idClub: selectedClub.id)), // Add the fans page
          // buildDrawerListTile(
          //   context,
          //   iconStadium,
          //   'Stadium',
          // ), // Add the Stadium page
          buildDrawerListTile(
            context,
            iconStaff,
            'Staff',
            StaffPage(idClub: selectedClub.id),
          ), // Add the Staff page
          buildDrawerListTile(
            context,
            iconScouts,
            'Scouts',
            ScoutsPage(idClub: selectedClub.id),
          ), // Add the Staff page
          // buildDrawerListTile(
          //   context,
          //   icon_scouts,
          //   'Scouts',
          // ), // Add the Scouts page
          // buildDrawerListTile(
          //     context, icon_medics, 'Medics'), // Add the Medics page
          buildDrawerTitle(
              Row(children: [Text('Main Team')])), // Add the Main Team page
          buildDrawerListTile(
            context,
            iconPlayers,
            // 'Players (${selectedClub.player_count})',
            'Players',
            PlayersPage(
              playerSearchCriterias:
                  PlayerSearchCriterias(idClub: [selectedClub.id]),
            ),
          ), // Add the Players page
          buildDrawerListTile(context, iconTransfers, 'Transfers',
              TransferPage(idClub: selectedClub.id)), // Add the Transfers page
          buildDrawerListTile(context, iconGames, 'Games',
              GamesPage(idClub: selectedClub.id)), // Add the Games page
          buildDrawerListTile(
              context,
              iconTeamComp,
              'TeamComps',
              TeamCompsPage(
                  idClub: selectedClub.id,
                  seasonNumber:
                      selectedClub.seasonNumber)), // Add the Rankings page
          buildDrawerListTile(
              context,
              iconLeague,
              'League',
              LeaguePage(
                idLeague: selectedClub.idLeague,
                idSelectedClub: selectedClub.id,
              )), // Add the Rankings page
          // buildDrawerListTile(
          //   context,
          //   iconTraining,
          //   'Training',
          // ), // Add the Training page
          buildDrawerTitle(Row(children: [Text('Other')])),

          buildDrawerListTile(context, iconChat, 'Chat',
              const ChatPage()), // Add the Rankings page
        ],
      ),
    );
  }
}

Widget buildDrawerTitle(Row titleRow) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: titleRow,
  );
}

Widget buildDrawerListTile(BuildContext context, IconData icon, String title,
    [Widget? page, String? subtitle]) {
  return ListTile(
    leading: Icon(icon, size: iconSizeMedium, color: Colors.green),
    title: Text(title),
    subtitle: subtitle != null ? Text(subtitle) : null,
    onTap: page != null
        ? () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          }
        : null,
  );
}
