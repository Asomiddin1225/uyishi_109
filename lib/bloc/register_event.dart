abstract class RegisterEvent {}

class SubmitRegisterEvent extends RegisterEvent {
  final String fullName;
  final String email;
  final String phone;
  final String password;

  SubmitRegisterEvent(this.fullName, this.email, this.phone, this.password);
}
