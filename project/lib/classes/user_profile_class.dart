class UserProfile {
  final String userId;
  String name;
  String address;
  String description;
  final List<String> languages;
  final List<String> friends;
  final String imageUrl;
  final String role;

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

  void updateProfile({
    String ?newName,
    String ?newAddress,
    String ?newDescription,
  }) {
    if (newName != null) name = newName;
    if (newAddress != null) address = newAddress;
    if (newDescription != null) description = newDescription;
  }
}
