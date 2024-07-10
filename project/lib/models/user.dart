class UserProfile {
  final String userId;
  String name;
  String address;
  String description;
  final List<String> languages;
  final List<String> friends;
  final String imageUrl;
  String role;

  UserProfile({
    required this.userId,
    required this.name,
    required this.address,
    required this.description,
    required this.languages,
    required this.friends,
    required this.imageUrl,
    required this.role,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'],
      name: json['name'],
      address: json['address'],
      description: json['description'],
      languages: List<String>.from(json['languages']),
      friends: List<String>.from(json['friends']),
      imageUrl: json['imageUrl'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'address': address,
      'description': description,
      'languages': languages,
      'friends': friends,
      'imageUrl': imageUrl,
      'role': role
    };
  }

  void updateProfile({
    String ?newName,
    String ?newAddress,
    String ?newDescription,
    String ?newRole,
  }) {
    if (newName != null) name = newName;
    if (newAddress != null) address = newAddress;
    if (newDescription != null) description = newDescription;
    if (newRole != null) role = newRole;
  }
}
