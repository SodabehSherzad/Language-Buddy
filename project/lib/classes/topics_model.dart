class TopicsModel {
  int id;
  String name_fa;
  String name_en;
  String name_de;

  TopicsModel(this.id, this.name_de, this.name_fa, this.name_en);

  factory TopicsModel.fromMap(Map<String, dynamic> map) {
    return TopicsModel(
      map['id'],
      map['name_de'],
      map['name_fa'],
      map['name_en'],
    );
  }

  static List<TopicsModel> dataMappingTopics(List<Map<String, dynamic>> data) {
    return data.map((map) => TopicsModel.fromMap(map)).toList();
  }
}
