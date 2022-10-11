// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_bloc.dart';

enum AppTheme { light, dark }

class ThemeState extends Equatable {
  final AppTheme appTheme;
  ThemeState({required this.appTheme});

  @override
  List<Object> get props => [appTheme];

  factory ThemeState.initial() {
    return ThemeState(appTheme: AppTheme.light);
  }

  ThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return ThemeState(appTheme: appTheme ?? this.appTheme);
  }

  @override
  bool get stringify => true;
}
