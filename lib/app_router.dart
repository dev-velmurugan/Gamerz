import 'package:go_router/go_router.dart';
import '../core/constants/app_routes.dart';
import '../presentation/splash/splash_screen.dart';
import '../presentation/onboarding/onboarding_screen.dart';
import '../presentation/auth/login_screen.dart';
import '../presentation/auth/otp_screen.dart';
import '../presentation/auth/enter_name_screen.dart';
import '../presentation/auth/congrats_screen.dart';
import '../presentation/home/home_screen.dart'; 
import '../presentation/games/cricket_screen.dart';
import '../presentation/games/rummy_screen.dart';
import '../presentation/games/other_game_screens.dart';  
import 'presentation/leader board/game.dart';
import 'presentation/leader board/leader.dart';
import 'presentation/profile/profile.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.otp,
      builder: (context, state) => const OtpScreen(),
    ),
    GoRoute(
      path: AppRoutes.enterName,
      builder: (context, state) => const EnterNameScreen(),
    ),
    GoRoute(
      path: AppRoutes.congratulations,
      builder: (context, state) => const CongratsScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.games,
      builder: (context, state) => const GamesScreen(),
    ),
    GoRoute(
      path: AppRoutes.cricket,
      builder: (context, state) => const CricketScreen(),
    ),
    GoRoute(
      path: AppRoutes.rummy,
      builder: (context, state) => const RummyScreen(),
    ),
    GoRoute(
      path: AppRoutes.lottery,
      builder: (context, state) => const LotteryScreen(),
    ),
    GoRoute(
      path: AppRoutes.casino,
      builder: (context, state) => const CasinoScreen(),
    ),
    GoRoute(
      path: AppRoutes.horseRacing,
      builder: (context, state) => const HorseRacingScreen(),
    ),
    GoRoute(
      path: AppRoutes.leaderboard,
      builder: (context, state) => const LeaderboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);