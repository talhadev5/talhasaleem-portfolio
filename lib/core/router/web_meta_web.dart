import 'dart:html' as html;

/// Updates the browser tab title, the `<meta name="description">` tag,
/// and Open Graph tags (title/description/type/url) for the current
/// route — basic client-side SEO + social-preview metadata for Flutter
/// Web, using the same lightweight `dart:html` approach already in
/// place rather than a new package.
void setPageMeta(String title, String description) {
  html.document.title = title;
  _setMeta('description', content: description, attr: 'name');
  _setMeta('og:title', content: title, attr: 'property');
  _setMeta('og:description', content: description, attr: 'property');
  _setMeta('og:type', content: 'website', attr: 'property');
  _setMeta('og:url', content: html.window.location.href, attr: 'property');
}

void _setMeta(String name, {required String content, required String attr}) {
  final selector = 'meta[$attr="$name"]';
  final existing = html.document.querySelector(selector);
  if (existing != null) {
    existing.setAttribute('content', content);
  } else {
    final meta = html.MetaElement()..setAttribute(attr, name);
    meta.setAttribute('content', content);
    html.document.head?.append(meta);
  }
}
