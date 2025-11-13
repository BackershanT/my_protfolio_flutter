import 'package:my_protfolio/features/shared/core/constants/app_assets.dart';

class SkillModel {
  final String assetPath;
  final String label;

  const SkillModel({
    required this.assetPath,
    required this.label,
  });
}

class SkillData {
  static const skills = [
    SkillModel(
      assetPath: AppAssets.skillsFlutter,
      label: 'Flutter',
    ),
    SkillModel(
      assetPath: AppAssets.skillsReact,
      label: 'React',
    ),
    SkillModel(
      assetPath: AppAssets.skillsJavascript,
      label: 'JavaScript',
    ),
    SkillModel(
      assetPath: AppAssets.skillsFirebase,
      label: 'Firebase',
    ),
    SkillModel(
      assetPath: AppAssets.skillsBloc,
      label: 'BLoC',
    ),
    SkillModel(
      assetPath: AppAssets.skillsRedux,
      label: 'Redux',
    ),
    SkillModel(
      assetPath: AppAssets.skillsNextjs,
      label: 'Next.js',
    ),
    SkillModel(
      assetPath: AppAssets.skillsSocket,
      label: 'Socket.IO',
    ),
       SkillModel(
      assetPath: AppAssets.skillsHtml,
      label: 'Html',
    ),
       SkillModel(
      assetPath: AppAssets.skillsCss,
      label: 'Css',
    ),
       SkillModel(
      assetPath: AppAssets.skillsFigma,
      label: 'Figma',
    ),
       SkillModel(
      assetPath: AppAssets.skillsXd,
      label: 'Xd',
    ),
  ];

  static List<SkillModel> getAllSkills() => skills;
}
