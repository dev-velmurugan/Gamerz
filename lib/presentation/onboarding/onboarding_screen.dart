import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_strings.dart';
import '../widgets/gradient_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      backgroundType: BackgroundType.grid,
      title: AppStrings.onboardingTitle,
      subtitle: AppStrings.onboardingSubtitle,
    ),
    OnboardingData(
      backgroundType: BackgroundType.horseRace,
      title: AppStrings.onboardingTitle,
      subtitle: AppStrings.onboardingSubtitle,
    ),
    OnboardingData(
      backgroundType: BackgroundType.football,
      title: AppStrings.onboardingTitle,
      subtitle: AppStrings.onboardingSubtitle,
    ),
  ];

  void _onNext() async {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_done', true);
      if (mounted) context.go(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) =>
                _OnboardingPage(data: _pages[index]),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppColors.background.withOpacity(0.95),
            AppColors.background,
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.onboardingTitle,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            AppStrings.onboardingSubtitle,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.75),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          SmoothPageIndicator(
            controller: _pageController,
            count: _pages.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primary,
              dotColor: Colors.white30,
              dotHeight: 8,
              dotWidth: 8,
              expansionFactor: 3,
            ),
          ),
          const SizedBox(height: 24),
          GradientButton(
            text: _currentPage == _pages.length - 1
                ? AppStrings.btnGetStarted
                : AppStrings.btnNext,
            onPressed: _onNext,
          ),
        ],
      ),
    );
  }
}

enum BackgroundType { grid, horseRace, football }

class OnboardingData {
  final BackgroundType backgroundType;
  final String title;
  final String subtitle;

  OnboardingData({
    required this.backgroundType,
    required this.title,
    required this.subtitle,
  });
}

class _OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: _buildBackground(),
    );
  }

  Widget _buildBackground() {
    switch (data.backgroundType) {
      case BackgroundType.grid:
        return _GridBackground();
      case BackgroundType.horseRace:
        return _ImageBackground(
          child: _SportOverlay(emoji: '🐎', label: 'Horse Racing'),
        );
      case BackgroundType.football:
        return _ImageBackground(
          child: _SportOverlay(emoji: '⚽', label: 'Football'),
        );
    }
  }
}

class _GridBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final games = [
      ('🎫', 'Lotto'),
      ('🐎', 'Horse'),
      ('🎾', 'Tennis'),
      ('🃏', 'Cards'),
      ('⚽', 'Football'),
      ('🏇', 'Racing'),
      ('🎰', 'Casino'),
      ('🏏', 'Cricket'),
      ('🏆', 'Sports'),
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: games.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundCard,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(games[index].$1, style: const TextStyle(fontSize: 40)),
              const SizedBox(height: 4),
              Text(
                games[index].$2,
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ImageBackground extends StatelessWidget {
  final Widget child;
  const _ImageBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.brown.shade800,
                Colors.brown.shade600,
                AppColors.background,
              ],
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _SportOverlay extends StatelessWidget {
  final String emoji;
  final String label;
  const _SportOverlay({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 280),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 100)),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
