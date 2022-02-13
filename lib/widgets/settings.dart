import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tau_weather/blocs/blocs.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: <Widget>[
          BlocBuilder<SettingBloc, SettingState>(
            builder: (context, state) {
              return ListTile(
                title: Text(
                  'Temperature Units',
                ),
                isThreeLine: true,
                subtitle:
                    Text('Use metric measurements for temperature units.'),
                trailing: Switch(
                  value: state.temperatureUnits == TemperatureUnits.celsius,
                  onChanged: (_) => BlocProvider.of<SettingBloc>(context)
                      .add(TemperatureUnitsToggled()),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
