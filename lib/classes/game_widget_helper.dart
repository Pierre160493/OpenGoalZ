part of 'game.dart';

extension GameWidgetsHelper on Game {
  Widget getLeftClubName() {
    return Text(nameClubLeft,
        style: TextStyle(
          fontWeight:
              idClubLeft == idClub ? FontWeight.bold : FontWeight.normal,
        ));
  }

  Widget getRightClubName() {
    return Text(nameClubRight,
        style: TextStyle(
          fontWeight:
              idClubRight == idClub ? FontWeight.bold : FontWeight.normal,
        ));
  }

  Widget getScoreRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white24, // You can adjust the background color here
      ),
      child: Row(
        children: [
          Text(
            goalsLeft.toString(),
            style: TextStyle(
              color: (goalsLeft! > goalsRight!)
                  ? Colors.green
                  : (goalsLeft! < goalsRight!)
                      ? Colors.red
                      : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(' : '),
          Text(
            goalsRight.toString(),
            style: TextStyle(
              color: (goalsLeft! > goalsRight!)
                  ? Colors.red
                  : (goalsLeft! < goalsRight!)
                      ? Colors.green
                      : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget getDateRow() {
    return Row(
      children: [
        Icon(Icons.exit_to_app, color: Colors.green),
        StreamBuilder<int>(
          stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
          builder: (context, snapshot) {
            final remainingTime = dateStart.difference(DateTime.now());
            final daysLeft = remainingTime.inDays;
            final hoursLeft = remainingTime.inHours.remainder(24);
            final minutesLeft = remainingTime.inMinutes.remainder(60);
            final secondsLeft = remainingTime.inSeconds.remainder(60);

            return RichText(
              text: TextSpan(
                text: ' Will be fired in: ',
                style: const TextStyle(),
                children: [
                  if (daysLeft > 0) // Conditionally include days left
                    TextSpan(
                      text: '$daysLeft d, ',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  TextSpan(
                    text: '$hoursLeft h, $minutesLeft m, $secondsLeft s',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget getStatLinearWidget(String label, double value) {
    return Row(
      children: [
        Container(
          width: 100, // Fixed width for the label
          child: Text(label),
        ),
        SizedBox(
          width: 120,
          height: 20, // Height of the bar
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(10), // Rounded corners for the bar
            child: LinearProgressIndicator(
              value: value / 100, // Assuming value ranges from 0 to 100
              backgroundColor: Colors.grey[300], // Background color of the bar
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.green, // Color of the filled portion of the bar
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getCountryNameWidget(int? id_country) {
    if (id_country == null) {
      // Should'nt be nullable
      return Text(
        'Apatride',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return StreamBuilder<List<Map>>(
        stream: supabase
            .from('countries')
            .stream(primaryKey: ['id'])
            .eq('id', id_country)
            .map((maps) => maps
                .map((map) => {
                      'id': map['id'],
                      'name': map['name'],
                    })
                .toList()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Placeholder row while loading
            return Row(
              children: [
                SizedBox(
                  width: 16.0, // Same width as the icon
                  height: 16.0, // Same height as the icon
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
                SizedBox(width: 4.0), // Spacing between icon and text
                SizedBox(
                  width: 100.0, // Adjust the width as needed
                  child: Text(
                    'Loading...', // Placeholder text
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey, // Placeholder text color
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('ERROR: ${snapshot.error}');
          } else {
            final countries = snapshot.data!;
            if (countries.isEmpty) {
              return Text('ERROR: Country not found');
            } else if (countries.length > 1) {
              return Text('ERROR: Multiple countries found');
            }
            // Actual row with data
            return Row(
              children: [
                Icon(
                  Icons.flag_circle_outlined,
                  size: 24.0, // Adjust icon size as needed
                  color: Colors.green, // Adjust icon color as needed
                ),
                SizedBox(width: 4.0), // Spacing between icon and text
                Text(
                  '${countries.first['name']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }
        },
      );
    }
  }
}
