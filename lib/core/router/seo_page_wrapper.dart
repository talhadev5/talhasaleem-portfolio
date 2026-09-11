import 'package:flutter/material.dart';
import 'web_meta_stub.dart' if (dart.library.html) 'web_meta_web.dart' as web_meta;

/// Sets the browser tab title and meta description for the current route.
/// No-ops on non-web platforms.
class SeoPageWrapper extends StatefulWidget {
  const SeoPageWrapper({
    super.key,
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  State<SeoPageWrapper> createState() => _SeoPageWrapperState();
}

class _SeoPageWrapperState extends State<SeoPageWrapper> {
  @override
  void initState() {
    super.initState();
    web_meta.setPageMeta(widget.title, widget.description);
  }

  @override
  void didUpdateWidget(covariant SeoPageWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.title != widget.title || oldWidget.description != widget.description) {
      web_meta.setPageMeta(widget.title, widget.description);
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
