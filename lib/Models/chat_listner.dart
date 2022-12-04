import 'package:flutter/material.dart';

class ChatListner with ChangeNotifier {
  bool isOpen = false;
  String openChatThread = "";

  void setIsOpen(bool isOpen) {
    this.isOpen = isOpen;
  }

  void setChatThread(String openChatThread) {
    this.openChatThread = openChatThread;
  }
}
