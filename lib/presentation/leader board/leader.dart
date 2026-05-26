import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _leaders = [
    {'rank': 1, 'name': 'Rahul Kumar', 'points': 48500, 'wins': 124, 'avatar': '👑'},
    {'rank': 2, 'name': 'Priya Singh', 'points': 43200, 'wins': 108, 'avatar': '🥈'},
    {'rank': 3, 'name': 'Arjun Mehta', 'points': 39800, 'wins': 97, 'avatar': '🥉'},
    {'rank': 4, 'name': 'Sneha Patel', 'points': 35100, 'wins': 89, 'avatar': '🎯'},
    {'rank': 5, 'name': 'Vijay Sharma', 'points': 31400, 'wins': 76, 'avatar': '⚡'},
    {'rank': 6, 'name': 'Ananya Roy', 'points': 28900, 'wins': 71, 'avatar': '🔥'},
    {'rank': 7, 'name': 'Karan Gupta', 'points': 25600, 'wins': 64, 'avatar': '💎'},
    {'rank': 8, 'name': 'Meena Joshi', 'points': 22300, 'wins': 58, 'avatar': '🌟'},
    {'rank': 9, 'name': 'You', 'points': 19800, 'wins': 51, 'avatar': '😎', 'isMe': true},
    {'rank': 10, 'name': 'Deepak Nair', 'points': 17500, 'wins': 44, 'avatar': '🎮'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildTopThree()),
          SliverToBoxAdapter(child: _buildTabBar()),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildList(_leaders),
            _buildList(_leaders.where((l) => l['rank'] <= 5).toList()),
            _buildList([_leaders[8]]),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
      child: const Text(
        'Leaderboard',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTopThree() {
    final top3 = _leaders.take(3).toList();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2A2A35), Color(0xFF1A1A25)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildPodium(top3[1], 2, 90),
          _buildPodium(top3[0], 1, 110),
          _buildPodium(top3[2], 3, 70),
        ],
      ),
    );
  }

  Widget _buildPodium(Map<String, dynamic> player, int rank, double height) {
    final colors = {
      1: [const Color(0xFFFFD700), const Color(0xFFFFA000)],
      2: [const Color(0xFFB0BEC5), const Color(0xFF78909C)],
      3: [const Color(0xFFBF8970), const Color(0xFF8D6E63)],
    };
    final c = colors[rank]!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(player['avatar'] as String,
            style: const TextStyle(fontSize: 32)),
        const SizedBox(height: 4),
        Text(
          (player['name'] as String).split(' ').first,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '${(player['points'] as int) ~/ 1000}K pts',
          style: TextStyle(color: c[0], fontSize: 11, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Container(
          width: 70,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: c,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          alignment: Alignment.center,
          child: Text(
            '#$rank',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textHint,
        labelStyle:
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        dividerColor: Colors.transparent,
        padding: const EdgeInsets.all(4),
        tabs: const [
          Tab(text: 'Global'),
          Tab(text: 'Weekly'),
          Tab(text: 'My Rank'),
        ],
      ),
    );
  }

  Widget _buildList(List<Map<String, dynamic>> list) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      itemCount: list.length,
      itemBuilder: (context, index) => _buildLeaderRow(list[index]),
    );
  }

  Widget _buildLeaderRow(Map<String, dynamic> player) {
    final isMe = player['isMe'] == true;
    final rank = player['rank'] as int;

    Color rankColor = AppColors.textHint;
    if (rank == 1) rankColor = const Color(0xFFFFD700);
    if (rank == 2) rankColor = const Color(0xFFB0BEC5);
    if (rank == 3) rankColor = const Color(0xFFBF8970);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isMe
            ? AppColors.primary.withOpacity(0.12)
            : AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isMe ? AppColors.primary : AppColors.border,
          width: isMe ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              '#$rank',
              style: TextStyle(
                color: rankColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.backgroundInput,
              shape: BoxShape.circle,
              border: Border.all(
                  color: isMe ? AppColors.primary : AppColors.border),
            ),
            alignment: Alignment.center,
            child: Text(player['avatar'] as String,
                style: const TextStyle(fontSize: 20)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      player['name'] as String,
                      style: TextStyle(
                        color: isMe ? AppColors.primary : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'YOU',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 9,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  '${player['wins']} wins',
                  style: const TextStyle(
                      color: AppColors.textHint, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${(player['points'] as int).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} pts',
                style: TextStyle(
                  color: isMe ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}