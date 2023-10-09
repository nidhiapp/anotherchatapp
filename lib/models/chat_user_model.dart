class ChatUserModel {
  ChatUserModel({
    required this.image,
    required this.name,
    required this.about,
    required this.createdAt,
    required this.id,
    required this.isOnline,
    required this.pushToken,
    required this.email,
    required this.lastActive,
  });
   ChatUserModel.withDefaults({
    this.image = '',
    this.id = '',
    this.email = '',
  });
  
  late  String image;
  late  String name= " ";
  late  String about=" ";
  late  String createdAt;
  late  String id;
  late  bool isOnline;
  late  String pushToken;
  late  String email= " ";
  late  String lastActive;

  ChatUserModel.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? ' ';
    name = json['name'] ?? ' ';
    about = json['about'] ?? ' ';
    createdAt = json['created_at'] ?? '  ';
    id = json['id'] ?? ' ';
    isOnline = json['is_online'] is bool ? json['is_online'] : json['is_online'] == 'true';
    pushToken = json['push_token'] ?? ' ';
    email = json['email'] ?? '';
    lastActive = json['lastActive'] ?? '';
    
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['about'] = about;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['is_online'] = isOnline;
    data['push_token'] = pushToken;
    data['email'] = email;
    data['lastActive'] = lastActive;
    return data;
  }
}
