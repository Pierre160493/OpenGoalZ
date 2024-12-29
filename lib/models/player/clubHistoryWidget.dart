import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opengoalz/constants.dart';
import 'package:opengoalz/models/club/class/club.dart';
import 'package:opengoalz/widgets/descriptionParser.dart';

class ClubCardHistoryWidget extends StatefulWidget {
  final Club club;

  const ClubCardHistoryWidget({Key? key, required this.club}) : super(key: key);

  @override
  _ClubCardHistoryWidgetState createState() => _ClubCardHistoryWidgetState();
}

class _ClubCardHistoryWidgetState extends State<ClubCardHistoryWidget> {
  late Stream<List<Map>> _clubHistoryStream;

  @override
  void initState() {
    super.initState();

    _clubHistoryStream = supabase
        .from('clubs_history')
        .stream(primaryKey: ['id'])
        .eq('id_club', widget.club.id)
        .order('created_at');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map>>(
      stream: _clubHistoryStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          List<Map> listClubHistory = snapshot.data!;
          return Expanded(
            child: ListView.builder(
              itemCount: listClubHistory.length,
              itemBuilder: (context, index) {
                final history = listClubHistory[index];
                return ListTile(
                  leading: Icon(iconHistory,
                      color: Colors.green, size: iconSizeMedium),
                  title: RichText(
                    text: parseDescriptionTextSpan(
                        context, history['description'] ?? 'No description'),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(
                        iconCalendar,
                        color: Colors.blueGrey,
                        size: iconSizeSmall,
                      ),
                      Text(
                        'Date: ${DateFormat(persoDateFormat).format(DateTime.parse(history['created_at']))}',
                        style: styleItalicBlueGrey,
                      ),
                    ],
                  ),
                  shape: shapePersoRoundedBorder(),
                );
              },
            ),
          );
        }
      },
    );
  }
}
