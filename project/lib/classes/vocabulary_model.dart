import 'topics_model.dart';

class VocabularyModel {
  int vocabulary_id;
  int correct_answer_index;
  String name_de;
  String name_fa;
  String name_en;

  // Constructor using shorthand syntax
  VocabularyModel(
      this.vocabulary_id,
      this.name_de,
      this.name_fa,
      this.name_en,
      this.correct_answer_index,
      );

  // Named constructor with parameters for only names
  VocabularyModel.withNames(
      this.name_de,
      this.name_fa,
      this.name_en,
      ) : vocabulary_id = 0, correct_answer_index = 0;

  // Named constructor to create a VocabularyModel from a TopicsModel instance
  VocabularyModel.fromTopicsModel(TopicsModel topicsModel)
      : vocabulary_id = 0,
        correct_answer_index = 0,
        name_de = topicsModel.name_de,
        name_fa = topicsModel.name_fa,
        name_en = topicsModel.name_en;

  // Factory constructor to create a VocabularyModel from another instance
  factory VocabularyModel.fromVocabularyModel(VocabularyModel model) {
    return VocabularyModel(
      model.vocabulary_id,
      model.name_de,
      model.name_fa,
      model.name_en,
      model.correct_answer_index,
    );
  }

  // Static method to map data to VocabularyModel objects
  static List<VocabularyModel> dataMapping(List<VocabularyModel> data) {
    return data.map((model) => VocabularyModel.fromVocabularyModel(model)).toList();
  }
}
