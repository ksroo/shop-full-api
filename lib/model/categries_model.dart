class CategriesModel {
  bool status;

  CategriesDataModel data;

  CategriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategriesDataModel.fronJson(json['data']);
  }
}

class CategriesDataModel {
  int currentPage;
  List<DataModel> data = [];

  CategriesDataModel.fronJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((elemnet) {
      data.add(DataModel.fromJson(elemnet));
    });
  }
}

class DataModel {
  int id;
  String name;
  String image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
