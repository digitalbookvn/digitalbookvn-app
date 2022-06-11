import 'package:equatable/equatable.dart';

class Model extends Equatable {
  var id;
  var ten;
  var anh;
  var object;

  Model({
    this.id = '',
    this.ten = '',
    this.anh = '',
    this.object = '',
  });

  @override
  String toString() => 'Model';

  @override
  List<Object> get props => [
        id,
        ten,
        anh,
        object,
      ];

  factory Model.fromJson(Map<String, dynamic> dictionary) {
    return Model(
        id: dictionary['id'] ?? '',
        ten: dictionary['ten'] ?? '',
        anh: dictionary['anh'] ?? '',
        object: dictionary['object'] ?? '');
  }

  static get empty => Model();
}
