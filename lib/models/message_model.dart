class MessageModel {
  MessageModel({
    required this.msg,
    required this.read,
    required this.sendTo,
    required this.type,
    required this.sent,
    required this.sendBy,
  });
  late final String msg;
  late final String read;
  late final String sendTo;
  late final Type type;
  late final String sent;
  late final String sendBy;
  
  MessageModel.fromJson(Map<String, dynamic> json){
    msg = json['msg'].toString();
    read = json['read'].toString();
    sendTo = json['sendTo'].toString();
    type = json['type'].toString()==Type.image.name ? Type.image: Type.text;
    sent = json['sent'].toString();
    sendBy = json['sendBy'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['msg'] = msg;
    data['read'] = read;
    data['sendTo'] = sendTo;
    data['type'] = type.name;
    data['sent'] = sent;
    data['sendBy'] = sendBy;
    return data;
  }
 

  
}
 enum Type{text,image}