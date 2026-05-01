import 'package:flutter/material.dart';
import '../models/election_model.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TimelineData> timeline = [
      TimelineData(date: 'Mar 16', event: 'Election Schedule Announcement', status: 'Completed'),
      TimelineData(date: 'Mar 20', event: 'Issue of Gazetted Notification', status: 'Completed'),
      TimelineData(date: 'Mar 27', event: 'Last Date for Nominations', status: 'Completed'),
      TimelineData(date: 'Apr 19', event: 'Phase 1 Voting', status: 'Completed'),
      TimelineData(date: 'Apr 26', event: 'Phase 2 Voting', status: 'Completed'),
      TimelineData(date: 'May 07', event: 'Phase 3 Voting', status: 'Completed'),
      TimelineData(date: 'May 13', event: 'Phase 4 Voting', status: 'Completed'),
      TimelineData(date: 'May 20', event: 'Phase 5 Voting', status: 'Active'),
      TimelineData(date: 'May 25', event: 'Phase 6 Voting', status: 'Upcoming'),
      TimelineData(date: 'Jun 01', event: 'Phase 7 Voting', status: 'Upcoming'),
      TimelineData(date: 'Jun 04', event: 'Counting & Result Day', status: 'Final'),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Important Timelines'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: timeline.length,
        itemBuilder: (context, index) {
          final data = timeline[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: _getStatusColor(data.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        data.date.split(' ')[0],
                        style: TextStyle(
                          color: _getStatusColor(data.status),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        data.date.split(' ')[1],
                        style: TextStyle(
                          color: _getStatusColor(data.status),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.event,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(data.status).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          data.status,
                          style: TextStyle(
                            fontSize: 11,
                            color: _getStatusColor(data.status),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.grey;
      case 'active':
        return Colors.green;
      case 'upcoming':
        return Colors.blue;
      case 'final':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
