import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:settings/bloc/bloc.dart';

void main() {
  runApp(App());
}

//https://medium.com/flutter-community/weather-app-with-flutter-bloc-e24a7253340d
//Im stuck with the settings part of the above flutter weather app

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        //I do use MultiBlocProvider with 2 more providers responsible for API calls
        body: MultiBlocProvider(
          providers: [
            BlocProvider<SettingsBloc>(
              create: (context) => SettingsBloc(),
            ),
          ],
          child: HomePage(),
        ),
      )
    );
  }
}

class HomePage extends StatelessWidget {
  final textController = TextEditingController();

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => HomePage(),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),

      body: Column(
        children: <Widget>[
          Center(
            child: RaisedButton (
              child: Text('Settings Page Button',style: TextStyle(fontSize: 20)),
              onPressed:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ),
          BlocBuilder( //the state here is broken, or it is a duplicate instance of it
                        // always shows the initial value
            bloc: BlocProvider.of<SettingsBloc>(context),
            builder: (_, SettingsState state) {
              return Center(child: Text(state.temperatureUnits.toString()));
            },
          ),

        ],
      )
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
        create: (context) => SettingsBloc(),
        child: NewWidget(),
        //Using a new Widget to get a new context 
        //related to: https://github.com/felangel/bloc/issues/763
        //solution: Either wrap in a new widget or wrap in Builder()
      );
  }
}


class NewWidget extends StatelessWidget  {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, SettingsState state) {
          return Column(
            children: <Widget>[
              Center(
                child: Switch(
                  value: state.temperatureUnits == TemperatureUnits.celsius,
                  onChanged: (_) =>
                    //this Switch will always be in default state (active) after navigating to this page
                    BlocProvider.of<SettingsBloc>(context).add(TemperatureUnitsToggled()),
                )
              ),
              Center(child: Text(BlocProvider.of<SettingsBloc>(context).state.temperatureUnits.toString())),
            ]
          );
        }
      ),
    );
  }
}
