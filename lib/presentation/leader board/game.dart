import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = ['All', 'Sports', 'Cards', 'Casino', 'Lottery'];

  final List<Map<String, dynamic>> _allGames = [
    {
      'title': 'Cricket',
      'subtitle': 'Fantasy Cricket',
      'emoji': '🏏',
      'color1': Color(0xFF1B5E20),
      'color2': Color(0xFF388E3C),
      'badge': 'LIVE',
      'badgeColor': Color(0xFFE53935),
      'route': AppRoutes.cricket,
      'tab': 'Sports',
      'players': '2.4L playing',
    },
    {
      'title': 'Rummy',
      'subtitle': 'Classic Card Game',
      'emoji': '🃏',
      'color1': Color(0xFFB71C1C),
      'color2': Color(0xFFD32F2F),
      'badge': 'HOT',
      'badgeColor': Color(0xFFFF6F00),
      'route': AppRoutes.rummy,
      'tab': 'Cards',
      'players': '1.8L playing',
    },
    {
      'title': 'Horse Racing',
      'subtitle': 'Bet on Winners',
      'emoji': '🐎',
      'color1': Color(0xFF3E2723),
      'color2': Color(0xFF6D4C41),
      'badge': 'NEW',
      'badgeColor': Color(0xFF1565C0),
      'route': AppRoutes.horseRacing,
      'tab': 'Sports',
      'players': '52K playing',
    },
    {
      'title': 'Lottery',
      'subtitle': 'Instant Win',
      'emoji': '🎰',
      'color1': Color(0xFF4A148C),
      'color2': Color(0xFF7B1FA2),
      'badge': 'HOT',
      'badgeColor': Color(0xFFFF6F00),
      'route': AppRoutes.lottery,
      'tab': 'Lottery',
      'players': '3.1L playing',
    },
    {
      'title': 'Casino',
      'subtitle': 'Live Dealers',
      'emoji': '🎲',
      'color1': Color(0xFF1A237E),
      'color2': Color(0xFF283593),
      'badge': 'LIVE',
      'badgeColor': Color(0xFFE53935),
      'route': AppRoutes.casino,
      'tab': 'Casino',
      'players': '98K playing',
    },
    {
      'title': 'Football',
      'subtitle': 'Fantasy Football',
      'emoji': '⚽',
      'color1': Color(0xFF004D40),
      'color2': Color(0xFF00796B),
      'badge': null,
      'badgeColor': null,
      'route': AppRoutes.home,
      'tab': 'Sports',
      'players': '76K playing',
    },
    {
      'title': 'Teen Patti',
      'subtitle': '3 Card Poker',
      'emoji': '🎴',
      'color1': Color(0xFF880E4F),
      'color2': Color(0xFFC2185B),
      'badge': 'NEW',
      'badgeColor': Color(0xFF1565C0),
      'route': AppRoutes.home,
      'tab': 'Cards',
      'players': '1.2L playing',
    },
    {
      'title': 'Ludo',
      'subtitle': 'Board Game',
      'emoji': '🎯',
      'color1': Color(0xFFE65100),
      'color2': Color(0xFFF57C00),
      'badge': null,
      'badgeColor': null,
      'route': AppRoutes.home,
      'tab': 'Casino',
      'players': '45K playing',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredGames {
    if (_tabController.index == 0) return _allGames;
    return _allGames
        .where((g) => g['tab'] == _tabs[_tabController.index])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Games',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.backgroundCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicator: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.textHint,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              dividerColor: Colors.transparent,
              padding: const EdgeInsets.all(4),
              tabs: _tabs.map((t) => Tab(text: t)).toList(),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.82,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _filteredGames.length,
          itemBuilder: (context, index) =>
              _buildGameCard(_filteredGames[index]),
        ),
      ),
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game) {
    return GestureDetector(
      onTap: () => context.push(game['route'] as String),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [game['color1'] as Color, game['color2'] as Color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: (game['color1'] as Color).withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Badge
            if (game['badge'] != null)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: game['badgeColor'] as Color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    game['badge'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game['emoji'] as String,
                    style: const TextStyle(fontSize: 44),
                  ),
                  const Spacer(),
                  Text(
                    game['title'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    game['subtitle'] as String,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.people_rounded,
                          color: Colors.white70, size: 13),
                      const SizedBox(width: 4),
                      Text(
                        game['players'] as String,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}