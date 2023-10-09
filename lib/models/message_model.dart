class MessageModel {
  MessageModel({
   // required this.id,
    required this.msg,
    required this.read,
    required this.sendTo,
    required this.type,
    required this.sent,
    required this.sendBy,
    required this.isPinned,
    required this.isStarred,
    required this.isDeleted,
    required this.forwardedFrom,
    required this.replyToMessageId,
   required this. isSelected,
  });

 // late final String id; // Unique message ID
  late final String msg;
  late final String read;
  late final String sendTo;
  late final Type type;
  late final String sent;
  late final String sendBy;
  late final bool isPinned;
  late final bool isStarred;
  late final bool isDeleted;
  late final String forwardedFrom; // ID of the user who forwarded the message (empty if not forwarded)
  late final String replyToMessageId;
 late  final bool isSelected; // ID of the message being replied to (empty if not a reply)

  MessageModel.fromJson(Map<String, dynamic> json) {
  // id = json['id'].toString();
    msg = json['msg'].toString();
    read = json['read'].toString();
    sendTo = json['sendTo'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    sent = json['sent'].toString();
    sendBy = json['sendBy'].toString();
    isPinned = json['isPinned'] as bool? ?? false; 
    isStarred = json['isStarred'] as bool? ?? false;
    isDeleted = json['isDeleted'] as bool? ?? false;
    isSelected = json['isSelected'] as bool? ?? false;
    forwardedFrom = json['forwardedFrom'].toString();
    replyToMessageId = json['replyToMessageId'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
  //  data['id'] = id;
    data['msg'] = msg;
    data['read'] = read;
    data['sendTo'] = sendTo;
    data['type'] = type.name;
    data['sent'] = sent;
    data['sendBy'] = sendBy;
    data['isPinned'] = isPinned;
    data['isStarred'] = isStarred;
    data['isDeleted'] = isDeleted;
     data['isSelected'] = isSelected;
    data['forwardedFrom'] = forwardedFrom;
    data['replyToMessageId'] = replyToMessageId;
    return data;
  }
}

enum Type { text, image }
