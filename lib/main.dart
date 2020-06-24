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
        body: MultiBlocProvider(
          providers: [
            BlocProvider<SettingsBloc>(create: (_) => SettingsBloc()),
          ],
          child: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Column(
        children: <Widget>[
          Center(
            child: RaisedButton(
              child: Text(
                'Settings Page Button',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.bloc<SettingsBloc>(),
                      child: SettingsPage(),
                    ),
                  ),
                );
              },
            ),
          ),
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (_, state) {
              return Center(child: Text(state.temperatureUnits.toString()));
            },
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewWidget();
  }
}

class NewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Center(
                child: Switch(
                  value: state.temperatureUnits == TemperatureUnits.celsius,
                  onChanged: (_) => context
                      .bloc<SettingsBloc>()
                      .add(TemperatureUnitsToggled()),
                ),
              ),
              Center(
                child: Text(context
                    .bloc<SettingsBloc>()
                    .state
                    .temperatureUnits
                    .toString()),
              ),
            ],
          );
        },
      ),
    );
  }
}
