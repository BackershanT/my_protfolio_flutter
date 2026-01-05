import 'package:easy_localization/easy_localization.dart';

class AppTexts {
  // Hero section
  static String get heroName => 'heroName'.tr();
  static List<String> get heroRoles => 'heroRoles'.tr().split(',');
  // Note: I'll update the JSON to use a comma-separated string or just handle it differently.
  // Actually easy_localization has trList but it's easier to just use a key that returns a list if we use it correctly.
  // Wait, easy_localization's .tr() returns a string.

  static String get heroDescription => 'heroDescription'.tr();
  static String get resumeButtonText => 'resumeButtonText'.tr();
  static String get viewProjects => 'viewProjects'.tr();

  // About section
  static String get aboutTitle => 'aboutTitle'.tr();
  static String get aboutDescription => 'aboutDescription'.tr();
  static String get flutterDevTitle => 'flutterDevTitle'.tr();
  static String get flutterDevDesc => 'flutterDevDesc'.tr();
  static String get reactDevTitle => 'reactDevTitle'.tr();
  static String get reactDevDesc => 'reactDevDesc'.tr();
  static String get uiuxTitle => 'uiuxTitle'.tr();
  static String get uiuxDesc => 'uiuxDesc'.tr();

  // Skills section
  static String get skillsTitle => 'skillsTitle'.tr();

  // Technologies section
  static String get technologiesTitle => 'technologiesTitle'.tr();

  // Experience section
  static String get experienceTitle => 'experienceTitle'.tr();

  // Projects section
  static String get projectsTitle => 'projectsTitle'.tr();
  static String get viewCode => 'viewCode'.tr();
  static String get liveDemo => 'liveDemo'.tr();

  // Certifications section
  static String get certificationsTitle => 'certificationsTitle'.tr();

  // Testimonials section
  static String get testimonialsTitle => 'testimonialsTitle'.tr();

  // Contact section
  static String get contactTitle => 'contactTitle'.tr();
  static String get contactDescription => 'contactDescription'.tr();
  static String get contactNameHint => 'contactNameHint'.tr();
  static String get contactEmailHint => 'contactEmailHint'.tr();
  static String get contactMessageHint => 'contactMessageHint'.tr();
  static String get contactSendButton => 'contactSendButton'.tr();

  // Footer
  static String get footerText => 'footerText'.tr();

  // Navigation
  static String get navHome => 'navHome'.tr();
  static String get navAbout => 'navAbout'.tr();
  static String get navTechnologies => 'navTechnologies'.tr();
  static String get navSkills => 'navSkills'.tr();
  static String get navProjects => 'navProjects'.tr();
  static String get navProfiles => 'navProfiles'.tr();
  static String get navCertifications => 'navCertifications'.tr();
  static String get navBlog => 'navBlog'.tr();
  static String get navTestimonials => 'navTestimonials'.tr();
  static String get navContact => 'navContact'.tr();
}
