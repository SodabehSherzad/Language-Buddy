import '../classes/conversation_model.dart';
import '../classes/vocabulary_model.dart';
import '../classes/topics_model.dart';

/*
class VocabularyMethods {
  List<VocabularyModel> _vocabulary_data;

  VocabularyMethods(List<dynamic> data)
      : _vocabulary_data = data
      .map((d) => VocabularyModel(
    d['vocabulary_id'],
    d['name_de'],
    d['name_fa'],
    d['name_en'],
    d['correct_answer_index'],
  ))
      .toList();

  List<VocabularyModel> getVocabularyData() {
    return _vocabulary_data;
  }
}
 */
class VocabularyMethods {
  final List<Map<String, dynamic>>? data;

  VocabularyMethods(this.data);

  List<VocabularyModel> getVocabularyData() {
    if (data == null || data!.isEmpty) {
      return [];
    }
    return data!.map((item) {
      return VocabularyModel(
        item['id'] ?? 0,
        item['name_de'] ?? '',
        item['name_fa'] ?? '',
        item['name_en'] ?? '',
        item['correct_answer_index'] ?? 0,
      );
    }).toList();
  }
}


class ConversationMethods {
  List<ConversationModel> _conversation_data;

  ConversationMethods(List<Map<String, dynamic>> data)
      : _conversation_data = data
      .map((d) => ConversationModel(
    d['sender_de'],
    d['sender_en'],
    d['sender_fa'],
    d['message_de'],
    d['message_en'],
    d['message_fa'],
  ))
      .toList();

  List<ConversationModel> getConversationData() {
    return _conversation_data;
  }
}

class TopicsMethods {
  List<TopicsModel> _topics_data;

  TopicsMethods(List<Map<String, dynamic>> data)
      : _topics_data = data
      .map((d) => TopicsModel(
    d['id'],
    d['name_de'],
    d['name_fa'],
    d['name_en'],
  ))
      .toList();

  List<TopicsModel> getTopicsData() {
    return _topics_data;
  }
}