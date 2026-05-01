import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/election_model.dart';
import 'package:flutter/material.dart';

class ChatController {
  final List<ChatMessage> messages = [];
  static const String _keyChatHistory = 'chat_history';

  ChatController() {
    _loadChatHistory();
  }

  Future<void> _loadChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? chatData = prefs.getString(_keyChatHistory);
    if (chatData != null) {
      final List<dynamic> decoded = jsonDecode(chatData);
      messages.clear();
      messages.addAll(decoded.map((m) => ChatMessage.fromJson(m)).toList());
    } else {
      messages.add(ChatMessage(
          role: 'assistant',
          content:
              'Hello! I am your Election Assistant. How can I help you today? You can ask about registration, voting steps, or important dates.'));
    }
  }

  Future<void> _saveChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(messages.map((m) => m.toJson()).toList());
    await prefs.setString(_keyChatHistory, encoded);
  }

  void sendMessage(String text, VoidCallback onUpdate) {
    if (text.trim().isEmpty) return;
    
    messages.add(ChatMessage(role: 'user', content: text));
    _saveChatHistory();
    onUpdate();
    _respondAsAI(text, onUpdate);
  }

  void clearChat(VoidCallback onUpdate) async {
    messages.clear();
    messages.add(ChatMessage(
        role: 'assistant',
        content:
            'Chat cleared. How can I help you today?'));
    await _saveChatHistory();
    onUpdate();
  }

  void _respondAsAI(String query, VoidCallback onUpdate) {
    // Logic: Simulated Contextual Response
    // Demonstrates decision making based on keywords and user intent
    String response =
        "I'm here to help you navigate the election process. Could you please specify if you're asking about 'registration', 'polling locations', or 'important dates'?";
    
    String lowerQuery = query.toLowerCase();

    if (lowerQuery.contains('registration') || lowerQuery.contains('apply')) {
      response = "To register, you must be 18+ and a citizen. Our 'Process' guide in the home screen provides a step-by-step checklist of the documents required.";
    } else if (lowerQuery.contains('vote') || lowerQuery.contains('how')) {
      response = "On Election Day, bring your Voter ID to your assigned polling booth. The voting hours are typically 7 AM to 6 PM. Need to find your booth?";
    } else if (lowerQuery.contains('candidate') || lowerQuery.contains('who')) {
      response = "You can view all contesting candidates and their manifestos in the 'Know Your Candidate' section on your dashboard.";
    } else if (lowerQuery.contains('vault') || lowerQuery.contains('safe')) {
      response = "Our Digital Vault uses local encryption. Your Voter ID and Aadhaar data never leaves your device, ensuring maximum privacy.";
    } else if (lowerQuery.contains('date') || lowerQuery.contains('when')) {
      response = "The next major event is the Phase 5 voting on May 20th. You can track all phases in the 'Election Dates' timeline.";
    }

    // Simulate thinking time for a better user experience
    Future.delayed(const Duration(milliseconds: 800), () async {
      messages.add(ChatMessage(role: 'assistant', content: response));
      await _saveChatHistory();
      onUpdate();
    });
  }
}
