
class MobileLogin {
  int id;
  String companyId;
  String qrCode;
  int timeStamp;
  bool loginStatus;
  String? name;

  MobileLogin({
    required this.id,
    required this.companyId,
    required this.qrCode,
    required this.timeStamp,
    required this.loginStatus,
    this.name
  });

  // Tạo đối tượng từ JSON
  factory MobileLogin.fromJson(Map<String, dynamic> json) {
    return MobileLogin(
      id: json['id'],
      companyId: json['companyId'],
      qrCode: json['qrCode'],
      timeStamp: json['timeStamp'],
      loginStatus: json['loginStatus'],
      name: json['name']
    );
  }

  // Chuyển đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyId': companyId,
      'qrCode': qrCode,
      'timeStamp': timeStamp,
      'loginStatus': loginStatus,
      'name': name
    };
  }
}
