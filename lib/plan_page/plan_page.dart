// Importing necessary packages
import 'package:flutter/material.dart';
import 'package:uber/plan_page/bloc.dart';

// PlanPage widget which is a stateful widget
class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  // Creating the state for this widget
  @override
  State<PlanPage> createState() => _PlanPageState();
}

// State class for PlanPage
class _PlanPageState extends State<PlanPage> {
  // Declaring variables for TextEditingController, WMATABloc, and predictions
  final TextEditingController _stationNameController = TextEditingController();
  final TextEditingController _finalNameController = TextEditingController();
  final WMATABloc _bloc = WMATABloc();
  List<String> _predictions = [];

  // Building the widget
  @override
  Widget build(BuildContext context) {
    // Getting MediaQueryData
    MediaQueryData mediaQuery = MediaQuery.of(context);
    // Returning a Scaffold widget
    return Scaffold(
      appBar: AppBar(
        // Setting the title of the AppBar
        title: const Text('Plan Ride'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(children: [
            // Column of TextFields and predictions
            Column(
              children: [
                // TextField for entering station name
                SizedBox(
                    width: mediaQuery.size.width * 0.8,
                    child: TextField(
                      controller: _stationNameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Station Name',
                      ),
                    )),
                // TextField for entering destination name
                SizedBox(
                    width: mediaQuery.size.width * 0.8,
                    child: TextField(
                      controller: _finalNameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Destination Name',
                      ),
                    )),
                const SizedBox(height: 30),
                const SizedBox(height: 30),
                // Column of predictions
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _predictions.map((String text) {
                    return SizedBox(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                      const SizedBox(
                        height: 10,
                      ),
                      // Button for each prediction
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                          },
                          child: Text(text),
                        ),
                      )
                    ]));
                  }).toList(),
                ),
              ],
            ),
            // Button to get train predictions
            Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 260,
                  height: 75,
                  child: ElevatedButton(
                    onPressed: () {
                      final stationName = _stationNameController.text;
                      final finalName = _finalNameController.text;
                      _bloc
                          .getStationPredictions(stationName, finalName)
                          .then((predictions) {
                        setState(() {
                          _predictions = predictions;
                        });
                      }).catchError((error) {
                        print('Error: $error');
                      });
                    },
                    child: const Text(
                      'Get Train Predictions',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )),
          ])),
    );
  }
}
