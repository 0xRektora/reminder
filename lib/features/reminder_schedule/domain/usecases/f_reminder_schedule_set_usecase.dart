import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:reminder/core/error/failures.dart';
import 'package:reminder/core/usecases/usecase.dart';

class FReminderScheduleSetUsecase
    implements Usecase<bool, FReminderScheduleSetUsecaseParam> {
  @override
  Future<Either<Failure, bool>> call(FReminderScheduleSetUsecaseParam params) {
    // TODO: implement call
    return null;
  }
}

class FReminderScheduleSetUsecaseParam extends Equatable {
  final TimeOfDay timeOfDay;

  FReminderScheduleSetUsecaseParam({@required this.timeOfDay});

  @override
  List<Object> get props => [timeOfDay];
}
