import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opengoalz/constants.dart';
import 'package:opengoalz/global_variable.dart';
import 'package:opengoalz/widgets/appBar.dart';
import 'package:opengoalz/widgets/appDrawer.dart';
import 'package:provider/provider.dart';

class FinancesPage extends StatefulWidget {
  final int idClub;
  const FinancesPage({Key? key, required this.idClub}) : super(key: key);

  static Route<void> route(int idClub) {
    return MaterialPageRoute(
      builder: (context) => FinancesPage(idClub: idClub),
    );
  }

  @override
  State<FinancesPage> createState() => _FinancesPageState();
}

class _FinancesPageState extends State<FinancesPage> {
  late final Stream<List<Map<String, dynamic>>> _financeStream;

  @override
  void initState() {
    _financeStream = supabase
        .from('finances')
        .stream(primaryKey: ['id'])
        .eq('id_club', widget.idClub)
        .order('created_at')
        .map((maps) => maps
            .map((map) => {
                  'id': map['id'],
                  'created_at': map['created_at'],
                  'amount': map['amount'],
                  'description': map['description'],
                  // Add more fields here as needed
                })
            .toList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          pageName:
              'Finances for: ${Provider.of<SessionProvider>(context).selectedClub.club_name ?? 'No club name'}'),
      // CustomAppBar(clubStream: _clubStream),
      // drawer: AppDrawer(clubStream: _clubStream),
      drawer: const AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            'Hello ${Provider.of<SessionProvider>(context).selectedClub.username}',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              text: 'Available cash: ',
              style: const TextStyle(fontSize: 18),
              children: <TextSpan>[
                TextSpan(
                  text: Provider.of<SessionProvider>(context)
                      .selectedClub
                      .finances_cash
                      .toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Provider.of<SessionProvider>(context)
                                .selectedClub
                                .finances_cash >
                            0
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Latest movements:',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _financeStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final finances = snapshot.data!;
                  return ListView.builder(
                    itemCount: finances.length,
                    itemBuilder: (context, index) {
                      final finance = finances[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          title:
                              Text(finance['description'] ?? 'No description'),
                          subtitle: Text('Amount: ${finance['amount']}'),
                          trailing: Text(
                            'Date: ${DateFormat.yMd().format(DateTime.parse(finance['created_at']))}',
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}