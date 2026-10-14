import '../../domain/entities/project.dart';
import '../models/project_model.dart';

/// Hardcoded local "CMS" for the portfolio's shipped-apps list.
/// Swap this for a remote datasource later without touching the rest
/// of the app — the repository already depends on the abstract interface.
///
/// Case-study fields (`problem`, `solution`, `myContribution`,
/// `userJourneys`, `techDecisions`, `challenges`, `outcomes`) are kept
/// honest: Tier A projects (richer existing feature lists) get fuller
/// treatment; Tier B utility apps stay intentionally shorter rather than
/// padded. No invented metrics, timelines, team size or testimonials —
/// `outcomes` only ever states what's verifiable from this data itself
/// (a real store link, a delivered capability), never a number.
class ProjectLocalDataSource {
  const ProjectLocalDataSource();

  List<Project> getProjects() => _projects;
}

const List<Project> _projects = [
  // ── Tier A ──────────────────────────────────────────────────────────
  ProjectModel(
    id: 'roll-off-rolodex',
    name: 'Roll Off Rolodex',
    category: ProjectCategory.fleetLogistics,
    tagline: 'Fleet management for waste-hauling companies',
    description:
        'Dispatch and fleet-management platform for waste-hauling companies covering the full job lifecycle: a '
        'live dashboard, calendar-based scheduling for pick-up, drop-off and swap-out jobs, detailed job records '
        'with rate, tonnage and dumpster-size data, priority-ordered driver assignment, live task-status '
        'tracking, dumpster-lot inventory by yard size, and turn-by-turn navigation to every site — gated behind '
        'a StoreKit subscription.',
    features: [
      'Dashboard with live driver, schedule, completion and pending counts',
      'Calendar scheduling for Pick Up, Drop Off and Swap Out jobs',
      'Job detail with map pin, rate, tonnage, dumpster size, payment method and contract info',
      'Driver schedules with drag-to-reorder priority and swipe-to-start actions',
      'Per-job status tracking from Pending through On The Way to Completed',
      'Dumpster-lot inventory tracked by yard size',
      'Turn-by-turn navigation with live ETA and distance to each job site',
      'Subscription access via StoreKit in-app purchases',
    ],
    techStack: ['Flutter', 'BLoC', 'Firebase', 'Apple Maps', 'Google Maps', 'StoreKit IAP'],
    storeLinks: [
      StoreLink(platform: StorePlatform.ios, url: 'https://apps.apple.com/pk/app/the-roll-off-rolodex/id6755901299'),
    ],
    problem:
        'Waste-hauling companies coordinating drivers, dumpster placements and schedules by phone and paper lose '
        'track of fleet status, can\'t see a job\'s rate, tonnage or dumpster size at a glance, and have no way '
        'to know where a driver actually is on the way to a pickup.',
    solution:
        'A single dispatch app: a calendar schedules every Pick Up, Drop Off and Swap Out; each job carries its '
        'full detail — rate, tonnage, dumpster size, payment method, contract and billing address; drivers get a '
        'priority-ordered schedule with turn-by-turn navigation and a Pending → On The Way → Completed status '
        'they update themselves — gated behind a StoreKit subscription for paying fleet operators.',
    myContribution:
        'Designed and built the full iOS/Android app in Flutter end-to-end — the dashboard, calendar scheduling, '
        'job-detail and new-job forms, driver assignment with priority ordering, live task-status tracking, '
        'dumpster-lot inventory and turn-by-turn navigation on Apple/Google Maps — through to App Store release.',
    techDecisions: [
      TechDecision(title: 'BLoC', rationale: 'A job created or reassigned on one screen has to update the calendar, the driver\'s ranked schedule and the dashboard counts at once — centralized state kept all three in sync without manual refreshes.'),
      TechDecision(title: 'Apple & Google Maps', rationale: 'Native-feeling map rendering per platform for pickup-location pins and live turn-by-turn navigation.'),
      TechDecision(title: 'StoreKit IAP', rationale: 'Subscription gating handled through Apple\'s own billing rather than a custom paywall.'),
    ],
    userJourneys: [
      UserJourney(title: 'Scheduling and assigning a job', steps: [
        'Dispatcher creates a Pick Up, Drop Off or Swap Out job, capturing the service address, dumpster size, rate and tonnage',
        'Job sits in Unassigned until a driver is picked and ranked against their existing schedule',
        'The driver sees the job land in their own reorderable, priority-ordered schedule',
        'Dashboard counts and the calendar\'s day indicator update immediately',
      ]),
      UserJourney(title: 'Running a job from the driver side', steps: [
        'Driver opens an assigned job to see the map pin, customer, payment method and drop-off notes',
        'Turn-by-turn navigation shows live ETA and distance to the site',
        'Swiping "Start Pick Up" moves the task from Pending to On The Way',
        'Completing the job marks it Completed and reflects back in the dispatcher\'s dashboard',
      ]),
    ],
    challenges: [
      Challenge(
        challenge: 'Keeping two different admin roles — super-admin across companies, company-admin within one — from stepping on each other\'s data while sharing one codebase.',
        solution: 'Built the role hierarchy into the BLoC and data layer itself, scoping every query by company so the same screens render correctly for both roles without duplicated logic.',
      ),
      Challenge(
        challenge: 'A single job mutation — created, reassigned or completed — had to show up correctly in four places at once: the calendar dot, the assigned driver\'s priority list, the dashboard counters and the job\'s own status stepper.',
        solution: 'Centralized scheduling state in BLoC so one write fans out to all four views, instead of each screen fetching and reconciling its own copy.',
      ),
    ],
    outcomes: [
      'Shipped to the App Store with subscription access via StoreKit in-app purchases.',
      'Delivered a complete dispatch workflow — calendar scheduling, priority-ordered driver assignment, live task-status tracking and turn-by-turn navigation — in one role-based app.',
    ],
    screenshots: [
      ProjectScreenshot(assetPath: 'assets/images/projects/roll-off-rolodex_1_dashboard.jpg', caption: 'Dashboard — live driver, schedule, completed and pending counts, plus the latest job feed.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/roll-off-rolodex_2_schedules.jpg', caption: 'Schedules — calendar view with per-day job indicators and Unassigned / Assigned / Completed / Cancelled tabs.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/roll-off-rolodex_3_job-detail.jpg', caption: 'Job detail — map pin, rate, tonnage, dumpster size, payment method and contract, with swipe-to-start.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/roll-off-rolodex_5_create-job.jpg', caption: 'New job — Drop Off / Swap Out / Pick Up type, map-based address capture and dumpster-size selection.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/roll-off-rolodex_6_driver-assign.jpg', caption: 'A driver\'s own schedule — reorderable and ranked by priority.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/roll-off-rolodex_7_task-progress.jpg', caption: 'Per-job status tracking from Pending through On The Way to Completed.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/roll-off-rolodex_8_lot-list.jpg', caption: 'Dumpster-lot inventory, grouped and counted by yard size.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/roll-off-rolodex_9_navigation.jpg', caption: 'Turn-by-turn navigation to the job site, with live ETA and distance.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/roll-off-rolodex_4_search.jpg', caption: 'Instant search across every scheduled job.'),
    ],
    logoAssetPath: 'assets/images/projects/roll-off-rolodex_logo.png',
  ),
  ProjectModel(
    id: 'pepal-pos',
    name: 'Pepal POS',
    category: ProjectCategory.businessManagement,
    tagline: 'Point-of-sale app for lottery operators, across mobile and web',
    description:
        'Flutter point-of-sale app for lottery operators: sellers pick a lottery, enter numbers against straight-'
        'order, pair and 3/4/5-digit lotto bet types, stake an amount per line and print a thermal receipt — all '
        'under a fixed Super Admin → Admin → Manager → Seller role chain enforced throughout the app, not just on '
        'paper. Shipped to Android and iOS, then retrofitted — not rewritten — into an installable web PWA.',
    features: [
      'Two ticket-entry layouts — Compact grid and Detailed trading-terminal — sharing one BLoC',
      'Branded receipts: one on-screen preview and a matching ESC/POS thermal-printer output',
      'Winning-number declaration with a full payout preview before it\'s confirmed',
      'PIN-gated app lock backed by Keychain/Keystore, with per-device session revoke',
      'Per-user management dashboard scoped to each role\'s own permissions',
      'Seller dashboard with live sales totals, commission and win/payout tracking, plus result notifications',
      'Installable web PWA built from the same mobile codebase',
    ],
    techStack: ['Flutter', 'BLoC', 'Dio', 'Socket.IO', 'flutter_secure_storage', 'Bluetooth Thermal Printing', 'PWA'],
    storeLinks: [],
    hasNoPublicLink: true,
    problem:
        'Lottery operators handing sellers a point-of-sale tool need a fixed, enforced chain of who can configure '
        'what — payout multipliers, receipt branding, reporting lines — while sellers themselves just need a '
        'fast, reliable way to enter bets and print a receipt, on whatever device they happen to have, mobile or '
        'a browser.',
    solution:
        'One Flutter codebase enforcing the Super Admin → Admin → Manager → Seller hierarchy throughout, with two '
        'interchangeable ticket-entry layouts reading and writing the same BLoC, receipts built from one shared '
        'data model for both the on-screen preview and the Bluetooth thermal print output, a dry-run payout '
        'preview before any winning numbers are confirmed, and — later — the same codebase retrofitted into an '
        'installable web PWA rather than rebuilt.',
    myContribution:
        'Built the app iteratively, screen by screen, against the live backend API the whole way through — every '
        'feature its own repository and bloc/cubit, the enforced role hierarchy, the dual ticket-entry layouts, '
        'the receipt system (on-screen and ESC/POS thermal), the winning-numbers payout-preview flow, the PIN '
        'security layer, and the later retrofit to an installable PWA.',
    techDecisions: [
      TechDecision(title: 'BLoC per feature', rationale: 'Every feature gets its own repository and bloc/cubit instead of a shared god-repository — a few simple screens like PIN entry skip the bloc layer entirely and talk to their repository directly, matching the pattern already used elsewhere rather than forcing ceremony on a three-field form.'),
      TechDecision(title: 'Dio with one 401 handler', rationale: 'All network traffic runs through a single ApiService, so there\'s one place that decides what a 401 means — refresh and retry once, or clear the session — except PIN unlock and PIN login, which deliberately bypass that escalation since a 401 there just means "wrong PIN."'),
      TechDecision(title: 'flutter_secure_storage', rationale: 'The PIN lock and the signed-in device list are backed by Keychain/Keystore rather than plain prefs, so a revoked session or a forced logout is backed by the platform\'s own secure storage.'),
      TechDecision(title: 'print_bluetooth_thermal + esc_pos_utils_plus', rationale: 'The on-screen receipt and the raw ESC/POS bytes sent to the thermal printer are built from the same ReceiptData, so what a seller reviews is exactly what prints.'),
    ],
    userJourneys: [
      UserJourney(title: 'Selling a ticket', steps: [
        'Seller picks a lottery and a bet type — straight order, pairs, or a 3/4/5-digit lotto variant',
        'Numbers are entered in either the Compact grid or the Detailed trading-terminal layout, both writing the same StartSellingBloc',
        'A stake is set per line and added to the active ticket slip',
        'The receipt is reviewed on-screen, then printed to a Bluetooth thermal printer from the same data',
      ]),
      UserJourney(title: 'Declaring winning numbers', steps: [
        'Admin enters a draw\'s winning numbers',
        'The app runs a dry-run payout preview — every matching ticket, total exposure, the full multiplier breakdown',
        'Admin reviews the preview, including whether a lottery is using the org\'s default multipliers or its own custom rates',
        'A separate confirm step commits and broadcasts the result',
      ]),
    ],
    challenges: [
      Challenge(
        challenge: 'A fresh install\'s very first login reported "Session expired" immediately, despite the login API call itself returning a real 200.',
        solution: 'Traced to a race condition — the user object notified its listeners before the new token finished writing to secure storage, so an immediate authenticated call went out on a stale leftover token, 401\'d, lost the same race on refresh, and the failure handler correctly cleared a session it was never actually looking at. Fixed by firing the notification only after every write completes.',
      ),
      Challenge(
        challenge: 'Every login from the web build failed with "Invalid x-device-id header," while Android and iOS worked fine.',
        solution: 'The web branch had no hardware ID to send and was falling back to the raw browser user-agent string, which the backend\'s ID-shaped validation rejected outright. Fixed by generating a UUID v4 once per browser and persisting it in localStorage, so it behaves like identifierForVendor does on iOS.',
      ),
      Challenge(
        challenge: 'The active ticket slip needed to grow with each line added, cap out around four lines, and never push the page itself into scrolling — while everything above it varied in height with what was selected, causing intermittent RenderFlex overflow errors.',
        solution: 'Wrapped the slip in Expanded so it can never claim more than what\'s actually left on screen, with an inner ConstrainedBox capping it around four lines when more room is free — whichever bound is smaller wins, and only the list scrolls, never the page.',
      ),
    ],
    outcomes: [
      'Shipped to Android and iOS, then retrofitted — not rewritten — into an installable web PWA from the same codebase.',
      'Delivered a fixed, enforced four-role hierarchy (Super Admin, Admin, Manager, Seller) with permission-scoped management screens for each.',
      'Built a receipt system where the on-screen preview and the Bluetooth thermal print output are generated from one shared data model.',
    ],
    screenshots: [
      ProjectScreenshot(assetPath: 'assets/images/projects/pepal-pos_1_dashboard.jpg', caption: 'Seller dashboard — live sales total, commission, win/payout totals and recent transactions.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/pepal-pos_2_start-selling.jpg', caption: 'Ticket entry — bet-type tabs, ball input and the active ticket slip with running total.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/pepal-pos_3_receipt.jpg', caption: 'Branded receipt with QR code, built from the same data as the thermal print.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/pepal-pos_4_sale-report.jpg', caption: 'Sale Report — total sold, winnings paid/unpaid, deposits, withdrawals and net sales by date range.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/pepal-pos_5_winning-numbers.jpg', caption: 'Winning Numbers — searchable history of declared results per lottery.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/pepal-pos_6_winning-clients.jpg', caption: 'Winning Clients — payout clearance pace, per-ticket disbursement status and receipt replay.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/pepal-pos_7_settings-profile.jpg', caption: 'Settings — seller profile, role, branch and POS terminal ID, with session and PIN security.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/pepal-pos_8_settings-hardware.jpg', caption: 'Settings — Compact/Detailed ticket-entry toggle, auto-print and scan audio feedback.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/pepal-pos_9_menu.jpg', caption: 'Main navigation — Dashboard, Lotteries, Start Selling, Winning Numbers, Winning Clients and Sale Report.'),
    ],
  ),
  ProjectModel(
    id: 'global-wedlock',
    name: 'Global Wedlock',
    category: ProjectCategory.lifestyle,
    tagline: 'Matrimonial platform with real-time matching',
    description:
        'Secure matrimonial and social-connection platform with preference-, country-, and profile-based '
        'matching, real-time chat and calling, and tiered subscription plans.',
    features: [
      'Preference and country-based match discovery',
      'Real-time chat and voice/video calling',
      'Tiered subscription plans',
      'Profile verification and privacy controls',
    ],
    techStack: ['Flutter', 'BLoC', 'Firebase', 'WebRTC', 'REST API'],
    storeLinks: [
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=mtalhadev5.globalwedlock'),
    ],
    problem:
        'Matrimonial platforms built on generic social-app foundations rarely give users controllable, '
        'preference-driven discovery or private, verified communication — matching feels mismatched and '
        'conversations aren\'t well guarded.',
    solution:
        'An app built around explicit preference, country and profile filters for discovery, paired with '
        'real-time chat and WebRTC calling and tiered subscriptions, plus profile verification and privacy '
        'controls so both discovery and communication feel safe.',
    myContribution:
        'Built the Flutter app end-to-end — the preference-based match discovery, the real-time chat and '
        'calling layer on WebRTC, and the subscription tiers — shipped to Google Play.',
    techDecisions: [
      TechDecision(title: 'WebRTC', rationale: 'Peer-to-peer voice/video calling without routing media through a third-party calling service.'),
      TechDecision(title: 'Firebase', rationale: 'Real-time chat delivery and presence.'),
    ],
    userJourneys: [
      UserJourney(title: 'Finding and contacting a match', steps: [
        'Set discovery preferences by country and profile criteria',
        'Browse and open a verified profile',
        'Start a real-time chat',
        'Escalate to a voice or video call over WebRTC when ready',
      ]),
    ],
    outcomes: [
      'Shipped to Google Play with tiered subscription plans live.',
      'Delivered real-time chat and WebRTC voice/video calling in production.',
    ],
    logoAssetPath: 'assets/images/projects/global-wedlock_logo.png',
    bannerAssetPath: 'assets/images/projects/global-wedlock_banner.jpg',
  ),
  ProjectModel(
    id: 'macrofit',
    name: 'MacroFit',
    category: ProjectCategory.lifestyle,
    tagline: 'Cross-platform fitness & nutrition tracking',
    description:
        'Cross-platform fitness and nutrition app with subscription plans, personalized workout and meal '
        'tracking, and progress monitoring.',
    features: [
      'Personalized workout and meal plans',
      'Macro and nutrition tracking',
      'Progress monitoring and history',
      'Subscription-gated premium plans',
    ],
    techStack: ['Flutter', 'GetX', 'Firebase', 'REST API', 'In-App Purchases'],
    storeLinks: [
      StoreLink(platform: StorePlatform.ios, url: 'https://apps.apple.com/pk/app/macrofit-online/id1622981560'),
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=com.macrofitApp.online'),
    ],
    problem:
        'Generic fitness apps separate workout tracking from nutrition tracking, forcing users to juggle two '
        'apps to see the full picture of their progress.',
    solution:
        'One cross-platform app combining personalized workout and meal plans with macro/nutrition tracking '
        'and progress history, with premium plans unlocked via in-app purchase.',
    myContribution:
        'Implemented the Flutter app using GetX for state management, building the workout/meal plan screens, '
        'macro tracking, and the in-app-purchase-gated premium tier, shipped to both the App Store and Google Play.',
    techDecisions: [
      TechDecision(title: 'GetX', rationale: 'Lightweight reactive state suited to fast, form-heavy tracking screens like logging meals and workouts.'),
      TechDecision(title: 'In-App Purchases', rationale: 'Native store billing for the premium subscription tier on both platforms.'),
    ],
    userJourneys: [
      UserJourney(title: 'Logging a day', steps: [
        'Log a workout against a personalized plan',
        'Log meals and see macros update',
        'Review progress history',
        'Unlock premium plan content via in-app purchase',
      ]),
    ],
    outcomes: [
      'Shipped to both the App Store and Google Play.',
      'Delivered combined workout and nutrition tracking in a single cross-platform app.',
    ],
  ),
  ProjectModel(
    id: 'horeca',
    name: 'Horeca',
    category: ProjectCategory.ecommerce,
    tagline: 'eCommerce & distribution management',
    description:
        'eCommerce and distribution management app with distributor management, Stripe payments, and '
        'real-time order tracking for the hospitality and retail supply chain.',
    features: [
      'Distributor and catalog management',
      'Stripe payment integration',
      'Real-time order tracking',
      'Role-based access for vendors and buyers',
    ],
    techStack: ['Flutter', 'BLoC', 'Stripe', 'REST API', 'Firebase'],
    storeLinks: [
      StoreLink(platform: StorePlatform.ios, url: 'https://apps.apple.com/pk/app/horeca/id6757469822'),
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=mtalhadev5.horeca_app'),
    ],
    problem:
        'Hospitality and retail distributors running orders through phone calls or spreadsheets lose track of '
        'catalog accuracy, payment collection and order status.',
    solution:
        'An eCommerce and distribution app with distributor/catalog management, Stripe-powered payments, '
        'real-time order tracking, and role-based access separating vendors from buyers.',
    myContribution:
        'Built the Flutter app including the Stripe payment integration, the distributor/catalog management '
        'flows, and the role-based vendor/buyer access model, shipped to the App Store and Google Play.',
    techDecisions: [
      TechDecision(title: 'Stripe', rationale: 'Handles payment collection and compliance directly rather than building custom payment handling.'),
      TechDecision(title: 'BLoC', rationale: 'Clean separation between vendor and buyer role flows sharing the same catalog data.'),
      TechDecision(title: 'Firebase', rationale: 'Real-time order-status updates across vendor and buyer apps.'),
    ],
    userJourneys: [
      UserJourney(title: 'Placing and fulfilling an order', steps: [
        'Buyer browses the distributor catalog',
        'Buyer checks out with Stripe',
        'Vendor sees the order and updates status in real time',
        'Buyer tracks the order through to delivery',
      ]),
    ],
    challenges: [
      Challenge(
        challenge: 'Vendors and buyers needed meaningfully different app experiences without maintaining two separate codebases.',
        solution: 'Role-based access control at the data layer lets one Flutter app serve both roles, rendering different flows from the same catalog and order data.',
      ),
    ],
    outcomes: [
      'Shipped to the App Store and Google Play.',
      'Delivered live Stripe payment processing and real-time order tracking.',
    ],
  ),
  ProjectModel(
    id: 'poul3y',
    name: 'Poul3y',
    category: ProjectCategory.fleetLogistics,
    tagline: 'Multi-module poultry management system',
    description:
        'Subscription-based, multi-module poultry management system covering flock monitoring, point-of-sale, '
        'and integrated eCommerce for poultry businesses.',
    features: [
      'Flock health and production monitoring',
      'Integrated point-of-sale module',
      'eCommerce storefront for feed and supplies',
      'Subscription-based access tiers',
    ],
    techStack: ['Flutter', 'BLoC', 'Firebase', 'REST API'],
    storeLinks: [
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=mtalhadev5.poultry'),
    ],
    problem:
        'Poultry businesses running flock monitoring, point-of-sale and supply purchasing as separate manual '
        'processes have no single view of their operation.',
    solution:
        'A subscription-based, multi-module system combining flock health/production monitoring, an integrated '
        'POS, and an eCommerce storefront for feed and supplies in one app.',
    myContribution:
        'Built the Flutter/BLoC app covering all three modules — flock monitoring, point-of-sale, and the feed '
        'and supplies storefront — plus the subscription access tiers, shipped to Google Play.',
    techDecisions: [
      TechDecision(title: 'BLoC', rationale: 'One consistent state-management pattern across three fairly different modules kept the codebase maintainable.'),
    ],
    userJourneys: [
      UserJourney(title: 'Running the business day-to-day', steps: [
        'Record flock health and production data',
        'Process a sale through the integrated POS',
        'Order feed and supplies through the storefront',
        'Access is governed by subscription tier across all modules',
      ]),
    ],
    outcomes: [
      'Shipped to Google Play.',
      'Delivered three integrated modules — monitoring, POS and storefront — in a single subscription-based app.',
    ],
  ),
  ProjectModel(
    id: 'sympai',
    name: 'SympAi',
    category: ProjectCategory.healthAi,
    tagline: 'AI-powered skin condition detection',
    description:
        'AI-powered Flutter app detecting skin conditions from user-uploaded images via a trained ML model, '
        'with doctor-consultation recommendations, emergency-calling, and personalized health tips.',
    features: [
      'On-device image capture and ML-based skin analysis',
      'Doctor-consultation recommendations',
      'One-tap emergency calling',
      'Personalized health tips',
    ],
    techStack: ['Flutter', 'BLoC', 'TensorFlow Lite', 'REST API'],
    storeLinks: [],
    hasNoPublicLink: true,
    problem:
        'People noticing a skin concern often delay seeing a doctor, either from access barriers or uncertainty '
        'about whether it\'s serious enough to act on.',
    solution:
        'An app that analyzes a user-submitted photo on-device with a trained ML model, gives doctor-consultation '
        'recommendations, offers one-tap emergency calling, and personalized health tips — lowering the barrier '
        'to that first assessment.',
    myContribution:
        'Built the Flutter app end-to-end, including the camera capture flow, integrating the TensorFlow Lite '
        'model for on-device skin-condition analysis, and the doctor-recommendation and emergency-calling '
        'features. Showcase project — not published to a public store.',
    techDecisions: [
      TechDecision(title: 'TensorFlow Lite', rationale: 'Runs the ML model on-device, so image analysis works without sending user photos to a server.'),
      TechDecision(title: 'BLoC', rationale: 'Manages the capture-to-recommendation flow as a predictable state sequence.'),
    ],
    userJourneys: [
      UserJourney(title: 'Checking a concern', steps: [
        'Capture or upload a photo of the skin concern',
        'On-device ML model analyzes the image',
        'Review doctor-consultation recommendations and health tips',
        'One-tap call emergency services if urgent',
      ]),
    ],
    outcomes: [
      'Delivered on-device ML inference for skin-condition detection using TensorFlow Lite.',
      'Built as a showcase project demonstrating AI/ML integration in a production-quality Flutter app.',
    ],
  ),
  ProjectModel(
    id: 'gratis',
    name: 'Gratis',
    category: ProjectCategory.finance,
    tagline: 'Real-estate investment and profit tracking platform',
    description:
        'iOS and Android real-estate investment platform that allows users to invest money, '
        'monitor where their investments are allocated, and track investment performance including '
        'profits and losses across real-estate and trading activities.',
    features: [
      'Real-estate investment management',
      'Investment amount and portfolio tracking',
      'Profit and loss monitoring',
      'Investment performance history',
      'Trading activity and performance tracking',
      'Detailed financial activity overview',
    ],
    techStack: ['Flutter', 'BLoC', 'Firebase', 'REST APIs'],
    storeLinks: [],
    problem:
        'Individuals investing across real-estate and trading activities often can\'t see a unified picture of '
        'where their money is allocated or how it\'s performing.',
    solution:
        'A real-estate investment platform where users invest, see exactly where allocations sit, and track '
        'performance — profit/loss and history — across both real-estate and trading activity in one place.',
    myContribution:
        'Built the Flutter/BLoC app covering investment management, portfolio tracking, and the profit/loss and '
        'performance-history views, for iOS and Android.',
    techDecisions: [
      TechDecision(title: 'BLoC', rationale: 'Consistent state across portfolio, P&L and history views that all read from the same investment data.'),
    ],
    outcomes: [
      'Built for both iOS and Android.',
      'Delivered unified real-estate and trading investment tracking in one platform.',
    ],
    logoAssetPath: 'assets/images/projects/gratis_logo.png',
  ),
  ProjectModel(
    id: 'gwallet',
    name: 'GWallet',
    category: ProjectCategory.finance,
    tagline: 'Digital wallet for money and transaction management',
    description:
        'iOS and Android digital wallet application designed to manage user funds, investments, '
        'and financial transactions. Users can receive and add funds, invest money, monitor profit '
        'and loss, and maintain a complete history of incoming and outgoing transactions.',
    features: [
      'Digital wallet and balance management',
      'Add and receive funds',
      'Investment management',
      'Profit and loss tracking',
      'Incoming and outgoing transaction history',
      'Detailed financial activity tracking',
    ],
    techStack: ['Flutter', 'BLoC', 'Firebase', 'REST APIs'],
    storeLinks: [],
    problem:
        'Managing funds, investments and transaction history across separate finance tools is fragmented — '
        'users want one wallet that covers all of it.',
    solution:
        'A digital wallet combining fund management, investment tracking, profit/loss monitoring, and a '
        'complete incoming/outgoing transaction history.',
    myContribution:
        'Built the Flutter/BLoC wallet app covering fund management, investment tracking, and the full '
        'transaction-history system, for iOS and Android.',
    techDecisions: [
      TechDecision(title: 'BLoC', rationale: 'Wallet balance, investment state and transaction history all need to stay consistent in real time.'),
    ],
    userJourneys: [
      UserJourney(title: 'Managing funds', steps: [
        'Add or receive funds into the wallet',
        'Allocate funds to an investment',
        'Track profit and loss on that investment',
        'Review the full incoming/outgoing transaction history',
      ]),
    ],
    outcomes: [
      'Built for both iOS and Android.',
      'Delivered combined wallet, investment and transaction-history management in one app.',
    ],
    logoAssetPath: 'assets/images/projects/gwallet_logo.jpg',
  ),
  ProjectModel(
    id: 'tikane',
    name: 'TiKane',
    category: ProjectCategory.finance,
    tagline: 'Multi-panel wallet and payment management platform',
    description:
        'Complete iOS and Android wallet and financial management ecosystem for a US-based company, '
        'featuring separate admin, agent, and customer panels. The platform manages financial records, '
        'fund transfers, withdrawals, deposits, secure OTP verification, and referral-based functionality.',
    features: [
      'Separate admin, agent, and customer panels',
      'Digital wallet and balance management',
      'Add funds and withdrawals',
      'Money transfer functionality',
      'Secure OTP verification system',
      'Transaction and financial record management',
      'Referral and rewards system',
    ],
    techStack: ['Flutter', 'BLoC', 'Firebase', 'REST APIs', 'OTP Authentication'],
    storeLinks: [],
    problem:
        'A US-based wallet and payments business needed one platform serving three very different users — '
        'internal admins, field agents, and end customers — each with different permissions, without building '
        'three separate apps.',
    solution:
        'A multi-panel wallet ecosystem with separate admin, agent and customer panels sharing one financial '
        'core: wallet balances, fund transfers, withdrawals/deposits, OTP-secured verification, and a '
        'referral/rewards system.',
    myContribution:
        'Built the complete Flutter/BLoC app for a US-based client, implementing all three role panels — admin, '
        'agent and customer — the OTP verification flow, fund transfer/withdrawal/deposit logic, and the '
        'referral system, for iOS and Android.',
    techDecisions: [
      TechDecision(title: 'BLoC', rationale: 'Three distinct panels sharing one wallet and transaction core made predictable, testable state management essential.'),
      TechDecision(title: 'OTP Authentication', rationale: 'Secures fund transfers and withdrawals with a verification step before money moves.'),
      TechDecision(title: 'Firebase', rationale: 'Real-time balance and transaction sync across admin, agent and customer views of the same data.'),
    ],
    userJourneys: [
      UserJourney(title: 'Agent processing a customer transaction', steps: [
        'Agent authenticates into their panel',
        'Agent initiates a deposit or withdrawal for a customer',
        'OTP verification confirms the transaction',
        'Admin panel reflects the updated financial record in real time',
      ]),
      UserJourney(title: 'Customer using referrals', steps: [
        'Customer shares their referral link',
        'A new customer signs up through it',
        'Referral reward is credited to the wallet',
        'Customer tracks rewards in transaction history',
      ]),
    ],
    challenges: [
      Challenge(
        challenge: 'Keeping wallet balances and transaction records consistent across three panels that can all initiate money movement is a real correctness risk for a financial app.',
        solution: 'Centralized the financial record-keeping so every panel reads and writes through the same transaction model, with OTP verification gating any funds-moving action regardless of which panel initiates it.',
      ),
    ],
    outcomes: [
      'Built for a US-based client, for both iOS and Android.',
      'Delivered a three-panel admin/agent/customer financial platform with OTP-secured transactions and a working referral system.',
    ],
  ),
  ProjectModel(
    id: 'munafa',
    name: 'Munafa',
    category: ProjectCategory.businessManagement,
    tagline: 'Job costing and quotation management for contractors',
    description:
        'Complete iOS and Android business-management application built for small contractors to '
        'manage jobs, quotations, project costs, labor expenses, materials, and profitability. '
        'The platform helps contractors keep their complete job history and financial records organized.',
    features: [
      'Job and project management',
      'Professional quotation creation',
      'Job costing and expense tracking',
      'Labor and material cost management',
      'Profit and loss tracking',
      'Complete job history',
      'Business financial record management',
    ],
    techStack: ['Flutter', 'GetX', 'Firebase', 'REST APIs'],
    storeLinks: [],
    problem:
        'Small contractors tracking job costs, quotations and profitability across spreadsheets or paper lose '
        'visibility into which jobs are actually profitable.',
    solution:
        'A business-management app for contractors covering job and project management, professional quotation '
        'creation, job costing across labor and materials, and complete job history with financial records.',
    myContribution:
        'Built the Flutter/GetX app covering job management, the quotation builder, job costing, and profit/loss '
        'tracking, for iOS and Android.',
    techDecisions: [
      TechDecision(title: 'GetX', rationale: 'Fast, form-heavy screens like quotations and cost entries benefit from GetX\'s lightweight reactive state.'),
    ],
    userJourneys: [
      UserJourney(title: 'Running a job end-to-end', steps: [
        'Create a job and a professional quotation',
        'Track labor and material costs against it',
        'Review profit and loss for the job',
        'Keep the complete job history and financial record',
      ]),
    ],
    outcomes: [
      'Built for both iOS and Android.',
      'Delivered end-to-end job costing and quotation management for contractors.',
    ],
  ),
  ProjectModel(
    id: 'flora-heart',
    name: 'Flora Heart',
    category: ProjectCategory.healthWellness,
    tagline: 'Personal cycle and period tracking application',
    description:
        'iOS and Android period-tracking application designed to help users monitor menstrual cycles, '
        'period history, upcoming cycle dates, and personal tracking data with timely notifications and reminders.',
    features: [
      'Menstrual cycle tracking',
      'Period history management',
      'Cycle date predictions',
      'Personal tracking records',
      'Cycle reminders and notifications',
      'Upcoming period notifications',
    ],
    techStack: ['Flutter', 'GetX', 'Firebase', 'Local Notifications'],
    storeLinks: [],
    problem:
        'Period-tracking apps that are cluttered or overly clinical discourage consistent use — users want '
        'something simple that reliably predicts and reminds.',
    solution:
        'A focused cycle-tracking app covering menstrual cycle tracking, period history, date predictions, and '
        'timely reminders and notifications.',
    myContribution:
        'Built the Flutter/GetX app including the cycle tracking and prediction logic and the local-notification '
        'reminder system, for iOS and Android.',
    techDecisions: [
      TechDecision(title: 'Local Notifications', rationale: 'Cycle and period reminders work reliably without depending on a push-notification backend.'),
    ],
    outcomes: [
      'Built for both iOS and Android.',
      'Delivered cycle prediction with a reliable local reminder system.',
    ],
  ),
  ProjectModel(
    id: 'water-tracker',
    name: 'Water Tracker',
    category: ProjectCategory.healthWellness,
    tagline: 'Daily hydration tracking and reminder application',
    description:
        'iOS and Android hydration-tracking application that helps users monitor their daily water '
        'intake, maintain hydration history, and build consistent drinking habits through personalized reminders and notifications.',
    features: [
      'Daily water intake tracking',
      'Hydration history',
      'Daily hydration goals',
      'Water consumption records',
      'Personalized reminders',
      'Daily notification system',
    ],
    techStack: ['Flutter', 'GetX', 'Local Storage', 'Local Notifications'],
    storeLinks: [],
    problem: 'Building a consistent hydration habit is hard without visible daily progress and well-timed reminders.',
    solution:
        'A hydration app tracking daily water intake against goals, keeping history, and sending personalized, '
        'scheduled reminders.',
    myContribution:
        'Built the Flutter/GetX app including daily intake tracking, hydration history, and the personalized '
        'local-notification reminder system, for iOS and Android.',
    techDecisions: [
      TechDecision(title: 'Local Storage & Notifications', rationale: 'Tracking and reminders work fully offline, with no backend dependency for a single-user utility.'),
    ],
    outcomes: [
      'Built for both iOS and Android.',
      'Delivered offline-first daily hydration tracking with personalized reminders.',
    ],
  ),

  // ── Tier B — lighter treatment, same honesty standard ──────────────
  ProjectModel(
    id: 'poultry-calculator',
    name: 'Poultry Calculator',
    category: ProjectCategory.utilities,
    tagline: 'Feed & flock utility calculator',
    description:
        'Lightweight utility app for poultry farmers to quickly calculate feed requirements, flock economics '
        'and production estimates on the go.',
    features: [
      'Feed requirement and cost calculators',
      'Flock economics estimator',
      'Offline-first, lightweight utility design',
    ],
    techStack: ['Flutter', 'Provider', 'Local Storage'],
    storeLinks: [
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=mtalhadev5.poultry_calculator'),
    ],
    problem: 'Poultry farmers need fast feed and economics estimates on the go, not a heavy management system.',
    solution: 'A lightweight, offline-first calculator for feed requirements, flock economics and production estimates.',
    myContribution: 'Built as a focused Flutter utility app using Provider and local storage, shipped to Google Play.',
    outcomes: [
      'Shipped to Google Play.',
      'Delivered an offline-first calculator requiring no account or network connection.',
    ],
    logoAssetPath: 'assets/images/projects/poultry-calculator_logo.png',
  ),
  ProjectModel(
    id: 'long-island-volleyball',
    name: 'Long Island Volleyball',
    category: ProjectCategory.lifestyle,
    tagline: 'Community sports league companion app',
    description:
        'Community and sports-league companion app for a regional volleyball organization, covering '
        'schedules, standings, team rosters and league news.',
    features: [
      'League schedules and standings',
      'Team rosters and player profiles',
      'Push notifications for league news',
    ],
    techStack: ['Flutter', 'Provider', 'Firebase'],
    storeLinks: [
      StoreLink(platform: StorePlatform.ios, url: 'https://apps.apple.com/pk/app/long-island-volleyball/id6448804383'),
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=com.longislandvolleyball.app'),
    ],
    problem: 'A regional volleyball league\'s members had no single place to check schedules, standings and rosters.',
    solution: 'A companion app presenting league schedules, standings, team rosters, and push notifications for league news.',
    myContribution: 'Built the Flutter/Provider app with Firebase-backed league data and push notifications, for both iOS and Android.',
    outcomes: [
      'Shipped to both the App Store and Google Play.',
      'Delivered real-time league schedules, standings and push notifications for league news.',
    ],
  ),
  ProjectModel(
    id: 'fenix',
    name: 'Fenix',
    category: ProjectCategory.fintech,
    tagline: 'Digital lottery & fintech platform',
    description:
        'Digital lottery and fintech platform enabling ticket purchases, draw results, and secure in-app '
        'wallet transactions.',
    features: [
      'Digital ticket purchase flow',
      'Live draw results',
      'Secure in-app wallet and transaction history',
    ],
    techStack: ['Flutter', 'BLoC', 'REST API', 'Firebase'],
    storeLinks: [
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=mtalhadev5.Fenix'),
    ],
    problem: 'Players wanted a straightforward way to buy digital lottery tickets and check results without a separate wallet app.',
    solution: 'A digital lottery platform combining ticket purchases, live draw results, and a secure in-app wallet with transaction history.',
    myContribution: 'Built the Flutter/BLoC app covering ticket purchases, live draw results, and the in-app wallet, shipped to Google Play.',
    outcomes: [
      'Shipped to Google Play.',
      'Delivered an integrated ticket-purchase and wallet system with live draw results.',
    ],
  ),
  ProjectModel(
    id: 'deltho-lotto',
    name: 'Deltho Lotto',
    category: ProjectCategory.fintech,
    tagline: 'Digital lottery & fintech platform',
    description:
        'Digital lottery and fintech platform with ticket purchases, draw tracking, and secure wallet-based '
        'payments.',
    features: [
      'Digital ticket purchase flow',
      'Draw tracking and results history',
      'Secure wallet-based payments',
    ],
    techStack: ['Flutter', 'BLoC', 'REST API'],
    storeLinks: [
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=com.ahmedddev.deltho_lotto'),
    ],
    problem: 'Players wanted ticket purchases, draw tracking and secure payments handled in one lottery app.',
    solution: 'A digital lottery app with ticket purchases, draw tracking and results history, and secure wallet-based payments.',
    myContribution: 'Built the Flutter/BLoC app covering the ticket purchase flow, draw tracking, and wallet-based payments, shipped to Google Play.',
    outcomes: [
      'Shipped to Google Play.',
      'Delivered a complete ticket-purchase-to-payment flow with draw history.',
    ],
  ),
  ProjectModel(
    id: 'qaza-e-umri',
    name: 'Qaza-e-Umri',
    category: ProjectCategory.utilities,
    tagline: 'Islamic prayer & fasting tracker',
    description:
        'Islamic utility app helping users track and calculate missed (Qaza) prayers and fasts, with '
        'guided make-up scheduling.',
    features: [
      'Missed prayer and fast (Qaza) calculator',
      'Guided make-up scheduling',
      'Progress tracking over time',
    ],
    techStack: ['Flutter', 'Provider', 'Local Storage'],
    storeLinks: [
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=com.twintechsoft.islamicapp.qaza_e_umri'),
    ],
    problem: 'Tracking missed prayers and fasts and planning a make-up schedule is hard to do reliably from memory.',
    solution: 'A utility app that calculates missed prayers and fasts and guides users through a make-up schedule with progress tracking.',
    myContribution: 'Built the Flutter/Provider app with the Qaza calculator and progress-tracking logic, shipped to Google Play.',
    outcomes: [
      'Shipped to Google Play.',
      'Delivered an offline-first Qaza calculator with ongoing progress tracking.',
    ],
  ),
  ProjectModel(
    id: 'hibuy',
    name: 'Hibuy',
    category: ProjectCategory.ecommerce,
    tagline: 'Mobile-first eCommerce marketplace',
    description:
        'Mobile-first eCommerce marketplace app with product catalog browsing, cart management, and '
        'order checkout.',
    features: [
      'Product catalog and search',
      'Cart and checkout flow',
      'Order tracking and history',
    ],
    techStack: ['Flutter', 'BLoC', 'REST API', 'Firebase'],
    storeLinks: [
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=mtalhadev5.hibuy'),
    ],
    problem: 'Users wanted a straightforward mobile-first way to browse a product catalog and check out without a clunky multi-step process.',
    solution: 'A mobile-first eCommerce marketplace with catalog browsing and search, cart management, and order checkout and tracking.',
    myContribution: 'Built the Flutter/BLoC app covering catalog browsing, cart and checkout, and order tracking, shipped to Google Play.',
    outcomes: [
      'Shipped to Google Play.',
      'Delivered a full catalog-to-checkout eCommerce flow.',
    ],
    logoAssetPath: 'assets/images/projects/hibuy_logo.png',
    bannerAssetPath: 'assets/images/projects/hibuy_banner.jpg',
  ),
  ProjectModel(
    id: 'niwali',
    name: 'Niwali App',
    category: ProjectCategory.ecommerce,
    tagline: 'Wellness & supplement marketplace app',
    description:
        'Mobile eCommerce marketplace for wellness and supplement products — featured collections, product '
        'detail and pricing, a cart with quantity controls, and checkout.',
    features: [
      'Featured product collections and catalog browsing',
      'Cart with quantity controls and running total',
      'Checkout flow',
      'User profile management',
    ],
    techStack: ['Flutter', 'Provider', 'Firebase'],
    storeLinks: [
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=com.mtalhadev.niwali_app'),
    ],
    problem: 'Shoppers browsing wellness and supplement products need a simple, fast catalog-to-cart-to-checkout flow rather than a cluttered general marketplace.',
    solution: 'A focused wellness-marketplace app: featured collections, clear product cards with pricing, a cart with quantity controls, and checkout.',
    myContribution: 'Built the Flutter/Provider app covering the product catalog, cart and checkout flow, and profile management, shipped to Google Play.',
    userJourneys: [
      UserJourney(title: 'Buying a product', steps: [
        'Browse the Featured Collection on the home screen',
        'Open a product and add it to the cart',
        'Review quantities and the estimated total in the cart',
        'Check out',
      ]),
    ],
    outcomes: [
      'Shipped to Google Play.',
      'Delivered a complete catalog-to-checkout shopping flow for wellness products.',
    ],
    logoAssetPath: 'assets/images/projects/niwali_logo.png',
    bannerAssetPath: 'assets/images/projects/niwali_banner.jpg',
    screenshots: [
      ProjectScreenshot(assetPath: 'assets/images/projects/niwali_2_cart.jpg', caption: 'Cart — quantity controls per item and an estimated order total.'),
      ProjectScreenshot(assetPath: 'assets/images/projects/niwali_3_profile.jpg', caption: 'Profile — name, email and address.'),
    ],
  ),
  ProjectModel(
    id: 'account-manager',
    name: 'Account Manager',
    category: ProjectCategory.fintech,
    tagline: 'Personal finance & expense tracker',
    description:
        'Finance utility app for tracking personal accounts, expenses and balances, with clear reporting '
        'for day-to-day money management.',
    features: [
      'Multi-account balance tracking',
      'Expense categorization and reports',
      'Simple, offline-friendly data entry',
      'Shareable digital business-card templates',
      'PIN-protected company profile setup',
    ],
    techStack: ['Flutter', 'Provider', 'Local Storage'],
    storeLinks: [
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=com.ahmedddev.account_manager'),
    ],
    problem: 'Day-to-day personal finance tracking across multiple accounts gets messy without a simple, dedicated tool.',
    solution: 'A finance utility for tracking multiple accounts, categorizing expenses, and reviewing clear reports.',
    myContribution: 'Built the Flutter/Provider app with local-storage-backed account and expense tracking, shipped to Google Play.',
    outcomes: [
      'Shipped to Google Play.',
      'Delivered offline-friendly multi-account expense tracking and reporting.',
    ],
    logoAssetPath: 'assets/images/projects/account-manager_logo.png',
    bannerAssetPath: 'assets/images/projects/account-manager_banner.jpg',
  ),
  ProjectModel(
    id: 'tailor-app',
    name: 'Tailor App',
    category: ProjectCategory.utilities,
    tagline: 'Business utility for tailoring shops',
    description:
        'Business-utility app for tailoring shops to manage customer measurements, orders and delivery '
        'timelines.',
    features: [
      'Customer measurement records',
      'Order and delivery timeline tracking',
      'Simple shop-management workflow',
    ],
    techStack: ['Flutter', 'Provider', 'Local Storage'],
    storeLinks: [
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=mtalhadev5.tailor_app'),
    ],
    problem: 'Tailoring shops tracking customer measurements and order timelines on paper lose records and miss delivery dates.',
    solution: 'A shop-management utility recording customer measurements, orders, and delivery timelines in one place.',
    myContribution: 'Built the Flutter/Provider app covering measurement records and order/delivery tracking, shipped to Google Play.',
    outcomes: [
      'Shipped to Google Play.',
      'Delivered a digital record system replacing paper-based measurement and order tracking.',
    ],
  ),
  ProjectModel(
    id: 'pet-app',
    name: 'Pet App',
    category: ProjectCategory.lifestyle,
    tagline: 'Pet care & lifestyle companion',
    description:
        'Lifestyle companion app for pet owners covering care reminders, profiles for each pet, and '
        'health record keeping.',
    features: [
      'Multi-pet profiles',
      'Care and vaccination reminders',
      'Health record keeping',
    ],
    techStack: ['Flutter', 'Provider', 'Firebase'],
    storeLinks: [
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=com.mtalhadev5.pet_app'),
    ],
    problem: 'Pet owners managing care schedules and health records for multiple pets need reminders, not just a notes app.',
    solution: 'A companion app with multi-pet profiles, care and vaccination reminders, and health record keeping.',
    myContribution: 'Built the Flutter/Provider app with Firebase-backed pet profiles and reminders, shipped to Google Play.',
    outcomes: [
      'Shipped to Google Play.',
      'Delivered multi-pet profile management with care and vaccination reminders.',
    ],
  ),
];
