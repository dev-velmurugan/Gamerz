import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../widgets/wallet_badge.dart';

class LotteryScreen extends StatelessWidget {
  const LotteryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _GameScreenBase(
      title: 'Lottery',
      bannerEmoji: '🎰',
      bannerColor1: const Color(0xFF4A148C),
      bannerColor2: const Color(0xFF7B1FA2),
      bannerTitle: 'Win Big Today!',
      bannerSubtitle: 'Draw every hour',
    );
  }
}

class CasinoScreen extends StatelessWidget {
  const CasinoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _GameScreenBase(
      title: 'Casino',
      bannerEmoji: '🎲',
      bannerColor1: const Color(0xFF1A237E),
      bannerColor2: const Color(0xFF283593),
      bannerTitle: 'Live Casino',
      bannerSubtitle: 'Real dealers, real wins',
    );
  }
}

class HorseRacingScreen extends StatelessWidget {
  const HorseRacingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _GameScreenBase(
      title: 'Horse Racing',
      bannerEmoji: '🐎',
      bannerColor1: const Color(0xFF3E2723),
      bannerColor2: const Color(0xFF5D4037),
      bannerTitle: 'Race to Win!',
      bannerSubtitle: 'Live races everyday',
    );
  }
}

class _GameScreenBase extends StatelessWidget {
  final String title;
  final String bannerEmoji;
  final Color bannerColor1;
  final Color bannerColor2;
  final String bannerTitle;
  final String bannerSubtitle;

  const _GameScreenBase({
    required this.title,
    required this.bannerEmoji,
    required this.bannerColor1,
    required this.bannerColor2,
    required this.bannerTitle,
    required this.bannerSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: ShaderMask(
          shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
          child: const Text(
            'GB',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: WalletBadge(balance: 200, onTap: () {}),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [bannerColor1, bannerColor2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(bannerEmoji, style: const TextStyle(fontSize: 60)),
                  const SizedBox(height: 12),
                  Text(
                    bannerTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bannerSubtitle,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'More games coming soon!',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
