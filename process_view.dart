import 'package:flutter/material.dart';
import '../models/election_model.dart';

class ElectionProcessScreen extends StatelessWidget {
  const ElectionProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final List<ProcessStepData> steps = [
      ProcessStepData(
        step: '01',
        title: 'Voter Registration',
        description: 'Verify your eligibility and complete your registration. This ensures your legal right to participate in the democratic process.',
        icon: Icons.person_add_rounded,
      ),
      ProcessStepData(
        step: '02',
        title: 'Education & Research',
        description: 'Study the manifestos and track records of candidates in your area. Use our AI assistant to clear any doubts about polling rules.',
        icon: Icons.auto_stories_rounded,
      ),
      ProcessStepData(
        step: '03',
        title: 'Polling Day',
        description: 'Locate your booth, carry your ID, and cast your vote. Follow the guidelines provided at the station for a smooth experience.',
        icon: Icons.how_to_vote_rounded,
      ),
      ProcessStepData(
        step: '04',
        title: 'Post-Election',
        description: 'Track the counting process and wait for the official declaration of results. Participate in the civil discourse responsibly.',
        icon: Icons.analytics_rounded,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('The Election Journey', style: TextStyle(fontWeight: FontWeight.w900)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: colorScheme.primary),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Follow these 4 critical steps to ensure your vote counts.',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: steps.length,
              itemBuilder: (context, index) {
                final data = steps[index];
                final isLast = index == steps.length - 1;
                
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.primary.withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: Center(
                            child: Icon(data.icon, color: Colors.white, size: 24),
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [colorScheme.primary, colorScheme.primary.withValues(alpha: 0.1)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'STEP ${data.step}',
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data.title,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            data.description,
                            style: TextStyle(color: Colors.grey[600], height: 1.6, fontSize: 14),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
