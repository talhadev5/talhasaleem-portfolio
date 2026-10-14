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

/// One named workflow through the app (e.g. "Booking a pickup"), shown as
/// a numbered step list in the case study. Only included for projects
/// where a real workflow is evident from the actual feature set.
class UserJourney extends Equatable {
  const UserJourney({required this.title, required this.steps});

  final String title;
  final List<String> steps;

  @override
  List<Object?> get props => [title, steps];
}

/// A technology choice plus why it mattered for this specific app —
/// grounded in [Project.techStack], not generic tech-blurb filler.
class TechDecision extends Equatable {
  const TechDecision({required this.title, required this.rationale});

  final String title;
  final String rationale;

  @override
  List<Object?> get props => [title, rationale];
}

/// An engineering challenge the app's own feature set genuinely implies,
/// paired with how the implementation addresses it. Kept conservative —
/// omitted entirely for projects where this can't be honestly grounded
/// in real data.
class Challenge extends Equatable {
  const Challenge({required this.challenge, required this.solution});

  final String challenge;
  final String solution;

  @override
  List<Object?> get props => [challenge, solution];
}

/// A single gallery image with its caption. `assetPath` follows the
/// existing `assets/images/projects/<id>_<n>.jpg` convention — the
/// gallery section simply doesn't render until real files exist there.
class ProjectScreenshot extends Equatable {
  const ProjectScreenshot({required this.assetPath, required this.caption});

  final String assetPath;
  final String caption;

  @override
  List<Object?> get props => [assetPath, caption];
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
    this.websiteUrl,
    this.githubUrl,
    this.myContribution = '',
    this.problem,
    this.solution,
    this.userJourneys = const [],
    this.techDecisions = const [],
    this.challenges = const [],
    this.outcomes = const [],
    this.screenshots = const [],
    this.logoAssetPath,
    this.bannerAssetPath,
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

  /// Real app/brand logo for the card icon badge. Null falls back to the
  /// generic gradient-and-icon placeholder — only set when a real logo
  /// asset exists for this project.
  final String? logoAssetPath;

  /// A real marketing/promo banner (e.g. an App Store feature graphic),
  /// used as the case-study hero visual for projects with no individual
  /// in-app screenshots yet. [logoAssetPath], when also set, overlays as
  /// a small badge on top of it. Screenshots still take priority over
  /// this when both exist.
  final String? bannerAssetPath;

  /// True for apps like SympAi that are showcase-only, no public store link.
  final bool hasNoPublicLink;

  /// Public marketing/live-product site, when one exists independent of
  /// the app stores. Null for every project today — no site currently
  /// records one.
  final String? websiteUrl;

  /// Public repository, only when one is genuinely open source. Null for
  /// every project today.
  final String? githubUrl;

  /// Role/responsibility statement for the case study's "My Contribution"
  /// section.
  final String myContribution;

  /// The user/business problem that motivated the product. Null when not
  /// meaningfully distinct from [description] for a simple utility app.
  final String? problem;

  /// How the app addresses [problem].
  final String? solution;

  final List<UserJourney> userJourneys;
  final List<TechDecision> techDecisions;
  final List<Challenge> challenges;

  /// Capability/delivery statements, e.g. "Shipped to the App Store with
  /// live StoreKit subscriptions" — never a fabricated metric.
  final List<String> outcomes;

  final List<ProjectScreenshot> screenshots;

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
  List<Object?> get props => [
        id,
        name,
        category,
        tagline,
        description,
        features,
        techStack,
        storeLinks,
        hasNoPublicLink,
        websiteUrl,
        githubUrl,
        myContribution,
        problem,
        solution,
        userJourneys,
        techDecisions,
        challenges,
        outcomes,
        screenshots,
        logoAssetPath,
        bannerAssetPath,
      ];
}
