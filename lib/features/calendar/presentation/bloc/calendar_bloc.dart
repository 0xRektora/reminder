import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:reminder/core/usecases/c_app_all_pill_usecase.dart';
import './bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CAppAllPillUsecase cAppAllPillUsecase;

  CalendarBloc(this.cAppAllPillUsecase);

  @override
  CalendarState get initialState => InitialCalendarState();

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if (event is FCalendarAllPillEvent) {
      final usecase =
          await cAppAllPillUsecase(CAppGetAllPillParam(uid: event.uid));
      yield* usecase.fold(
        (failure) async* {
          yield InitialCalendarState();
        },
        (success) async* {
          yield FCalendarAllPillState(pillEntity: success);
        },
      );
    }
  }
}
