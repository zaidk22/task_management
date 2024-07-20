
class RegisterResponse {
  int? id;
  String? token;

  RegisterResponse({this.id, this.token});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["token"] = token;
    return _data;
  }
}