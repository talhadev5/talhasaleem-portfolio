import '../../domain/entities/project.dart';
import '../models/project_model.dart';

/// Hardcoded local "CMS" for the portfolio's shipped-apps list.
/// Swap this for a remote datasource later without touching the rest
/// of the app — the repository already depends on the abstract interface.
class ProjectLocalDataSource {
  const ProjectLocalDataSource();

  List<Project> getProjects() => _projects;
}

const List<Project> _projects = [
  ProjectModel(
    id: 'roll-off-rolodex',
    name: 'Roll Off Rolodex',
    category: ProjectCategory.fleetLogistics,
    tagline: 'Fleet management for waste-hauling companies',
    description:
        'Complete iOS/Android fleet-management platform for waste-management companies: driver management, '
        'dumpster/schedule tracking, super-admin & company-admin roles, real-time Apple/Google Maps tracking, '
        'and subscription-based access via StoreKit in-app purchases.',
    features: [
      'Super-admin and company-admin role hierarchy',
      'Driver management and dumpster scheduling',
      'Real-time Apple/Google Maps fleet tracking',
      'Subscription access via StoreKit in-app purchases',
    ],
    techStack: ['Flutter', 'BLoC', 'Firebase', 'Apple Maps', 'StoreKit IAP'],
    storeLinks: [
      StoreLink(platform: StorePlatform.ios, url: 'https://apps.apple.com/pk/app/the-roll-off-rolodex/id6755901299'),
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
  ),
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
  ),
  ProjectModel(
    id: 'niwali',
    name: 'Niwali App',
    category: ProjectCategory.lifestyle,
    tagline: 'Lifestyle & community platform',
    description:
        'Lifestyle and community platform connecting users around shared interests, profiles and local '
        'discovery.',
    features: [
      'Profile-based community discovery',
      'In-app messaging',
      'Local content and interest feeds',
    ],
    techStack: ['Flutter', 'Provider', 'Firebase'],
    storeLinks: [
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=com.mtalhadev.niwali_app'),
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
    ],
    techStack: ['Flutter', 'Provider', 'Local Storage'],
    storeLinks: [
      StoreLink(platform: StorePlatform.android, url: 'https://play.google.com/store/apps/details?id=com.ahmedddev.account_manager'),
    ],
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
  ),
    // 2. Gratis
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
    techStack: [
      'Flutter',
      'BLoC',
      'Firebase',
      'REST APIs',
    ],
    storeLinks: [],
  ),

  // 3. GWallet
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
    techStack: [
      'Flutter',
      'BLoC',
      'Firebase',
      'REST APIs',
    ],
    storeLinks: [],
  ),

  // 4. TiKane
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
    techStack: [
      'Flutter',
      'BLoC',
      'Firebase',
      'REST APIs',
      'OTP Authentication',
    ],
    storeLinks: [],
  ),

  // 5. Munafa
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
    techStack: [
      'Flutter',
      'GetX',
      'Firebase',
      'REST APIs',
    ],
    storeLinks: [],
  ),

  // 6. Flora Heart
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
    techStack: [
      'Flutter',
      'GetX',
      'Firebase',
      'Local Notifications',
    ],
    storeLinks: [],
  ),

  // 7. Water Tracker
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
    techStack: [
      'Flutter',
      'GetX',
      'Local Storage',
      'Local Notifications',
    ],
    storeLinks: [],
  ),
];
