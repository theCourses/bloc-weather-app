// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'temp_settings_bloc.dart';

enum TempUnit {
  celsius,
  fahrenheit,
}

class TempSettingsState extends Equatable {
  final TempUnit tempUnit;

  const TempSettingsState({required this.tempUnit});

  factory TempSettingsState.intial() {
    return const TempSettingsState(tempUnit: TempUnit.celsius);
  }

  TempSettingsState copyWith({
    TempUnit? tempUnit,
  }) {
    return TempSettingsState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }

  @override
  List<Object> get props => [tempUnit];

  @override
  bool get stringify => true;
}
