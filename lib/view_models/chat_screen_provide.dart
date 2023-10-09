import 'package:flutter/cupertino.dart';
import 'package:new_chatapp_chitchat/models/message_model.dart';

class ChatScreenModelProvider with ChangeNotifier {
  List<MessageModel> _selectedMessages = [];
  List<MessageModel> get selectedMessages => _selectedMessages;

  int containsMessage(MessageModel message) {
    for (int i = 0; i < _selectedMessages.length; i++) {
      if (message.sent == _selectedMessages[i].sent) {
        return i;
      }
    }

    return -1;
  }

  toggleMessage(MessageModel message) {
    int index = containsMessage(message);
    if (index == -1){
      _selectedMessages.add(message);
      }
    else {
      _selectedMessages.removeAt(index);
    }
    notifyListeners();
  }
}
