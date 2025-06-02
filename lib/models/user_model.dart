class UserModel {
  final int? id;
  final String username;
  final String password;
  final double dailyGoal;
  final double consumedWater;

  UserModel({
    this.id,
    required this.username,
    required this.password,
    required this.dailyGoal,
    this.consumedWater = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'dailyGoal': dailyGoal,
      'consumedWater': consumedWater,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      dailyGoal: map['dailyGoal'],
      consumedWater: map['consumedWater'] ?? 0.0,
    );
  }
}
