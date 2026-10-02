import 'package:flutter/material.dart';

/// Elevation styles as a [ThemeExtension]. Dark mode uses soft colored
/// "glow" shadows (feels right against a near-black background); light
/// mode uses conventional neutral drop shadows — a glow reads as muddy
/// haze on a light surface instead of depth.
class AppShadows extends ThemeExtension<AppShadows> {
  const AppShadows({
    required this.card,
    required this.cardHover,
    required this.raised,
  });

  /// Resting elevation for cards/panels.
  final List<BoxShadow> card;

  /// Elevation on hover/focus — stronger glow or deeper drop shadow.
  final List<BoxShadow> cardHover;

  /// Floating elements (FAB, dropdowns, nav bar once scrolled).
  final List<BoxShadow> raised;

  static final AppShadows dark = AppShadows(
    card: [
      BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 24, offset: const Offset(0, 10)),
    ],
    cardHover: [
      BoxShadow(color: const Color(0xFF2F8EFF).withValues(alpha: 0.22), blurRadius: 32, offset: const Offset(0, 14)),
    ],
    raised: [
      BoxShadow(color: Colors.black.withValues(alpha: 0.45), blurRadius: 28, offset: const Offset(0, 12)),
    ],
  );

  static final AppShadows light = AppShadows(
    card: [
      BoxShadow(color: const Color(0xFF1A1712).withValues(alpha: 0.06), blurRadius: 18, offset: const Offset(0, 6)),
    ],
    cardHover: [
      BoxShadow(color: const Color(0xFF1A1712).withValues(alpha: 0.10), blurRadius: 26, offset: const Offset(0, 12)),
    ],
    raised: [
      BoxShadow(color: const Color(0xFF1A1712).withValues(alpha: 0.12), blurRadius: 22, offset: const Offset(0, 8)),
    ],
  );

  @override
  AppShadows copyWith({List<BoxShadow>? card, List<BoxShadow>? cardHover, List<BoxShadow>? raised}) {
    return AppShadows(
      card: card ?? this.card,
      cardHover: cardHover ?? this.cardHover,
      raised: raised ?? this.raised,
    );
  }

  @override
  AppShadows lerp(ThemeExtension<AppShadows>? other, double t) {
    if (other is! AppShadows) return this;
    // Shadow lists don't interpolate meaningfully — snap at the midpoint.
    return t < 0.5 ? this : other;
  }
}
