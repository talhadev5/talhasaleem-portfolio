part of 'contact_form_bloc.dart';

enum ContactFormStatus { idle, submitting, success, failure }

class ContactFormState extends Equatable {
  const ContactFormState({this.status = ContactFormStatus.idle});

  final ContactFormStatus status;

  bool get isSubmitting => status == ContactFormStatus.submitting;
  bool get isSuccess => status == ContactFormStatus.success;
  bool get isFailure => status == ContactFormStatus.failure;

  ContactFormState copyWith({ContactFormStatus? status}) {
    return ContactFormState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
