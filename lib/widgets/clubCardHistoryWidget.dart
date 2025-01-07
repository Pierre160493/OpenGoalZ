import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opengoalz/constants.dart';
import 'package:opengoalz/models/club/class/club.dart';

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

  TextSpan _parseDescription(String description) {
    final RegExp regex = RegExp(r'\{(.+?)\}');
    final List<TextSpan> spans = [];
    int start = 0;

    for (final match in regex.allMatches(description)) {
      if (match.start > start) {
        spans.add(TextSpan(text: description.substring(start, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ));
      start = match.end;
    }

    if (start < description.length) {
      spans.add(TextSpan(text: description.substring(start)));
    }

    return TextSpan(children: spans);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Club History'),
      ),
      body: StreamBuilder<List<Map>>(
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
            return ListView.builder(
              itemCount: listClubHistory.length,
              itemBuilder: (context, index) {
                final history = listClubHistory[index];
                return ListTile(
                  leading: Icon(iconHistory,
                      color: Colors.green, size: iconSizeMedium),
                  title: RichText(
                    text: _parseDescription(
                        history['description'] ?? 'No description'),
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
            );
          }
        },
      ),
    );
  }
}