import 'package:flutter/material.dart';
import 'package:my_protfolio/features/shared/data/models/project_model.dart';
import 'package:my_protfolio/features/shared/core/constants/app_assets.dart';

class ProjectDesign {
  final Color bgColor;
  final Color textColor;
  final Color logoColor;
  final Color descColor;
  final List<BlobShape> blobs;

  const ProjectDesign({
    required this.bgColor,
    required this.textColor,
    required this.logoColor,
    required this.descColor,
    required this.blobs,
  });
}

class BlobShape {
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double width;
  final double height;
  final Color color;
  final BorderRadius borderRadius;

  const BlobShape({
    this.left,
    this.top,
    this.right,
    this.bottom,
    required this.width,
    required this.height,
    required this.color,
    required this.borderRadius,
  });
}

class ProjectData {
  static final projects = [
    Project(
      id: '1',
      title: 'Netflix Clone',
      description: 'Netflix Clone - A Netflix clone built with React',
      technologies: ['React', 'firebase', 'useState'],
      imageUrl: AppAssets.projectNetflix,
      screenshots: [AppAssets.projectNetflix01, AppAssets.projectNetflix02],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.website,
      readmeFilePath: 'assets/projects/netflix/README.md',
    ),

    Project(
      id: '2',
      title: 'Movie App',
      description: 'Movie App - A movie app with search functionality',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectMovieApp,
      screenshots: [
        AppAssets.projectMovieApp01,
        AppAssets.projectMovieApp02,
        AppAssets.projectMovieApp03,
        AppAssets.projectMovieApp04,
        AppAssets.projectMovieApp05,
        AppAssets.projectMovieApp06,
        AppAssets.projectMovieApp07,
        AppAssets.projectMovieApp08,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeFilePath: 'assets/projects/movie_app/README.md',
    ),

    Project(
      id: '3',
      title: 'Leo Inspector Admin',
      description:
          'Leo Inspector Admin  - App with inspecting the heavy Vehicles  and create certificate',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectInspector,
      screenshots: [AppAssets.projectInspector],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeFilePath:
          'assets/projects/leo_inspector_admin/leo_inspector_admin_readme.md',
    ),

    Project(
      id: '4',
      title: 'Leo Inspector',
      description:
          'Leo Inspector - App with inspecting the heavy Vehicles  and create certificate',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectInspector,
      screenshots: [AppAssets.projectInspector],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeFilePath: 'assets/projects/leo_inspector/leo_inspector_readme.md',
    ),

    Project(
      id: '5',
      title: 'Leo Rigging Calculator',
      description: 'Leo Rigging Calculator - A calculator built with flutter.',
      technologies: ['Flutter', 'Dart'],
      imageUrl: AppAssets.projectRigCalculator,
      screenshots: [AppAssets.projectRigCalculator],
      codeUrl: '',
      demoUrl:
          'https://play.google.com/store/search?q=leo+rigging+calculator&c=apps&hl=en_IN',
      type: ProjectType.mobile,
      readmeFilePath:
          'assets/projects/leo_rigging_calculator/leo_rigging_calculator_readme.md',
    ),

    Project(
      id: '6',
      title: 'Reachout',
      description:
          'Reachout - A social platform for connecting with people.with card creating functionality',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectReachout,
      screenshots: [AppAssets.projectReachout],
      codeUrl: '',
      demoUrl:
          'https://play.google.com/store/apps/details?id=in.reachout_mobile&hl=en_IN',
      type: ProjectType.mobile,
      readmeFilePath: 'assets/projects/reachout/reachout_readme.md',
    ),

    Project(
      id: '7',
      title: 'Calculator',
      description: 'A fast, lightweight Calculator App built using Flutter, combining both Simple and Scientific calculation modes in a single application. The app is designed with a clean UI, smooth interactions, and accurate mathematical operations.',
      technologies: ['Flutter', 'stateManagement'],
      imageUrl: AppAssets.projectCalculator,
      screenshots: [
        AppAssets.projectCalculator01,
        AppAssets.projectCalculator02,
        AppAssets.projectCalculator03,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeFilePath: 'assets/projects/calculator/calculator_readme.md',
    ),

    Project(
      id: '8',
      title: 'ckbeton - wordpress website',
      description:
          'ckbeton.bizonline.ae - A business website built using WordPress CMS',
      technologies: ['WordPress', 'Divi', 'PHP', 'jQuery'],
      imageUrl: AppAssets.projectCkBeton,
      isFullStack: false,
      screenshots: [
        AppAssets.projectCkBetonHome,
        AppAssets.projectCkBetonAbout,
        AppAssets.projectCkBetonContact,
        AppAssets.projectCkBetonServices,
      ],
      codeUrl: '',
      demoUrl: 'https://ckbeton.bizonline.ae',
      type: ProjectType.website,
      readmeFilePath: 'assets/projects/ck/ckbeton_readme.md',
    ),
    Project(
      id: '9',
      title: 'Mahathma Veliyancode',
      description: 'Mahathma Veliyancode - A website built with React',
      technologies: ['React', 'useState'],
      imageUrl: AppAssets.projectMahathma,
      screenshots: [AppAssets.projectMahathma01],
      codeUrl: '',
      demoUrl: 'https://mahathmavkdtests.netlify.app/',
      type: ProjectType.website,
      readmeFilePath: 'assets/projects/mahathma/mahathma_readme.md',
    ),

    Project(
      id: '10',
      title: 'My Games',
      description:
          'My Games - A collection of games built with Flutter and the Flame game engine.',
      technologies: ['flutter', 'Flame', 'Forge 2D'],
      imageUrl: AppAssets.projectMyGame,
      screenshots: [
        AppAssets.projectMyGame01,
        AppAssets.projectMyGame02,
        AppAssets.projectMyGame03,
        AppAssets.projectMyGame04,
        AppAssets.projectMyGame05,
        AppAssets.projectMyGame06,
        AppAssets.projectMyGame07,
        AppAssets.projectMyGame08,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeFilePath: 'assets/projects/mygame/my_games_readme.md',
    ),

    Project(
      id: '11',
      title: 'Door to Door',
      description:
          'Door to Door Application for Delivering groceries and other essentials from your doorstep.',
      technologies: ['Flutter', 'Getx', 'Flutter Maps', 'Rest Apis'],
      imageUrl: AppAssets.projectDorToDor24,
      screenshots: [
        AppAssets.projectDorToDor24Splash,
        AppAssets.projectDorToDor24Login,
        AppAssets.projectDorToDor24Signup,
        AppAssets.projectDorToDor24Location,
        AppAssets.projectDorToDor24Language,
        AppAssets.projectDorToDor24Home,
        AppAssets.projectDorToDor24Menu,
        AppAssets.projectDorToDor24Product,
        AppAssets.projectDorToDor24Cart,
        AppAssets.projectDorToDor24CartEmpty,
      ],
      codeUrl: '',
      demoUrl:
          'https://play.google.com/store/apps/details?id=com.irshad.dortodor&hl=en_IN',
      type: ProjectType.mobile,
      readmeFilePath: 'assets/projects/dortodor24/door_to_door_readme.md',
    ),

    Project(
      id: '12',
      title: 'Yachii',
      description: 'Yachii - Company Website with React.',
      technologies: ['React', 'JavaScript', 'useState'],
      imageUrl: AppAssets.projectYachii,
      screenshots: [AppAssets.projectYachii01],
      codeUrl: '',
      demoUrl: 'https://yachii.com/',
      type: ProjectType.website,
      readmeFilePath: 'assets/projects/yachii/yachii_readme.md',
    ),

    Project(
      id: '13',
      title: 'My Bus',
      description:
          'My Bus App - A bus tracking app with real-time location updates and route information.',
      technologies: ['Flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectMyBus,
      screenshots: [
        AppAssets.projectMyBus01,
        AppAssets.projectMyBus02,
        AppAssets.projectMyBus03,
        AppAssets.projectMyBus04,
        AppAssets.projectMyBus05,
        AppAssets.projectMyBus06,
        AppAssets.projectMyBus07,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeFilePath: 'assets/projects/mybus/my_bus_readme.md',
    ),

    Project(
      id: '14',
      title: 'YChat',
      description:
          ' YChat Application for messaging screen mirroring and sharing.',
      technologies: ['Flutter', 'Socket.io', 'flutter webrtc'],
      imageUrl: AppAssets.projectYchat,
      isFullStack: false,
      screenshots: [
        AppAssets.projectYchat01,
        AppAssets.projectYchat02,
        AppAssets.projectYchat03,
        AppAssets.projectYchat04,
        AppAssets.projectYchat05,
        // AppAssets.projectYchat06,
        // AppAssets.projectYchat07,
        // AppAssets.projectYchat08,
        // AppAssets.projectYchat09,
        // AppAssets.projectYchat10,
        // AppAssets.projectYchat11,
        // AppAssets.projectYchat12,
        // AppAssets.projectYchat13,
        // AppAssets.projectYchat14,
        // AppAssets.projectYchat15,
        // AppAssets.projectYchat16,
        // AppAssets.projectYchat17,
        // AppAssets.projectYchat18,
        // AppAssets.projectYchat19,
        // AppAssets.projectYchat20,
        // AppAssets.projectYchat21,
        // AppAssets.projectYchat22,
        // AppAssets.projectYchat23,
        // AppAssets.projectYchat24,
        // AppAssets.projectYchat25,
        // AppAssets.projectYchat26,
        // AppAssets.projectYchat27,
        // AppAssets.projectYchat28,
        // AppAssets.projectYchat29,
        // AppAssets.projectYchat30,
        // AppAssets.projectYchat31,
        // AppAssets.projectYchat32,
        // AppAssets.projectYchat33,
        // AppAssets.projectYchat34,
        // AppAssets.projectYchat35,
        // AppAssets.projectYchat36,
        // AppAssets.projectYchat37,
        // AppAssets.projectYchat38,
        // AppAssets.projectYchat39,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeFilePath: 'assets/projects/ychat/ychat_readme.md',
    ),

    Project(
      id: '15',
      title: 'YChat Admin',
      description: 'The YChat Admin App is a dedicated administration and moderation panel built to manage and control the YChat messaging platform. It enables administrators to monitor users, enforce policies, and maintain platform integrity through real-time oversight and management tools.',
      technologies: ['flutter', 'firebase', 'RestApi'],
      imageUrl: AppAssets.projectYchat,
      screenshots: [
        AppAssets.projectYchatAdminLogin,
        AppAssets.projectYchatAdminSignup,
        AppAssets.projectYchatAdminForgetPassword,
        AppAssets.projectYchatAdminHome,
        AppAssets.projectYchatAdminHome1,
        AppAssets.projectYchatAdmin02,
        AppAssets.projectYchatAdminBanner,
        AppAssets.projectYchatAdminTicketing,
        AppAssets.projectYchatAdminNotifications,
        AppAssets.projectYchatAdminAppsHome,
        AppAssets.projectYchatAdminAppsHomeDetails,
        AppAssets.projectYchatAdminUserManagement,
        AppAssets.projectYchatAdminManagement,
        AppAssets.projectYchatAdminSettings,
      ],
      codeUrl: '',
      demoUrl: 'https://ychat-admin.netlify.app/#/login',
      type: ProjectType.website,
      readmeFilePath: 'assets/projects/ychat_admin/ychat_admin_readme.md',
    ),

    // E-commerce Platform Project
    Project(
      id: '16',
      title: 'E-Commerce Platform',
      description:
          'Full-featured e-commerce platform with product catalog, shopping cart, and payment processing',
      technologies: ['Flutter', 'Firebase', 'Stripe', 'Provider'],
      imageUrl: AppAssets.projectEcommerce,
      screenshots: [
        AppAssets.projectEcommerce01,
        AppAssets.projectEcommerce02,
        AppAssets.projectEcommerce03,
        AppAssets.projectEcommerce04,
        AppAssets.projectEcommerce05,
        AppAssets.projectEcommerce06,
        AppAssets.projectEcommerce07,
        AppAssets.projectEcommerce08,
        AppAssets.projectEcommerce09,
        AppAssets.projectEcommerce10,
        AppAssets.projectEcommerce11,
        AppAssets.projectEcommerce12,
        AppAssets.projectEcommerce13,
        AppAssets.projectEcommerce14,
        AppAssets.projectEcommerce15,
        AppAssets.projectEcommerce16,
        AppAssets.projectEcommerce17,
        AppAssets.projectEcommerce18,
        AppAssets.projectEcommerce19,
        AppAssets.projectEcommerce20,
        AppAssets.projectEcommerce21,
        AppAssets.projectEcommerce22,
        AppAssets.projectEcommerce23,
        AppAssets.projectEcommerce24,
        AppAssets.projectEcommerce25,
        AppAssets.projectEcommerce26,
        AppAssets.projectEcommerce27,
        AppAssets.projectEcommerce28,
        AppAssets.projectEcommerce29,
        AppAssets.projectEcommerce30,
        AppAssets.projectEcommerce31,
        AppAssets.projectEcommerce32,
        AppAssets.projectEcommerce33,
        AppAssets.projectEcommerce34,
        AppAssets.projectEcommerce35,
        AppAssets.projectEcommerce36,
        AppAssets.projectEcommerce37,
      ],
      codeUrl: '',
      demoUrl: '',
      type: ProjectType.mobile,
      readmeFilePath: 'assets/projects/ecommerce/ecommerce_platform_readme.md',
    ),

    // Project(
    //   id: '17',
    //   title: 'Threads Admin',
    //   description: 'A modern e-commerce admin dashboard built with React and TypeScript. Features include product management, order tracking, customer management, analytics, revenue monitoring, banners, and settings. The dashboard has a clean, responsive UI with sidebar navigation and comprehensive data visualization capabilities.',
    //   technologies: ['React', 'TypeScript', 'Vite', 'TailwindCSS', 'Lucide React', 'React Router DOM'],
    //   imageUrl: AppAssets.projectThreadsAdmin,
    //   screenshots: [],
    //   codeUrl: '',
    //   demoUrl: '',
    //   type: ProjectType.website,
    //   readmeFilePath: 'assets/projects/threads/threads_admin_readme.md',
    // ),

    // Project(
    //   id: '18',
    //   title: 'Thread - Premium Fashion Clothing',
    //   description: 'A modern e-commerce website built with Next.js 16 for selling premium women\'s fashion clothing. The application features a complete shopping experience with product browsing, 3D product visualization, shopping cart functionality, favorites system, user authentication, and integrated payment processing. It includes responsive design for mobile and desktop, category-based navigation, and various promotional sections like new arrivals, best sellers, and offers.',
    //   technologies: ['Next.js', 'React', 'TypeScript', 'Tailwind CSS', 'Zustand', 'React Three Fiber', 'React Three Drei', 'Framer Motion', 'Axios', 'Razorpay API'],
    //   imageUrl: AppAssets.projectThreadsWebsite,
    //   screenshots: [],
    //   codeUrl: '',
    //   demoUrl: '',
    //   type: ProjectType.website,
    //   readmeFilePath: 'assets/projects/threads/threads_website_readme.md',
    // ),

    // Project(
    //   id: '19',
    //   title: 'Threads Backend',
    //   description: 'A backend API for a Threads clothing store built with Node.js and Express. The system handles user authentication, product management with variants (size, color, fabric), order processing, and payment integration with Razorpay. It includes both user-facing and admin functionalities with role-based access control.',
    //   technologies: ['TypeScript', 'Node.js', 'Express', 'MongoDB', 'Mongoose', 'JWT', 'Bcrypt', 'Cors', 'Cloudinary', 'Razorpay', 'Dotenv'],
    //   imageUrl: AppAssets.projectThreadsBackend,
    //   screenshots: [],
    //   codeUrl: '',
    //   demoUrl: '',
    //   type: ProjectType.website,
    //   readmeFilePath: 'assets/projects/threads/threads_backend_readme.md',
    // ),

  ];

  static List<Project> getAllProjects() => List.from(projects.reversed);

  static List<ProjectDesign> getDesigns(bool isDark, bool isMobile) {
    return [
      // Design 1 - Brown/Coral theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFFCF6B6B).withValues(alpha: 0.7)
            : const Color(0xFFE88B8B).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF4A4A4A) : const Color(0xFF5A5A5A),
        blobs: [
          BlobShape(
            left: isMobile ? -150.0 : -100.0,
            top: isMobile ? -100.0 : -80.0,
            width: isMobile ? 350.0 : 450.0,
            height: isMobile ? 350.0 : 450.0,
            color: isDark
                ? const Color(0xFF4A3A3A).withValues(alpha: 0.4)
                : const Color(0xFF8B6B6B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(250),
              topRight: Radius.circular(180),
              bottomLeft: Radius.circular(200),
              bottomRight: Radius.circular(300),
            ),
          ),
          BlobShape(
            left: isMobile ? -120.0 : -80.0,
            bottom: isMobile ? -120.0 : -100.0,
            width: isMobile ? 320.0 : 400.0,
            height: isMobile ? 320.0 : 400.0,
            color: isDark
                ? const Color(0xFF5A4A4A).withValues(alpha: 0.3)
                : const Color(0xFF9B7B7B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(200),
              topRight: Radius.circular(280),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ),
          ),
        ],
      ),
      // Design 2 - Blue/Purple theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFF6B8BCF).withValues(alpha: 0.7)
            : const Color(0xFF8BA8E8).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF3A4A5A) : const Color(0xFF4A5A6A),
        blobs: [
          BlobShape(
            right: isMobile ? -140.0 : -90.0,
            top: isMobile ? -110.0 : -90.0,
            width: isMobile ? 340.0 : 440.0,
            height: isMobile ? 340.0 : 440.0,
            color: isDark
                ? const Color(0xFF3A4A5A).withValues(alpha: 0.4)
                : const Color(0xFF6B7B8B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(260),
              topRight: Radius.circular(190),
              bottomLeft: Radius.circular(210),
              bottomRight: Radius.circular(290),
            ),
          ),
          BlobShape(
            left: isMobile ? -110.0 : -70.0,
            bottom: isMobile ? -110.0 : -90.0,
            width: isMobile ? 310.0 : 390.0,
            height: isMobile ? 310.0 : 390.0,
            color: isDark
                ? const Color(0xFF4A5A6A).withValues(alpha: 0.3)
                : const Color(0xFF7B8B9B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(210),
              topRight: Radius.circular(270),
              bottomLeft: Radius.circular(230),
              bottomRight: Radius.circular(190),
            ),
          ),
        ],
      ),
      // Design 3 - Green/Teal theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFF6BCF8B).withValues(alpha: 0.7)
            : const Color(0xFF8BE8A8).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF3A5A4A) : const Color(0xFF4A6A5A),
        blobs: [
          BlobShape(
            left: isMobile ? -130.0 : -85.0,
            top: isMobile ? -105.0 : -85.0,
            width: isMobile ? 330.0 : 430.0,
            height: isMobile ? 330.0 : 430.0,
            color: isDark
                ? const Color(0xFF3A5A4A).withValues(alpha: 0.4)
                : const Color(0xFF6B8B7B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(240),
              topRight: Radius.circular(200),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(280),
            ),
          ),
          BlobShape(
            right: isMobile ? -115.0 : -75.0,
            bottom: isMobile ? -115.0 : -95.0,
            width: isMobile ? 315.0 : 395.0,
            height: isMobile ? 315.0 : 395.0,
            color: isDark
                ? const Color(0xFF4A6A5A).withValues(alpha: 0.3)
                : const Color(0xFF7B9B8B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(195),
              topRight: Radius.circular(265),
              bottomLeft: Radius.circular(225),
              bottomRight: Radius.circular(200),
            ),
          ),
        ],
      ),
      // Design 4 - Orange/Amber theme
      ProjectDesign(
        bgColor: isDark ? const Color(0xFF0F1822) : const Color(0xFFE5E5E5),
        textColor: isDark ? Colors.white : Colors.black,
        logoColor: isDark
            ? const Color(0xFFCF8B6B).withValues(alpha: 0.7)
            : const Color(0xFFE8A88B).withValues(alpha: 0.8),
        descColor: isDark ? const Color(0xFF5A4A3A) : const Color(0xFF6A5A4A),
        blobs: [
          BlobShape(
            right: isMobile ? -135.0 : -88.0,
            top: isMobile ? -108.0 : -88.0,
            width: isMobile ? 335.0 : 435.0,
            height: isMobile ? 335.0 : 435.0,
            color: isDark
                ? const Color(0xFF5A4A3A).withValues(alpha: 0.4)
                : const Color(0xFF8B7B6B).withValues(alpha: 0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(255),
              topRight: Radius.circular(185),
              bottomLeft: Radius.circular(215),
              bottomRight: Radius.circular(295),
            ),
          ),
          BlobShape(
            left: isMobile ? -118.0 : -78.0,
            bottom: isMobile ? -112.0 : -92.0,
            width: isMobile ? 318.0 : 398.0,
            height: isMobile ? 318.0 : 398.0,
            color: isDark
                ? const Color(0xFF6A5A4A).withValues(alpha: 0.3)
                : const Color(0xFF9B8B7B).withValues(alpha: 0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(205),
              topRight: Radius.circular(275),
              bottomLeft: Radius.circular(235),
              bottomRight: Radius.circular(185),
            ),
          ),
        ],
      ),
    ];
  }
}
