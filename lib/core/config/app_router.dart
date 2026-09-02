import 'package:go_router/go_router.dart';
import 'package:my_protfolio/features/home/presentation/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_protfolio/features/admin/presentation/login_screen.dart';
import 'package:my_protfolio/features/admin/presentation/admin_layout.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/admin/login',
      builder: (context, state) => const AdminLoginScreen(),
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminLayout(),
      redirect: (context, state) async {
        final auth = Supabase.instance.client.auth;
        var session = auth.currentSession;

        // If no session exists, redirect to login
        if (session == null) {
          return '/admin/login';
        }

        // If the access token is expired, try refreshing it
        if (session.isExpired) {
          try {
            final response = await auth.refreshSession();
            session = response.session;
          } catch (_) {
            // Refresh failed — force re-login
            return '/admin/login';
          }

          // If refresh didn't return a valid session
          if (session == null) {
            return '/admin/login';
          }
        }

        // Enforce 7-day maximum session lifetime
        const maxSessionDays = 7;
        final createdAt = DateTime.tryParse(session.user.createdAt);
        final lastSignIn = session.user.lastSignInAt != null
            ? DateTime.tryParse(session.user.lastSignInAt!)
            : null;

        // Use lastSignInAt (login time) to determine session age
        final loginTime = lastSignIn ?? createdAt;
        if (loginTime != null) {
          final daysSinceLogin = DateTime.now().difference(loginTime).inDays;
          if (daysSinceLogin > maxSessionDays) {
            // Session is older than 7 days — sign out and redirect
            await auth.signOut();
            return '/admin/login';
          }
        }

        return null;
      },
    ),
  ],
);

