import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pulso/core/providers/auth_provider.dart';

// Import your screens (we will create these placeholders next)
import '../../screens/home_screen.dart';
import '../../screens/login_screen.dart';
import '../../screens/register_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // Watch the auth state stream
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    // The redirect function determines where the user should go based on state
    redirect: (context, state) {
      // Check if we have a valid session
      final isAuthenticated = authState.value?.session != null;
      
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToRegister = state.matchedLocation == '/register';

      // If user is NOT authenticated and trying to access a protected route, send to login
      if (!isAuthenticated && !isGoingToLogin && !isGoingToRegister) {
        return '/login';
      }

      // If user IS authenticated and trying to go to login/register, send to home
      if (isAuthenticated && (isGoingToLogin || isGoingToRegister)) {
        return '/';
      }

      // No redirect needed
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
  );
});