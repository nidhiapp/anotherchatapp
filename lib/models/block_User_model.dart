class User {
  final String uid;
  final String username;
  // Add other user details as needed

  User({required this.uid, required this.username});
}

class BlockedUser {
  final String blockedUserId;
  
  BlockedUser({required this.blockedUserId});
}
