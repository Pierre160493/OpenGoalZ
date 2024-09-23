import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opengoalz/extensionBuildContext.dart';
import 'package:opengoalz/functions.dart';
import 'package:opengoalz/models/country.dart';
import 'package:opengoalz/models/multiverse/multiverse.dart';
import 'package:opengoalz/provider_user.dart';
import 'package:provider/provider.dart';

class PlayerSearchCriterias {
  List<int>? idPlayer;
  List<int>? idClub;
  Multiverse? multiverse;
  List<Country>? countries;
  bool onTransferList = false;
  bool isFreePlayer = false;
  double defaultMinAge = 15;
  double defaultMaxAge = 35;
  double selectedMinAge = 15;
  double selectedMaxAge = 35;
  DateTime? minDateBirth;
  DateTime? maxDateBirth;
  // PlayerStatus? selectedStatus;
  Map<String, RangeValues?> stats;

  PlayerSearchCriterias({
    this.idPlayer,
    this.idClub,
    this.multiverse,
    this.countries,
    // this.selectedStatus,
    Map<String, RangeValues?>? stats,
  }) : stats = stats ??
            {
              'keeper': null,
              'defense': null,
              'passes': null,
              'playmaking': null,
              'winger': null,
              'scoring': null,
              'freekick': null,
            };

  Map<String, dynamic> toMap() {
    return {
      if (idPlayer != null) 'id_player': idPlayer,
      if (idClub != null) 'id_club': idClub,
      if (multiverse != null) 'id_multiverse': multiverse!.id,
      if (countries != null)
        'id_country': countries!.map((country) => country.id).toList(),
      'min_age': selectedMinAge,
      'max_age': selectedMaxAge,
      // if (selectedStatus != null) 'selected_status': selectedStatus,
      if (stats.isNotEmpty) 'selected_stats': stats,
    };
  }

  Future<void> setDefaultMultiverse(BuildContext context) async {
    final selectedClub =
        Provider.of<SessionProvider>(context, listen: false).user?.selectedClub;

    if (selectedClub == null) {
      context.showSnackBarError(
          'No club selected, cannot fetch default multiverse');
      return;
    }

    try {
      final multiverse = await Multiverse.fromId(selectedClub.idMultiverse);
      if (multiverse == null) {
        context.showSnackBarError('Failed to fetch default multiverse');
        return;
      }
      this.multiverse = multiverse;
    } catch (e) {
      context.showSnackBarError('Failed to fetch default multiverse');
    }
  }

  void updateAgeAndBirthDate(bool isMin, {double? value, double offset = 0}) {
    // If value is null, then we are updating the selected age with the offset
    value ??= isMin ? selectedMinAge : selectedMaxAge;

    double roundedValue = (((value + offset) * 10).round() / 10)
        .clamp(defaultMinAge, defaultMaxAge);

    if (isMin) {
      selectedMinAge = roundedValue;
      if (selectedMinAge > selectedMaxAge) {
        selectedMaxAge = selectedMinAge;
      }
    } else {
      selectedMaxAge = roundedValue;
      if (selectedMaxAge < selectedMinAge) {
        selectedMinAge = selectedMaxAge;
      }
    }

    if (multiverse != null) {
      minDateBirth = calculateDateBirth(selectedMinAge, multiverse!.speed);
      maxDateBirth = calculateDateBirth(selectedMaxAge, multiverse!.speed);
    } else {
      minDateBirth = null;
      maxDateBirth = null;
    }
  }

  Widget ageSelector(BuildContext context, Function setState) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Text(
              'Age Range:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 12.0),
            Text(
                '[${selectedMinAge.toString()} - ${selectedMaxAge.toString()}]'),
          ],
        ),
        subtitle: RangeSlider(
          values: RangeValues(selectedMinAge, selectedMaxAge),
          min: defaultMinAge,
          max: defaultMaxAge,
          divisions: (defaultMaxAge - defaultMinAge).toInt() * 10,
          labels: RangeLabels(selectedMinAge.toStringAsFixed(1),
              selectedMaxAge.toStringAsFixed(1)),
          onChanged: (RangeValues values) {
            setState(() {
              updateAgeAndBirthDate(true, value: values.start);
              updateAgeAndBirthDate(false, value: values.end);
            });
          },
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                // Select player minimum age
                buildAgeAdjustmentRow(true, setState),
                // Select player maximum age
                buildAgeAdjustmentRow(false, setState),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAgeAdjustmentRow(bool isMin, Function setState) {
    double currentAge = isMin ? selectedMinAge : selectedMaxAge;
    DateTime? dateOfBirth = isMin ? minDateBirth : maxDateBirth;
    String ageLabel = isMin ? 'min' : 'max';

    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Colors.green, width: 1.0),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildAgeAdjustmentButton(setState, isMin, currentAge, -1,
              Icons.keyboard_double_arrow_down),
          buildAgeAdjustmentButton(
              setState, isMin, currentAge, -0.1, Icons.keyboard_arrow_down),
          Tooltip(
            message: dateOfBirth != null
                ? 'Birth Date: ' +
                    DateFormat('MMMM d, yyyy').format(dateOfBirth)
                : 'Select multiverse for date of birth',
            child: Text('$ageLabel Age: $currentAge'),
          ),
          buildAgeAdjustmentButton(
              setState, isMin, currentAge, 0.1, Icons.keyboard_arrow_up),
          buildAgeAdjustmentButton(
              setState, isMin, currentAge, 1, Icons.keyboard_double_arrow_up),
        ],
      ),
    );
  }

  Widget buildAgeAdjustmentButton(Function setState, bool isMin,
      double currentAge, double offset, IconData icon) {
    return IconButton(
      onPressed: () {
        setState(() {
          updateAgeAndBirthDate(isMin, value: currentAge, offset: offset);
        });
      },
      icon: Icon(
        icon,
        color:
            // (isMin ? selectedMinAge : selectedMaxAge) <= defaultMinAge ||
            //         (isMin ? selectedMinAge : selectedMaxAge) >= defaultMaxAge
            (offset > 0 && currentAge >= defaultMaxAge) ||
                    (offset < 0 && currentAge <= defaultMinAge)
                ? Colors.red
                : null,
      ),
      tooltip:
          '${offset > 0 ? 'Increase' : 'Lower'} ${isMin ? 'min' : 'max'} age by ${offset.abs()}',
    );
  }
}