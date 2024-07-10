class ConversationModel {
  // int id;
  String sender_de;
  String sender_en;
  String sender_fa;
  String message_de;
  String message_en;
  String message_fa;

  // Constructor using shorthand syntax for assigning constructor parameters to instance variables
  ConversationModel(this.sender_de, this.sender_en, this.sender_fa, this.message_de, this.message_en, this.message_fa);

  // Static method to map data to ConversationModel objects
  static List<ConversationModel> dataMappingConversation(List<ConversationModel> data) {
    return data.map((data) => ConversationModel(
      data.sender_de,
      data.sender_en,
      data.sender_fa,
      data.message_de,
      data.message_en,
      data.message_fa,
    )).toList();
  }
}
