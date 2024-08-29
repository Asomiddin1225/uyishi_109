import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:recipe_app/bloc/register_event.dart';
import 'package:recipe_app/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is SubmitRegisterEvent) {
      yield RegisterLoading();
      try {
        final response = await Dio().post(
          'http://recipe.flutterwithakmaljon.uz/api/register',
          data: {
            'name': event.fullName,
            'phone': event.phone,
            'email': event.email,
            'password': event.password,
          },
        );

        String token = response.data['token'];
        yield RegisterSuccess(token);
      } catch (e) {
        yield RegisterFailure(e.toString());
      }
    }
  }
}
