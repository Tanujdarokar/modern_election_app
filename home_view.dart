import 'package:flutter/material.dart';
import 'settings_view.dart';
import 'widgets/menu_card.dart';
import 'process_view.dart';
import 'chat_view.dart';
import 'timeline_view.dart';
import 'candidates_view.dart';
import 'vault_view.dart';

class ElectionHomeScreen extends StatefulWidget {
  const ElectionHomeScreen({super.key});

  @override
  State<ElectionHomeScreen> createState() => _ElectionHomeScreenState();
}

class _ElectionHomeScreenState extends State<ElectionHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeDashboard(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 800;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      appBar: isWeb ? _buildWebNavBar(colorScheme, isDark, screenWidth) : null,
      body: _pages[_selectedIndex],
      bottomNavigationBar: isWeb 
        ? null 
        : Container(
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 30),
            height: 70,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light 
                  ? Colors.white.withValues(alpha: 0.9) 
                  : Colors.grey[900]!.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.grid_view_rounded, 'Home'),
                  _buildNavItem(1, Icons.settings_rounded, 'Settings'),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[400],
              size: 26,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildWebNavBar(ColorScheme colorScheme, bool isDark, double screenWidth) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: screenWidth > 1200 ? 60 : 20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0F172A) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.how_to_vote_rounded, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Election Guide AI',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
            const Spacer(),
            _buildWebNavButton(0, 'Dashboard', Icons.grid_view_rounded),
            const SizedBox(width: 20),
            _buildWebNavButton(1, 'Settings', Icons.settings_rounded),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Help Center', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebNavButton(int index, String label, IconData icon) {
    final isSelected = _selectedIndex == index;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? colorScheme.primary : (isDark ? Colors.white70 : Colors.grey[600]),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? colorScheme.primary : (isDark ? Colors.white70 : Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWeb = constraints.maxWidth > 900;
        final horizontalPadding = isWeb ? constraints.maxWidth * 0.08 : 20.0;

        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1600),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildSliverAppBar(colorScheme, isWeb),
                SliverToBoxAdapter(
                  child: FadeTransition(
                    opacity: _entranceController,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.05),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: _entranceController,
                        curve: Curves.easeOutCubic,
                      )),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: isWeb ? 60.0 : 20.0,
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.02, 0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: isWeb 
                            ? KeyedSubtree(
                                key: const ValueKey('web_layout'),
                                child: _buildWebLayout(context, colorScheme, isDark),
                              )
                            : KeyedSubtree(
                                key: const ValueKey('mobile_layout'),
                                child: _buildMobileLayout(context, colorScheme, isDark),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, ColorScheme colorScheme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCountdownCard(colorScheme, false),
        const SizedBox(height: 30),
        _buildSectionHeader('Key Categories', isDark),
        const SizedBox(height: 15),
        _buildMenuGrid(context, colorScheme, false),
        const SizedBox(height: 30),
        _buildSectionHeader('Election Tips', isDark),
        const SizedBox(height: 15),
        _buildTipsSection(isDark, colorScheme, false),
        const SizedBox(height: 30),
        _buildAIPromptCard(context, false),
        const SizedBox(height: 120),
      ],
    );
  }

  Widget _buildWebLayout(BuildContext context, ColorScheme colorScheme, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Content Column
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Quick Actions', isDark),
              const SizedBox(height: 25),
              _buildMenuGrid(context, colorScheme, true),
              const SizedBox(height: 50),
              _buildAIPromptCard(context, true),
            ],
          ),
        ),
        const SizedBox(width: 60),
        // Sidebar Content Column
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Time Remaining', isDark),
              const SizedBox(height: 25),
              _buildCountdownCard(colorScheme, true),
              const SizedBox(height: 50),
              _buildSectionHeader('Voter Checklist', isDark),
              const SizedBox(height: 25),
              _buildWebTipsVertical(isDark, colorScheme),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWebTipsVertical(bool isDark, ColorScheme colorScheme) {
    final tips = [
      {'icon': Icons.verified_user, 'text': 'Carry original ID proof'},
      {'icon': Icons.location_on, 'text': 'Check your booth address'},
      {'icon': Icons.access_time, 'text': 'Vote early to avoid queues'},
      {'icon': Icons.info, 'text': 'Learn about candidates'},
    ];

    return Column(
      children: tips.map((tip) => Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colorScheme.primary.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(tip['icon'] as IconData, color: colorScheme.primary, size: 24),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                tip['text'] as String,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: isDark ? Colors.white : Colors.indigo[900],
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildCountdownCard(ColorScheme colorScheme, bool isWeb) {
    final electionDate = DateTime(2024, 5, 20);
    final now = DateTime.now();
    final difference = electionDate.difference(now);
    final days = difference.inDays;

    return Container(
      padding: EdgeInsets.all(isWeb ? 32 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary.withValues(alpha: 0.1),
            colorScheme.primary.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.timer_outlined, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Election Phase 5',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: isWeb ? 20 : 18),
                    ),
                    Text(
                      'National Voting',
                      style: TextStyle(color: Colors.grey[600], fontSize: isWeb ? 15 : 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCountdownItem(days.toString(), 'DAYS', isWeb),
              _buildCountdownItem('14', 'HOURS', isWeb),
              _buildCountdownItem('45', 'MINS', isWeb),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownItem(String value, String label, bool isWeb) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: isWeb ? 40 : 28,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: isWeb ? 12 : 10,
            fontWeight: FontWeight.bold,
            color: Colors.grey[500],
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTipsSection(bool isDark, ColorScheme colorScheme, bool isWeb) {
    final tips = [
      {'icon': Icons.verified_user, 'text': 'Carry original ID proof'},
      {'icon': Icons.location_on, 'text': 'Check your booth address'},
      {'icon': Icons.access_time, 'text': 'Vote early to avoid queues'},
      {'icon': Icons.info, 'text': 'Learn about candidates'},
    ];

    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tips.length,
        itemBuilder: (context, index) {
          final tip = tips[index];
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)
              ],
              border: Border.all(color: colorScheme.primary.withValues(alpha: 0.05)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(tip['icon'] as IconData, color: colorScheme.primary, size: 30),
                const SizedBox(height: 12),
                Text(
                  tip['text'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSliverAppBar(ColorScheme colorScheme, bool isWeb) {
    return SliverAppBar.large(
      expandedHeight: isWeb ? 350 : 240,
      floating: false,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: isWeb ? 80 : 20, bottom: 20),
        title: const Text(
          'Election Guide AI 🗳️',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.5),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorScheme.primary, colorScheme.primary.withValues(alpha: 0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              right: isWeb ? 100 : -50,
              top: isWeb ? 60 : -20,
              child: Opacity(
                opacity: 0.1,
                child: Icon(Icons.account_balance_rounded, size: isWeb ? 450 : 280, color: Colors.white),
              ),
            ),
            Positioned(
              left: isWeb ? 80 : 20,
              top: isWeb ? 120 : 60,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: const Text(
                  'DASHBOARD • 2024 ELECTIONS',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 11, 
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context, ColorScheme colorScheme, bool isWeb) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isWeb ? 2 : 2,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      childAspectRatio: isWeb ? 1.5 : 0.85,
      children: [
        MenuCard(
          title: 'Process',
          subtitle: 'Step-by-step guidance',
          icon: Icons.how_to_vote,
          color: colorScheme.primaryContainer,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ElectionProcessScreen())),
        ),
        MenuCard(
          title: 'Candidates',
          subtitle: 'Profiles & manifestos',
          icon: Icons.people_alt_rounded,
          color: colorScheme.secondaryContainer,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CandidatesScreen())),
        ),
        MenuCard(
          title: 'Election Dates',
          subtitle: 'Full schedule',
          icon: Icons.calendar_month_rounded,
          color: Colors.orange[50]!,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TimelineScreen())),
        ),
        MenuCard(
          title: 'Digital Vault',
          subtitle: 'Manage your documents',
          icon: Icons.auto_stories_rounded,
          color: colorScheme.tertiaryContainer,
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DocumentVaultScreen())),
        ),
      ],
    );
  }

  Widget _buildAIPromptCard(BuildContext context, bool isWeb) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isWeb ? 60 : 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, const Color(0xFF6366F1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Icon(Icons.auto_awesome, size: isWeb ? 220 : 100, color: Colors.white.withValues(alpha: 0.1)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.bolt, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'AI POWERED ASSISTANT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Got Voting Questions?',
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: isWeb ? 48 : 24, 
                  fontWeight: FontWeight.w900, 
                  height: 1.1,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Instant guidance on registration, booths, and rules powered by Google AI.',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: isWeb ? 20 : 14, height: 1.5),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AIChatAssistantScreen())),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: colorScheme.primary,
                  elevation: 0,
                  minimumSize: Size(isWeb ? 200 : 120, 64),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Start AI Assistant', style: TextStyle(fontWeight: FontWeight.w900, fontSize: isWeb ? 18 : 14)),
                    const SizedBox(width: 16),
                    const Icon(Icons.arrow_forward_rounded, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
