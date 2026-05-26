import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'; 
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/auth_provider.dart';
import '../../providers/game_provider.dart';
import '../leader board/game.dart';
import '../leader board/leader.dart';
import '../profile/profile.dart';
import '../widgets/wallet_badge.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    _HomeTab(),
    GamesScreen(),
    LeaderboardScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().loadMatches();
      context.read<GameProvider>().loadWalletBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        backgroundColor: AppColors.backgroundSecondary,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textHint,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'Leaderboard'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Home Tab
// ─────────────────────────────────────────────────────────────────────────────
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    final gameProvider = context.watch<GameProvider>();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader(context, user?.name ?? 'User', gameProvider.walletBalance)),
          SliverToBoxAdapter(child: _buildHeroSection()),
          // ── Category Row ──────────────────────────────────────────────────
          SliverToBoxAdapter(child: _buildCategoryRow(context)),
          // ── IPL Banner ────────────────────────────────────────────────────
          SliverToBoxAdapter(child: _buildIPLBanner()),
          // ── Enter the World of GB ─────────────────────────────────────────
          SliverToBoxAdapter(child: _buildSectionTitle(AppStrings.enterWorldTitle)),
          SliverToBoxAdapter(child: _buildGameGrid(context)),
          // ── Fantasy Sports ────────────────────────────────────────────────
          SliverToBoxAdapter(child: _buildFantasySportsSection()),
          // ── Game Center ───────────────────────────────────────────────────
          SliverToBoxAdapter(child: _buildGameCenter()),
          // ── Promotional Space ─────────────────────────────────────────────
          SliverToBoxAdapter(child: _buildPromotionalSpace()),
          // ── Pure Luck ─────────────────────────────────────────────────────
          SliverToBoxAdapter(child: _buildPureLuckSection(gameProvider)),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context, String userName, double balance) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          const Icon(Icons.menu, color: AppColors.textPrimary, size: 28),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primary,
            child: Text(
              userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome', style: TextStyle(color: AppColors.textHint, fontSize: 11)),
              Text(userName,
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
          const Spacer(),
          WalletBadge(balance: balance, onTap: () {}),
        ],
      ),
    );
  }

  // ── Hero ───────────────────────────────────────────────────────────────────
  Widget _buildHeroSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
                  child: const Text(AppStrings.homeTitle,
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3)),
                ),
                const SizedBox(height: 4),
                const Text(AppStrings.securePlatform,
                    style: TextStyle(color: AppColors.textHint, fontSize: 11)),
              ],
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.backgroundCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            alignment: Alignment.center,
            child: ShaderMask(
              shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
              child: const Text('GB',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // ── Category Row — each item uses Image.asset ──────────────────────────────
  Widget _buildCategoryRow(BuildContext context) {
    final categories = [
      {'image': AppAssets.catCard,    'label': 'Card',    'route': AppRoutes.rummy},
      {'image': AppAssets.catSports,  'label': 'Sports',  'route': AppRoutes.cricket},
      {'image': AppAssets.catLottery, 'label': 'Lottery', 'route': AppRoutes.lottery},
      {'image': AppAssets.catCasino,  'label': 'Casino',  'route': AppRoutes.casino},
      {'image': AppAssets.catHorse,   'label': 'Horse',   'route': AppRoutes.horseRacing},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: categories.map((cat) {
          return GestureDetector(
            onTap: () => context.push(cat['route'] as String),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: _assetImage(cat['image'] as String, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 6),
                Text(cat['label'] as String,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── IPL Banner — single Image.asset ───────────────────────────────────────
  Widget _buildIPLBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: _assetImage(AppAssets.iplBanner, height: 110, fit: BoxFit.cover),
      ),
    );
  }

  // ── Section Title ──────────────────────────────────────────────────────────
  Widget _buildSectionTitle(String title, {String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ],
      ),
    );
  }

  // ── Game Grid — Rummy / Cricket+Lottery / Horse — all Image.asset ──────────
  Widget _buildGameGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Rummy — full width
          GestureDetector(
            onTap: () => context.push(AppRoutes.rummy),
            child: _gameImageCard(AppAssets.gameRummy, height: 110, label: 'Rummy'),
          ),
          const SizedBox(height: 8),
          // Cricket + Lottery — half width each
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push(AppRoutes.cricket),
                  child: _gameImageCard(AppAssets.gameCricket, height: 100, label: 'Cricket\nGames'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push(AppRoutes.lottery),
                  child: _gameImageCard(AppAssets.gameLottery, height: 100, label: 'Lottery'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Horse Racing — full width
          GestureDetector(
            onTap: () => context.push(AppRoutes.horseRacing),
            child: _gameImageCard(AppAssets.gameHorseRacing, height: 100, label: 'Horse Racing'),
          ),
        ],
      ),
    );
  }

  Widget _gameImageCard(String assetPath, {required double height, required String label}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          _assetImage(assetPath, height: height, fit: BoxFit.cover),
          // Label overlay
          Positioned(
            left: 12,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Fantasy Sports — World Cup + IPL images, then MI vs CSK match card ─────
  Widget _buildFantasySportsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          AppStrings.fantasySportsTitle,
          subtitle: AppStrings.fantasySportsSubtitle,
        ),
        // Horizontal scroll of tournament images
        SizedBox(
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _fantasyTournamentImage(AppAssets.fantasyWorldCup, 'T20 World Cup'),
              const SizedBox(width: 10),
              _fantasyTournamentImage(AppAssets.fantasyIPL, 'IPL'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Match card — MI vs CSK with team logo images
        _buildMatchCard(),
      ],
    );
  }

  Widget _fantasyTournamentImage(String assetPath, String label) {
    return Container(
      width: 160,
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: _assetImage(assetPath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildMatchCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            // Ongoing / Upcoming toggle
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundInput,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: const Text('Ongoing',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: const Text('Upcoming',
                          style: TextStyle(color: AppColors.textHint, fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('Monday, 15 Dec',
                style: TextStyle(color: AppColors.textHint, fontSize: 12)),
            const SizedBox(height: 12),
            // MI vs CSK with Image.asset team logos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _teamBadge(AppAssets.teamMI, 'MI'),
                Column(
                  children: [
                    const Text('Match Starting In :',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                    const SizedBox(height: 4),
                    Text('08h : 38m',
                        style: TextStyle(
                            color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                _teamBadge(AppAssets.teamCSK, 'CSK'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _teamBadge(String assetPath, String name) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.backgroundInput,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: ClipOval(child: _assetImage(assetPath, fit: BoxFit.cover)),
        ),
        const SizedBox(height: 4),
        Text(name,
            style: const TextStyle(
                color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 13)),
      ],
    );
  }

  // ── Game Center ────────────────────────────────────────────────────────────
  Widget _buildGameCenter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(AppStrings.gameCenterTitle, subtitle: AppStrings.gameCenterSubtitle),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _gameCenterCard('Leader\nboard', Icons.leaderboard),
              const SizedBox(width: 8),
              _gameCenterCard('Wallet', Icons.account_balance_wallet),
              const SizedBox(width: 8),
              _gameCenterCard('Game\nHistory', Icons.history),
              const SizedBox(width: 8),
              _gameCenterCard('Levels', Icons.emoji_events),
            ],
          ),
        ),
      ],
    );
  }

  Widget _gameCenterCard(String label, IconData icon) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  // ── Promotional Space ──────────────────────────────────────────────────────
  Widget _buildPromotionalSpace() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: const Text(AppStrings.promotionalSpace,
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // ── Pure Luck — Game 01–08, each uses Image.asset ─────────────────────────
  Widget _buildPureLuckSection(GameProvider gameProvider) {
    final games = [
      {'image': AppAssets.game01, 'label': 'Game 01', 'badge': 'HOT'},
      {'image': AppAssets.game02, 'label': 'Game 02', 'badge': 'NEW'},
      {'image': AppAssets.game03, 'label': 'Game 03', 'badge': null},
      {'image': AppAssets.game04, 'label': 'Game 04', 'badge': 'LIVE'},
      {'image': AppAssets.game05, 'label': 'Game 05', 'badge': null},
      {'image': AppAssets.game06, 'label': 'Game 06', 'badge': null},
      {'image': AppAssets.game07, 'label': 'Game 07', 'badge': null},
      {'image': AppAssets.game08, 'label': 'Game 08', 'badge': null},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(AppStrings.pureLuckTitle, subtitle: AppStrings.pureLuckSubtitle),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.82,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: games.length,
            itemBuilder: (context, index) => _pureLuckCard(games[index]),
          ),
        ),
      ],
    );
  }

  Widget _pureLuckCard(Map<String, dynamic> game) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _assetImage(game['image'] as String, fit: BoxFit.cover),
                ),
                if (game['badge'] != null)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(game['badge'] as String,
                          style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(game['label'] as String,
              style: const TextStyle(color: AppColors.textHint, fontSize: 10)),
        ],
      ),
    );
  }

  // ── Helper: Image.asset with fallback ─────────────────────────────────────
  Widget _assetImage(String path, {double? height, BoxFit fit = BoxFit.cover}) {
    return Image.asset(
      path,
      height: 200,
      width: double.infinity,
      fit: fit,
      errorBuilder: (context, error, stack) => Container(
        height: height,
        color: AppColors.backgroundCard,
        child: const Center(
          child: Icon(Icons.image_outlined, color: AppColors.textHint, size: 32),
        ),
      ),
    );
  }
}

class AppAssets {
  AppAssets._();
 
  // ── Category Icons ──────────────────────────────────────────────────────────
  // Drop your images into: assets/images/categories/
  static const String catCard     = 'assets/c1.png';
  static const String catSports   = 'assets/c2.png';
  static const String catLottery  = 'assets/c3.png';
  static const String catCasino   = 'assets/c4.png';
  static const String catHorse    = 'assets/c5.png';

  // ── Banners ─────────────────────────────────────────────────────────────────
  // Drop your images into: assets/images/banners/
  static const String iplBanner   = 'assets/f1.png'; 

  // ── Game Section Images ──────────────────────────────────────────────────────
  // Drop your images into: assets/images/games/
  static const String gameRummy        = 'assets/w2.png';
  static const String gameCricket      = 'assets/w3.png';
  static const String gameLottery      = 'assets/w4.png';
  static const String gameHorseRacing  = 'assets/w5.png';

  // ── Fantasy Sports ───────────────────────────────────────────────────────────
  // Drop your images into: assets/images/fantasy/
  static const String fantasyWorldCup  = 'assets/b1.png';
  static const String fantasyIPL       = 'assets/b2.png';

  // ── Team Logos ───────────────────────────────────────────────────────────────
  // Drop your images into: assets/images/teams/
  static const String teamMI   = 'assets/m1.png';
  static const String teamCSK  = 'assets/m2.png'; 

  // ── Pure Luck Games (Game 01–08) ─────────────────────────────────────────────
  // Drop your images into: assets/images/pure_luck/
  static const String game01 = 'assets/g (1).png';
  static const String game02 = 'assets/g (2).png';
  static const String game03 = 'assets/g (3).png';
  static const String game04 = 'assets/g (4).png';
  static const String game05 = 'assets/g (5).png';
  static const String game06 = 'assets/g (6).png';
  static const String game07 = 'assets/g (7).png';
  static const String game08 = 'assets/g (8).png';
}