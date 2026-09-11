/// Contact form delivery configuration.
///
/// The contact form posts directly to Formspree from the browser (no
/// backend needed) — Formspree accepts AJAX/fetch submissions from any
/// origin when called with an `Accept: application/json` header, which
/// is exactly what `ContactRemoteDataSource` sends.
///
/// To wire up your own inbox:
///   1. Create a free form at https://formspree.io (sign up, "New Form").
///   2. Copy the endpoint it gives you — looks like
///      https://formspree.io/f/abcdwxyz
///   3. Paste it below, replacing the placeholder.
class ContactConfig {
  ContactConfig._();

  static const String formspreeEndpoint = 'https://formspree.io/f/YOUR_FORM_ID';

  /// True once the placeholder above has been replaced with a real
  /// Formspree endpoint.
  static bool get isConfigured => !formspreeEndpoint.contains('YOUR_FORM_ID');
}
