abstract final class AppStrings {
  // App
  static const String appName = 'Eldivex';
  static const String appTagline = 'Modern Healthcare Caregiving, Simplified';

  // Hero
  static const String heroHeadline = 'Transform Your Caregiving Operations with One Powerful Platform';
  static const String heroSubheading =
      'Manage caregivers, bookings, patients, care plans, schedules, and healthcare operations efficiently through a complete caregiving SaaS solution.';
  static const String heroCtaPrimary = 'Book Free Demo';
  static const String heroCtaSecondary = 'Request Pricing';
  static const String heroTrustBadge1 = 'Secure Cloud Platform';
  static const String heroTrustBadge2 = 'Healthcare Ready';
  static const String heroTrustBadge3 = 'Enterprise Scalable';
  static const String heroSocialProof = 'Early access now open — be among our founding partner agencies';

  // Navbar
  static const String navFeatures = 'Features';
  static const String navSolutions = 'Solutions';
  static const String navPricing = 'Pricing';
  static const String navContact = 'Contact';
  static const String navLogin = 'Log In';
  static const String navBookDemo = 'Book Demo';

  // Trusted companies
  static const String trustedTitle = 'Trusted by leading healthcare organizations';
  static const List<String> trustedCompanies = [
    'Healthcare Agency',
    'HomeCare Plus',
    'ElderCare Solutions',
    'MedAssist',
    'CareBridge',
    'NurseCare Pro',
    'VitalHealth',
    'LifeAssist',
  ];

  // Features
  static const String featuresTitle = 'Everything You Need to Run Your Agency';
  static const String featuresSubtitle =
      'A complete platform built for modern healthcare agencies. Manage every aspect of your caregiving operations from one dashboard.';

  static const List<Map<String, String>> features = [
    {
      'title': 'Caregiver Management',
      'description': 'Onboard, schedule, and track your caregiving team with intelligent profile management and availability tracking.',
      'icon': 'people',
    },
    {
      'title': 'Patient Records',
      'description': 'Maintain comprehensive patient profiles with medical history, preferences, and care requirements in one secure place.',
      'icon': 'folder_shared',
    },
    {
      'title': 'Smart Booking System',
      'description': 'Streamline appointment scheduling with automated conflict detection, reminders, and real-time calendar sync.',
      'icon': 'calendar_today',
    },
    {
      'title': 'Care Plans',
      'description': 'Create personalized care plans with tasks, goals, and progress tracking tailored to each patient\'s needs.',
      'icon': 'assignment',
    },
    {
      'title': 'Staff Scheduling',
      'description': 'Optimize shift planning with drag-and-drop scheduling, leave management, and workload balancing tools.',
      'icon': 'schedule',
    },
    {
      'title': 'Billing & Payments',
      'description': 'Automate invoicing, track payments, and generate financial reports with integrated billing management.',
      'icon': 'payments',
    },
    {
      'title': 'Multi-Role Dashboard',
      'description': 'Role-based dashboards for admins, coordinators, caregivers, and clients with personalized views.',
      'icon': 'dashboard',
    },
    {
      'title': 'Real-Time Notifications',
      'description': 'Stay informed with instant alerts for bookings, care updates, and important operational events.',
      'icon': 'notifications',
    },
  ];

  // How it works
  static const String howItWorksTitle = 'Get Started in Minutes';
  static const String howItWorksSubtitle =
      'Set up your entire caregiving operation in four simple steps — no technical expertise required.';

  static const List<Map<String, String>> steps = [
    {
      'number': '01',
      'title': 'Register Caregivers',
      'description': 'Add your caregiving team with profiles, certifications, and availability schedules.',
      'icon': 'person_add',
    },
    {
      'number': '02',
      'title': 'Add Patients',
      'description': 'Create detailed patient profiles with medical history and care requirements.',
      'icon': 'personal_injury',
    },
    {
      'number': '03',
      'title': 'Create Care Plans',
      'description': 'Design personalized care plans with specific tasks, goals, and timelines.',
      'icon': 'assignment_add',
    },
    {
      'number': '04',
      'title': 'Book Services',
      'description': 'Schedule caregiving sessions and assign the right caregiver to each patient.',
      'icon': 'event_available',
    },
    {
      'number': '05',
      'title': 'Track Operations',
      'description': 'Monitor all activity in real-time from your central operations dashboard.',
      'icon': 'analytics',
    },
  ];

  // Benefits
  static const String benefitsTitle = 'Built for Scale, Designed for Care';
  static const String benefitsSubtitle =
      'Eldivex helps healthcare agencies reduce manual work, improve patient outcomes, and scale their operations efficiently.';

  static const List<Map<String, String>> benefits = [
    {'text': 'Reduce manual operations by up to 70%', 'icon': 'trending_down'},
    {'text': 'Improve patient tracking and care quality', 'icon': 'favorite'},
    {'text': 'Faster caregiver assignment and scheduling', 'icon': 'speed'},
    {'text': 'Better healthcare workflows and compliance', 'icon': 'verified'},
    {'text': 'Scalable from 5 to 5,000+ caregivers', 'icon': 'expand'},
    {'text': 'Enterprise-grade data security', 'icon': 'security'},
  ];

  static const List<Map<String, String>> stats = [
    {'value': '70', 'suffix': '%', 'label': 'Reduction in Manual Work'},
    {'value': '15', 'suffix': 'hrs', 'label': 'Saved Per Agency Weekly'},
    {'value': '99', 'suffix': '%', 'label': 'Uptime Guaranteed'},
    {'value': '100', 'suffix': '%', 'label': 'HIPAA Compliant'},
  ];

  // Industries
  static const String industriesTitle = 'Built for Every Healthcare Setting';
  static const String industriesSubtitle = 'Whether you run a small home care agency or a large healthcare organization, Eldivex scales with you.';

  static const List<Map<String, String>> industries = [
    {'name': 'Home Healthcare', 'description': 'In-home personal care and medical support', 'icon': 'home_health'},
    {'name': 'Elder Care', 'description': 'Senior living and companionship services', 'icon': 'elderly'},
    {'name': 'Nursing Agencies', 'description': 'Skilled nursing and clinical care staffing', 'icon': 'local_hospital'},
    {'name': 'Rehabilitation', 'description': 'Post-surgery and physical therapy support', 'icon': 'accessibility_new'},
    {'name': 'Assisted Living', 'description': 'Residential care facility management', 'icon': 'apartment'},
    {'name': 'Healthcare Startups', 'description': 'Modern digital health platforms', 'icon': 'rocket_launch'},
  ];

  // Testimonials (reserved for real partner reviews)

  // Pricing
  static const String pricingTitle = 'Simple, Transparent Pricing';
  static const String pricingSubtitle = 'Choose the plan that fits your agency. All plans include a 14-day free trial.';

  static const List<Map<String, dynamic>> pricingPlans = [
    {
      'name': 'Starter',
      'monthlyPrice': 99,
      'annualPrice': 79,
      'description': 'Perfect for small agencies getting started',
      'highlighted': false,
      'features': [
        'Up to 25 caregivers',
        'Up to 50 patients',
        'Booking management',
        'Basic care plans',
        'Email support',
        'Mobile app access',
      ],
    },
    {
      'name': 'Growth',
      'monthlyPrice': 249,
      'annualPrice': 199,
      'description': 'For growing agencies that need more power',
      'highlighted': true,
      'features': [
        'Up to 100 caregivers',
        'Unlimited patients',
        'Advanced scheduling',
        'Full care plan suite',
        'Billing & invoicing',
        'Priority support',
        'Analytics dashboard',
        'API access',
      ],
    },
    {
      'name': 'Enterprise',
      'monthlyPrice': 599,
      'annualPrice': 479,
      'description': 'For large organizations with complex needs',
      'highlighted': false,
      'features': [
        'Unlimited caregivers',
        'Unlimited patients',
        'Custom workflows',
        'White-label options',
        'Dedicated support',
        'Custom integrations',
        'SLA guarantee',
        'On-premise option',
      ],
    },
  ];

  // Security
  static const String securityTitle = 'Enterprise-Grade Security';
  static const String securitySubtitle = 'Your data and your patients\' privacy are protected by industry-leading security standards.';

  static const List<Map<String, String>> securityFeatures = [
    {'title': 'HIPAA Compliant', 'description': 'Full compliance with healthcare data privacy regulations', 'icon': 'verified_user'},
    {'title': '256-bit Encryption', 'description': 'Military-grade encryption for all data at rest and in transit', 'icon': 'lock'},
    {'title': 'Role-Based Access', 'description': 'Granular permissions ensuring users only see what they need', 'icon': 'admin_panel_settings'},
    {'title': 'Audit Logs', 'description': 'Complete activity trail for compliance and accountability', 'icon': 'history'},
  ];

  // CTA
  static const String ctaTitle = 'Ready to Digitize Your Caregiving Operations?';
  static const String ctaSubtitle = 'Join our founding cohort of healthcare agencies. Get a 14-day free trial plus founding partner benefits — no credit card required.';
  static const String ctaPrimary = 'Schedule Demo';
  static const String ctaSecondary = 'Contact Sales';

  // Footer
  static const List<Map<String, dynamic>> footerLinks = [
    {
      'heading': 'Product',
      'links': ['Features', 'Pricing', 'Security', 'Integrations', 'Changelog'],
    },
    {
      'heading': 'Company',
      'links': ['About', 'Blog', 'Careers', 'Press', 'Contact'],
    },
    {
      'heading': 'Support',
      'links': ['Documentation', 'Help Center', 'Status', 'API Reference'],
    },
  ];

  // Auth
  static const String loginTitle = 'Welcome back';
  static const String loginSubtitle = 'Sign in to your Eldivex account';
  static const String registerTitle = 'Create your account';
  static const String registerSubtitle = 'Start your 14-day free trial';
  static const String forgotPasswordTitle = 'Reset your password';
  static const String forgotPasswordSubtitle = 'Enter your email and we\'ll send you a reset link';

  // Validation
  static const String requiredField = 'This field is required';
  static const String invalidEmail = 'Please enter a valid email address';
  static const String passwordTooShort = 'Password must be at least 8 characters';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  static const String invalidPhone = 'Please enter a valid phone number';
}
