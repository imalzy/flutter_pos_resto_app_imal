import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posresto_app/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_posresto_app/data/models/response/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource authRemoteDatasource;
  LoginBloc(this.authRemoteDatasource) : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      await Future.delayed(const Duration(seconds: 3));
      final response =
          await authRemoteDatasource.login(event.email, event.password);
      response.fold(
          (error) => emit(_Error(error)), (success) => emit(_Success(success)));
    });
  }
}
