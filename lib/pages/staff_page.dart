import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opengoalz/models/club/club.dart';
import 'package:opengoalz/constants.dart';
import 'package:opengoalz/widgets/appDrawer.dart';
import 'package:opengoalz/widgets/max_width_widget.dart';

class StaffPage extends StatefulWidget {
  final int idClub;
  const StaffPage({Key? key, required this.idClub}) : super(key: key);

  static Route<void> route(int idClub) {
    return MaterialPageRoute(
      builder: (context) => StaffPage(idClub: idClub),
    );
  }

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  late final Stream<Club> _clubStream;

  @override
  void initState() {
    _clubStream = supabase

        /// Fetch the club
        .from('clubs')
        .stream(primaryKey: ['id'])
        .eq('id', widget.idClub)
        .map((maps) => maps.map((map) => Club.fromMap(map)).first);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Club>(
      stream: _clubStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error occurred: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          Club club = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text('Staff of ${club.name}'),
            ),
            drawer: const AppDrawer(),
            body: MaxWidthContainer(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(iconStaff, size: iconSizeMedium),
                    title: Row(
                      children: [
                        Text('Staff expenses: '),
                        Icon(
                          iconMoney,
                          size: iconSizeSmall,
                        ),
                        SizedBox(width: 3.0),
                        Text(
                          NumberFormat.decimalPattern()
                              .format(club.expensesStaff),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    subtitle: const Text(
                      'Staff expenses of the club per week for training players',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    onTap: () async {
                      final TextEditingController controller =
                          TextEditingController(
                              text: club.expensesStaff.toString());

                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Update Staff Expenses'),
                            content: TextField(
                              controller: controller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "Enter new staff expenses"),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Update'),
                                onPressed: () async {
                                  int? newExpenses =
                                      int.tryParse(controller.text);
                                  if (newExpenses == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Input could not be parsed as an integer'),
                                      ),
                                    );
                                  } else if (newExpenses ==
                                      club.expensesStaff) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Staff expenses is already set at ${club.expensesStaff} per week'),
                                      ),
                                    );
                                  } else {
                                    try {
                                      var response = await supabase
                                          .from('clubs')
                                          .update({
                                        'expenses_staff': newExpenses
                                      }).eq('id', club.id);

                                      print(response);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Successfully updated the staff expenses'),
                                        ),
                                      );
                                    } catch (error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(error.toString()),
                                        ),
                                      );
                                    }
                                  }
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.thermostat, size: iconSizeMedium),
                    title: Row(
                      children: [
                        Text('Staff skill: '),
                        Text(
                          NumberFormat.decimalPattern()
                              .format(club.staffWeight),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    subtitle: const Text(
                      'Staff weigth of the club for training players',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  // SizedBox(height: 12),
                  // _getStaffExpensesHistory(club),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  // Widget _getStaffExpensesHistory(Club club) {
  //   List<FlSpot> data = club.lisStaffExpenses
  //       .asMap()
  //       .entries
  //       .map((entry) => FlSpot(entry.key.toDouble(), entry.value.toDouble()))
  //       .toList();

  //   return Container(
  //     height: 400,
  //     child: LineChart(
  //       LineChartData(
  //         lineBarsData: [
  //           LineChartBarData(
  //             spots: data,
  //             color: Colors.blue,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
