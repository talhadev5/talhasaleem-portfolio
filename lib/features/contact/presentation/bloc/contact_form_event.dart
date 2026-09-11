part of 'contact_form_bloc.dart';

sealed class ContactFormEvent extends Equatable {
  const ContactFormEvent();

  @override
  List<Object?> get props => [];
}

class ContactFormSubmitted extends ContactFormEvent {
  const ContactFormSubmitted({required this.name, required this.email, required this.message});

  final String name;
  final String email;
  final String message;

  @override
  List<Object?> get props => [name, email, message];
}

class ContactFormReset extends ContactFormEvent {
  const ContactFormReset();
}
