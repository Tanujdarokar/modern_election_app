import 'package:flutter/material.dart';

class DocumentVaultScreen extends StatefulWidget {
  const DocumentVaultScreen({super.key});

  @override
  State<DocumentVaultScreen> createState() => _DocumentVaultScreenState();
}

class _DocumentVaultScreenState extends State<DocumentVaultScreen> {
  final List<Map<String, String>> _documents = [
    {'type': 'Voter ID Card', 'status': 'Not Uploaded', 'icon': 'fingerprint'},
    {'type': 'Aadhaar Card', 'status': 'Not Uploaded', 'icon': 'badge'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Digital Vault', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigo[900],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.security, color: Colors.white, size: 40),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Secure Storage', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                        Text('Your documents are encrypted and stored locally.', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('MY DOCUMENTS', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2, fontSize: 12)),
            const SizedBox(height: 16),
            ..._documents.map((doc) => _buildDocTile(doc)),
            const Spacer(),
            Center(
              child: Text(
                'Only you can access these files',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDocTile(Map<String, String> doc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(doc['icon'] == 'fingerprint' ? Icons.fingerprint : Icons.badge, color: Colors.indigo),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doc['type']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(doc['status']!, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: const Text('Upload'),
          ),
        ],
      ),
    );
  }
}
