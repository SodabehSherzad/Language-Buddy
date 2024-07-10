class Chat {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;

  Chat({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}