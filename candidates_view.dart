import 'package:flutter/material.dart';

class CandidatesScreen extends StatelessWidget {
  const CandidatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> candidates = [
      {
        'name': 'Aditya Sharma',
        'party': 'Jan Shakti Party',
        'education': 'M.A. Political Science',
        'experience': '15 Years in Public Service',
        'manifesto': 'Focus on digital infrastructure and youth employment.',
      },
      {
        'name': 'Meera Deshmukh',
        'party': 'National Progress Front',
        'education': 'LL.B. Law',
        'experience': 'Senior Advocate, High Court',
        'manifesto': 'Ensuring women safety and sustainable urban planning.',
      },
      {
        'name': 'Vikram Rathore',
        'party': 'People\'s Union',
        'education': 'B.Tech Civil Engineering',
        'experience': 'Ex-Infrastructure Consultant',
        'manifesto': 'Improving rural connectivity and irrigation systems.',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Know Your Candidates', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          final c = candidates[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.indigo[100],
                    child: Text(c['name']![0], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo)),
                  ),
                  title: Text(c['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Text(c['party']!, style: TextStyle(color: Colors.indigo[700], fontWeight: FontWeight.w600)),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(Icons.school_outlined, 'Education', c['education']!),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.work_outline, 'Experience', c['experience']!),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.description_outlined, 'Manifesto', c['manifesto']!),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.bold)),
              Text(value, style: const TextStyle(fontSize: 14, color: Colors.black87)),
            ],
          ),
        ),
      ],
    );
  }
}
