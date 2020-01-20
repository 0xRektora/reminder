import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reminder/core/usecases/c_app_all_pill_usecase.dart';
import 'package:reminder/features/calendar/domain/usecases/f_c_get_day_pill_history_usecase.dart';
import './bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CAppAllPillUsecase cAppAllPillUsecase;
  final FCGetDayPillHistoryUsecase getDayPillHistoryUsecase;

  CalendarBloc({
    @required this.cAppAllPillUsecase,
    @required this.getDayPillHistoryUsecase,
  });

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

    if (event is FCalendarDayPillHistoryEvent) {
      final FCGetDayPillHistoryParam getDayPillHistoryParam =
          FCGetDayPillHistoryParam(
        date: event.date,
        uid: event.uid,
      );
      final usecase = await getDayPillHistoryUsecase(
        getDayPillHistoryParam,
      );

      yield* usecase.fold(
        (failure) async* {
          print("FAILURE FCalendarDayPillHistoryEvent: " + failure.message);
        },
        (success) async* {
          print("SUCCESS FCalendarDayPillHistoryEvent: " + success.toString());
          yield FCalendarDayPillHistoryState(listPillHistory: success);
        },
      );
    }
  }
}
