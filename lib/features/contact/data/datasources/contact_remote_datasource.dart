import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config/contact_config.dart';

/// Posts contact form submissions straight to Formspree from the
/// browser — see [ContactConfig] for how to plug in your own endpoint.
class ContactRemoteDataSource {
  const ContactRemoteDataSource();

  Future<bool> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    if (!ContactConfig.isConfigured) {
      throw StateError(
        'Formspree endpoint not configured — set ContactConfig.formspreeEndpoint '
        'in lib/core/config/contact_config.dart',
      );
    }

    final response = await http.post(
      Uri.parse(ContactConfig.formspreeEndpoint),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'name': name, 'email': email, 'message': message}),
    );

    return response.statusCode == 200;
  }
}
