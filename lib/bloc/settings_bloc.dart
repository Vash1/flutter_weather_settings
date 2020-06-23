import 'package:bloc/bloc.dart';

import 'bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  
  @override
  SettingsState get initialState =>
      SettingsState(temperatureUnits: TemperatureUnits.celsius);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is TemperatureUnitsToggled) {
      print("A toggle from" + state.temperatureUnits.toString());
      yield SettingsState(
        temperatureUnits: 
            state.temperatureUnits == TemperatureUnits.celsius
                ? TemperatureUnits.fahrenheit
                : TemperatureUnits.celsius,
      );
    }
  }
}