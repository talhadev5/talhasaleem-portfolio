import 'package:equatable/equatable.dart';

enum ProjectCategory {
  fintech('Fintech'),
  ecommerce('eCommerce'),
  healthAi('Health & AI'),
  fleetLogistics('Fleet & Logistics'),
  lifestyle('Lifestyle'),
  utilities('Utilities'),
  businessManagement('Business Management'),
  healthWellness('Health & Wellness'),
  finance('Finance');

  const ProjectCategory(this.label);
  final String label;
}

enum StorePlatform { ios, android }

class StoreLink extends Equatable {
  const StoreLink({required this.platform, required this.url});

  final StorePlatform platform;
  final String url;

  @override
  List<Object?> get props => [platform, url];
}

/// Core domain entity representing a single shipped app in the portfolio.
class Project extends Equatable {
  const Project({
    required this.id,
    required this.name,
    required this.category,
    required this.tagline,
    required this.description,
    required this.features,
    required this.techStack,
    required this.storeLinks,
    this.hasNoPublicLink = false,
  });

  final String id;
  final String name;
  final ProjectCategory category;

  /// One-line description used on the card.
  final String tagline;

  /// Fuller description used on the detail page.
  final String description;
  final List<String> features;
  final List<String> techStack;
  final List<StoreLink> storeLinks;

  /// True for apps like SympAi that are showcase-only, no public store link.
  final bool hasNoPublicLink;

  /// "iOS", "Android", "iOS & Android" or "Showcase", for the detail
  /// page platform badge.
  String get platformLabel {
    if (hasNoPublicLink || storeLinks.isEmpty) return 'Showcase';
    final hasIos = storeLinks.any((l) => l.platform == StorePlatform.ios);
    final hasAndroid = storeLinks.any((l) => l.platform == StorePlatform.android);
    if (hasIos && hasAndroid) return 'iOS & Android';
    return hasIos ? 'iOS' : 'Android';
  }

  @override
  List<Object?> get props => [id, name, category, tagline, description, features, techStack, storeLinks, hasNoPublicLink];
}
