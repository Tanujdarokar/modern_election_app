import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  // Helper to simulate launching URLs/Email
  Future<void> _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open: $url. Feature coming soon!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Help & Support', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(colorScheme),
            const SizedBox(height: 30),
            const Text(
              'FREQUENTLY ASKED QUESTIONS',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2),
            ),
            const SizedBox(height: 12),
            _buildFAQList(),
            const SizedBox(height: 30),
            const Text(
              'CONTACT US',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2),
            ),
            const SizedBox(height: 12),
            _buildContactOptions(context, colorScheme),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.primary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        children: [
          Icon(Icons.support_agent_rounded, size: 60, color: Colors.white),
          SizedBox(height: 16),
          Text(
            'How can we help you?',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Our team is here to assist you with any election-related queries.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQList() {
    final faqs = [
      {
        'q': 'How do I check my registration status?',
        'a': 'You can check your status through the National Voter Service Portal (NVSP) or by texting your Voter ID to the designated helpline.'
      },
      {
        'q': 'What documents are valid for ID?',
        'a': 'Voter ID card is primary. Others include Aadhaar Card, PAN Card, Driving License, or Passport.'
      },
      {
        'q': 'Can I vote if I moved recently?',
        'a': 'You must update your address in the electoral roll. Use Form 8 for shifting to a new residence.'
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10)],
      ),
      child: Column(
        children: faqs.map((faq) {
          return ExpansionTile(
            title: Text(faq['q']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(faq['a']!, style: TextStyle(color: Colors.grey[600], fontSize: 13, height: 1.5)),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContactOptions(BuildContext context, ColorScheme colorScheme) {
    return Column(
      children: [
        _buildContactTile(
          icon: Icons.email_outlined,
          title: 'Email Support',
          subtitle: 'support@electionassistant.gov',
          onTap: () => _launchURL(context, 'mailto:support@electionassistant.gov'),
        ),
        const SizedBox(height: 12),
        _buildContactTile(
          icon: Icons.phone_in_talk_outlined,
          title: 'Toll-Free Helpline',
          subtitle: '1950 (Election Commission)',
          onTap: () => _launchURL(context, 'tel:1950'),
        ),
        const SizedBox(height: 12),
        _buildContactTile(
          icon: Icons.public_rounded,
          title: 'Official Website',
          subtitle: 'www.eci.gov.in',
          onTap: () => _launchURL(context, 'https://www.eci.gov.in'),
        ),
      ],
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.indigo, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
