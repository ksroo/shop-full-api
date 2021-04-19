class ChangeFavoritesModels {
  bool status;
  String message;

  ChangeFavoritesModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
