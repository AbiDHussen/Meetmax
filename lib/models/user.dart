import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final DateTime birthDate;

  @HiveField(5)
  final String gender;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.imageUrl,
    required this.birthDate,
    required this.gender,
  });
}
