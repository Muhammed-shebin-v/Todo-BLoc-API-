import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(ThemeData.light())) {
    on<ThemeEvent>((event, emit) {
      final isLightTheme = state.themeData == ThemeData.light();
      emit(ThemeState(isLightTheme ? ThemeData.dark() : ThemeData.light()));
    });
  }
}