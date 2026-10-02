import 'package:flutter/material.dart';

/// A single case-study section descriptor used to build the section nav
/// and to register/unregister the section's [GlobalKey] with
/// `SectionScrollRegistry`. `id` is prefixed `cs-` by convention so it
/// can never collide with the Home page's own anchor names, even during
/// the brief overlap of a route's fade-through transition.
class CsSection {
  const CsSection({required this.id, required this.label, required this.icon});

  final String id;
  final String label;
  final IconData icon;
}
