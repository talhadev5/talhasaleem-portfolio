/// Static personal/contact info used across Hero, Contact and Footer sections.
class AppConstants {
  AppConstants._();

  static const String fullName = 'Talha';
  static const String role = 'Senior Flutter Developer';
  static const String tagline =
      'I design and ship polished, production-grade Flutter apps — from first commit to store launch.';

  static const String email = 'mtalhadev5@gmail.com';
  static const String phone = '+92 341 1827155';
  static const String linkedInUrl = 'https://www.linkedin.com/in/mtalha-saleem';
  static const String githubUrl = 'https://github.com/talhadev5';

  /// Path to the profile photo shown in the Hero section. Drop a real
  /// headshot at this path — the Hero gracefully falls back to a
  /// placeholder avatar if the file isn't present yet.
  static const String profilePhotoAsset = 'assets/images/profile.jpg';

  static const String bio =
      'Senior Flutter Developer with 4+ years of experience and 30+ production apps shipped to the '
      'App Store and Google Play across fintech, digital wallets, fleet management, healthcare/AI, POS, '
      'matrimonial, fitness, and e-commerce domains. Specializes in Clean Architecture, BLoC/GetX/Provider '
      'state management, REST API and Firebase integration, and building scalable, production-ready '
      'cross-platform experiences from concept through store deployment. Combines strong hands-on '
      'engineering with mentoring experience, having trained aspiring developers in modern Flutter practices.';

  static const List<String> heroStats = [
    '4+ Years Experience',
    '30+ Apps Shipped',
    'iOS & Android',
    'Concept-to-Store Launch',
  ];

  /// Flat, uniform-chip skill list for the Core Skills section.
  static const List<String> coreSkills = [
    'Flutter',
    'Dart',
    'Clean Architecture',
    'BLoC',
    'GetX',
    'Provider',
    'Riverpod',
    'REST API Integration',
    'Firebase',
    'WebSockets',
    'WebRTC',
    'In-App Purchases',
    'StoreKit / Google Play Billing',
    'Stripe',
    'PayPal',
    'Google & Apple Maps',
    'AI/ML Integration',
    'CI/CD Pipelines',
  ];
}

/// Shared row model for both the Experience timeline and the
/// Certifications & Leadership timeline — same visual language.
class TimelineEntry {
  const TimelineEntry({
    required this.role,
    required this.organization,
    required this.period,
    required this.points,
  });

  final String role;
  final String organization;
  final String period;
  final List<String> points;
}

const List<TimelineEntry> experienceTimeline = [
  TimelineEntry(
    role: 'Senior Flutter Developer',
    organization: 'The Web Concept',
    period: 'Jun 2022 — Present',
    points: [
      'Lead architecture and delivery for 20+ production Flutter apps across fintech, fleet, health and e-commerce domains.',
      'Own Clean Architecture standards, BLoC state management patterns, and CI/CD pipelines for the mobile team.',
      'Shipped concept-to-store for clients spanning waste management, matrimonial, fitness and lottery platforms.',
    ],
  ),
  TimelineEntry(
    role: 'Mobile Apps Instructor',
    organization: 'Cybex IT Group',
    period: 'May 2022 — Present',
    points: [
      'Trained aspiring developers in modern Flutter practices, Dart fundamentals and state management.',
      'Built curriculum covering Clean Architecture, REST/Firebase integration and production deployment workflows.',
    ],
  ),
];

const List<TimelineEntry> certificationsTimeline = [
  TimelineEntry(
    role: 'Multiple Committees Head',
    organization: 'IEEE',
    period: '2025',
    points: [
      'Led end-to-end planning and execution across several event committees.',
      'Coordinated cross-functional teams and logistics for concurrent IEEE initiatives.',
    ],
  ),
  TimelineEntry(
    role: 'Team Head & Organizer',
    organization: 'IEEE',
    period: '2024',
    points: [
      'Managed daily team operations for IEEE events end-to-end.',
      'Handled technical and logistical coordination across the organizing team.',
    ],
  ),
  TimelineEntry(
    role: 'Organizer Certification, Pakistan Congress',
    organization: 'IEEE',
    period: '2022',
    points: [
      'Recognized for contributions organizing and coordinating IEEE community events.',
    ],
  ),
];

class EducationEntry {
  const EducationEntry({
    required this.degree,
    required this.institution,
    required this.period,
  });

  final String degree;
  final String institution;
  final String period;
}

const EducationEntry education = EducationEntry(
  degree: 'BS Computer Science',
  institution: 'Government College University, Faisalabad, Pakistan',
  period: '2021 — 2025',
);
