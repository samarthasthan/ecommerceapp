class UserModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  int? phone;
  String? accessToken;
  String? tokenType;

  UserModel(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.accessToken,
      this.tokenType});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}
