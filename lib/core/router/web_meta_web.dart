import 'dart:html' as html;

/// Updates the browser tab title and the `<meta name="description">`
/// tag for the current route (basic client-side SEO for Flutter Web).
void setPageMeta(String title, String description) {
  html.document.title = title;
  final existing = html.document.querySelector('meta[name="description"]');
  if (existing != null) {
    existing.setAttribute('content', description);
  } else {
    final meta = html.MetaElement()
      ..name = 'description'
      ..content = description;
    html.document.head?.append(meta);
  }
}
