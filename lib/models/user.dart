import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String ten;
  final String anh;
  final String email;
  final Map<String, dynamic> data;

  const User(
      {required this.id,
      required this.ten,
      required this.anh,
      required this.email,
      required this.data});

  @override
  String toString() => 'User';

  @override
  List<Object> get props => [
        id,
        ten,
        anh,
        email,
        data,
      ];

  factory User.fromJson(Map<String, dynamic> dictionary) {
    return User(
        id: dictionary['uuid'] ?? '',
        ten: dictionary['username'] ?? '',
        anh: dictionary['avatar'] ?? '',
        email: dictionary['email'] ?? '',
        data: dictionary['data'] ?? {});
  }

  static get empty => const User(anh: '', id: '', data: {}, email: '', ten: '');
}
