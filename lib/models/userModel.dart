class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;

  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String , dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'isEmailVerified': isEmailVerified,
    };
  }
}
