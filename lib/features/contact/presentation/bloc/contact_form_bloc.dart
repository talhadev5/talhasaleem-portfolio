import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/contact_remote_datasource.dart';

part 'contact_form_event.dart';
part 'contact_form_state.dart';

/// Drives the contact form's submit lifecycle, posting to Formspree via
/// [ContactRemoteDataSource]. See lib/core/config/contact_config.dart
/// to plug in a real endpoint.
class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  ContactFormBloc({ContactRemoteDataSource? dataSource})
      : _dataSource = dataSource ?? const ContactRemoteDataSource(),
        super(const ContactFormState()) {
    on<ContactFormSubmitted>(_onSubmitted);
    on<ContactFormReset>((event, emit) => emit(const ContactFormState()));
  }

  final ContactRemoteDataSource _dataSource;

  Future<void> _onSubmitted(ContactFormSubmitted event, Emitter<ContactFormState> emit) async {
    emit(state.copyWith(status: ContactFormStatus.submitting));
    try {
      final sent = await _dataSource.sendMessage(
        name: event.name,
        email: event.email,
        message: event.message,
      );
      emit(state.copyWith(status: sent ? ContactFormStatus.success : ContactFormStatus.failure));
    } catch (_) {
      emit(state.copyWith(status: ContactFormStatus.failure));
    }
  }
}
