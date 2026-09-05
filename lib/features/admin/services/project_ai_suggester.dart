// Local rule-based AI project suggestion engine.
// Generates project overview descriptions, key feature ideas, and improvement
// suggestions based on project name, technologies, and project types.

class ProjectSuggestion {
  final String description;
  final List<String> keyFeatures;
  final List<String> improvements;
  final String category;
  final String label;

  const ProjectSuggestion({
    required this.description,
    required this.keyFeatures,
    required this.improvements,
    required this.category,
    required this.label,
  });
}

class ProjectAISuggester {
  static List<ProjectSuggestion> suggest({
    required String projectName,
    required List<String> technologies,
    required List<String> types,
    String? companyName,
  }) {
    if (projectName.trim().isEmpty) return [];

    final name = projectName.trim();
    final techList = technologies.map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
    final typeList = types.map((t) => t.trim()).where((t) => t.isNotEmpty).toList();

    final category = _detectCategory(techList, typeList);
    final techPhrase = _buildTechPhrase(techList);
    final company = (companyName?.trim().isNotEmpty == true) ? companyName!.trim() : null;

    return [
      _concise(name, techPhrase, typeList, category, company),
      _detailed(name, techList, typeList, category, company),
      _impactFocused(name, techPhrase, typeList, category, company),
    ];
  }

  static String _detectCategory(List<String> techs, List<String> types) {
    final all = [...techs, ...types].map((e) => e.toLowerCase()).join(' ');
    if (all.contains('flutter') || all.contains('mobile') || all.contains('ios') || all.contains('android')) return 'mobile';
    if (all.contains('react') || all.contains('next') || all.contains('vue') || all.contains('angular') || all.contains('website')) return 'web';
    if (all.contains('full stack') || all.contains('fullstack') || all.contains('node') || all.contains('backend')) return 'fullstack';
    if (all.contains('ai') || all.contains('ml') || all.contains('machine learning')) return 'ai';
    return 'general';
  }

  static String _buildTechPhrase(List<String> techs) {
    if (techs.isEmpty) return 'modern technologies';
    if (techs.length == 1) return techs.first;
    if (techs.length == 2) return '${techs[0]} and ${techs[1]}';
    return '${techs.sublist(0, techs.length - 1).join(', ')}, and ${techs.last}';
  }

  static List<String> _featureIdeas(String category) {
    return switch (category) {
      'mobile' => [
          'Smooth animations & native-feel transitions',
          'Offline-first architecture with local caching',
          'Push notifications for real-time engagement',
          'Dark mode / light mode support',
        ],
      'web' => [
          'SEO-optimized with server-side rendering',
          'Responsive design for mobile, tablet & desktop',
          'Lazy loading for optimal performance',
          'Real-time data updates without page reload',
        ],
      'fullstack' => [
          'RESTful API with authentication & RBAC',
          'Real-time features with WebSockets',
          'Database schema with optimized queries',
          'CI/CD pipeline with automated testing',
        ],
      'ai' => [
          'Machine learning model integration',
          'Natural language processing capabilities',
          'Model performance monitoring dashboard',
          'Explainable AI outputs for transparency',
        ],
      _ => [
          'Clean and intuitive user interface',
          'Modular architecture for maintainability',
          'Comprehensive error handling',
          'Secure data management',
        ],
    };
  }

  static List<String> _improvements(String category) {
    return switch (category) {
      'mobile' => [
          'Add biometric authentication for enhanced security',
          'Implement analytics to track user behavior',
          'Add deep linking for seamless navigation',
          'Optimize app size with code splitting',
        ],
      'web' => [
          'Add Progressive Web App (PWA) support',
          'Integrate A/B testing for UI optimization',
          'Add internationalization (i18n) support',
          'Implement skeleton loading states',
        ],
      'fullstack' => [
          'Add comprehensive API docs with Swagger',
          'Implement caching layer with Redis',
          'Add rate limiting for API security',
          'Set up monitoring with error tracking',
        ],
      _ => [
          'Write unit and integration tests',
          'Add performance benchmarks',
          'Improve documentation coverage',
          'Set up continuous integration',
        ],
    };
  }

  static ProjectSuggestion _concise(
      String name, String techPhrase, List<String> types, String category, String? company) {
    final typeStr = types.isNotEmpty ? types.first.toLowerCase() : 'app';
    final companyStr = company != null ? ' for $company' : '';
    final catPhrase = switch (category) {
      'mobile' => 'mobile experience',
      'web' => 'web experience',
      'fullstack' => 'end-to-end solution',
      'ai' => 'intelligent solution',
      _ => 'digital solution',
    };
    return ProjectSuggestion(
      label: '✦ Concise',
      description:
          '$name is a $typeStr project$companyStr built with $techPhrase. '
          'It delivers a seamless $catPhrase with a focus on performance, usability, and clean code architecture.',
      keyFeatures: _featureIdeas(category),
      improvements: _improvements(category),
      category: category,
    );
  }

  static ProjectSuggestion _detailed(
      String name, List<String> techs, List<String> types, String category, String? company) {
    final companyStr = company != null ? 'Developed for $company, $name' : name;
    final techStr = techs.isNotEmpty ? techs.join(', ') : 'modern frameworks';
    final catDesc = switch (category) {
      'mobile' =>
        'is a feature-rich mobile application that prioritizes user experience and cross-platform compatibility. '
            'Built with $techStr, it provides native performance with smooth animations and an intuitive interface.',
      'web' =>
        'is a modern web application crafted with $techStr. '
            'It focuses on fast page loads, exceptional accessibility, and a responsive design that works across all devices.',
      'fullstack' =>
        'is a comprehensive full-stack application powered by $techStr. '
            'It combines a robust backend API with an elegant frontend, offering real-time features and secure data management.',
      'ai' =>
        'is an AI-powered solution built with $techStr. '
            'It leverages machine learning to deliver intelligent features that adapt and improve with usage.',
      _ =>
        'is a software project built with $techStr. '
            'Designed with clean architecture principles for maintainability, scalability, and excellent developer experience.',
    };
    return ProjectSuggestion(
      label: '✦ Detailed',
      description: '$companyStr $catDesc',
      keyFeatures: _featureIdeas(category),
      improvements: _improvements(category),
      category: category,
    );
  }

  static ProjectSuggestion _impactFocused(
      String name, String techPhrase, List<String> types, String category, String? company) {
    final companyStr = company != null ? ' for $company' : '';
    final impact = switch (category) {
      'mobile' => 'empowers users on the go with a seamless mobile experience',
      'web' => 'connects users through a fast, accessible web platform',
      'fullstack' => 'delivers an end-to-end digital product from database to UI',
      'ai' => 'harnesses the power of AI to solve real-world challenges',
      _ => 'solves real problems through thoughtful software design',
    };
    return ProjectSuggestion(
      label: '✦ Impact-Focused',
      description:
          '$name$companyStr — a project that $impact. '
          'Developed using $techPhrase, it reflects a commitment to quality, performance, and user-centric design. '
          'Every feature is crafted with attention to detail, ensuring a polished and reliable product.',
      keyFeatures: _featureIdeas(category),
      improvements: _improvements(category),
      category: category,
    );
  }
}
