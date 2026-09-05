import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'core/config/app_router.dart';

import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:my_protfolio/core/providers/cursor_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_protfolio/core/localization/supabase_asset_loader.dart';
import 'package:my_protfolio/features/admin/data/providers/testimonial_provider.dart';
import 'package:my_protfolio/features/admin/data/providers/skill_provider.dart';
import 'package:my_protfolio/features/admin/data/providers/admin_blog_provider.dart';
import 'package:my_protfolio/features/admin/data/providers/admin_project_provider.dart';
import 'package:my_protfolio/features/admin/data/providers/admin_contact_provider.dart';
import 'package:my_protfolio/features/admin/data/providers/about_feature_provider.dart';
import 'package:my_protfolio/features/admin/data/providers/translation_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await EasyLocalization.ensureInitialized();
  
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("dotenv load note: $e");
  }

  String? envUrl;
  String? envKey;
  if (dotenv.isInitialized) {
    envUrl = dotenv.env['SUPABASE_URL'];
    envKey = dotenv.env['SUPABASE_ANON_KEY'];
  }

  final supabaseUrl = (envUrl ?? '').isNotEmpty
      ? envUrl!
      : const String.fromEnvironment('SUPABASE_URL');

  final supabaseKey = (envKey ?? '').isNotEmpty
      ? envKey!
      : const String.fromEnvironment('SUPABASE_ANON_KEY');

  if (supabaseUrl.isNotEmpty && supabaseKey.isNotEmpty) {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        publishableKey: supabaseKey,
        authOptions: const FlutterAuthClientOptions(
          authFlowType: AuthFlowType.pkce,
          autoRefreshToken: true,
        ),
      );
    } catch (e) {
      debugPrint("Supabase init note: $e");
    }
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      assetLoader: const SupabaseAssetLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CursorProvider()),
        ChangeNotifierProvider(create: (_) => TestimonialProvider()),
        ChangeNotifierProvider(create: (_) => SkillProvider()),
        ChangeNotifierProvider(create: (_) => AdminBlogProvider()),
        ChangeNotifierProvider(create: (_) => AdminProjectProvider()),
        ChangeNotifierProvider(create: (_) => AdminContactProvider()),
        ChangeNotifierProvider(create: (_) => AboutFeatureProvider()),
        ChangeNotifierProvider(create: (_) => TranslationProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return ScreenUtilInit(
            designSize: const Size(1920, 1080),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                title: 'Backer Shan - Portfolio',
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                theme: AppTheme.getTheme(context, false),
                darkTheme: AppTheme.getTheme(context, true),
                themeMode: themeProvider.themeMode,
                debugShowCheckedModeBanner: false,
                routerConfig: appRouter,
              );
            },
          );
        },
      ),
    );
  }
}
