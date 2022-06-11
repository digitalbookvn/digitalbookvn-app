import 'package:equatable/equatable.dart';

class Lang extends Equatable {
  var id;
  var scriptCode;
  var languageCode;
  var name;
  final String font;
  final String slug;

  Lang(
      {this.id = '',
      this.scriptCode = '',
      this.languageCode = '',
      this.name = '',
      this.font = 'Nunito',
      this.slug = '',
      });

  @override
  String toString() => 'Lang';

  @override
  //
  List<Object> get props => [
        id,
        scriptCode,
        languageCode,
        name,
      ];

  factory Lang.fromJson(Map<String, dynamic> dictionary) {
    return Lang(
      id: dictionary['id'] ?? '',
      scriptCode: dictionary['scriptCode'] ?? '',
      languageCode: dictionary['languageCode'] ?? '',
      name: dictionary['name'] ?? '',
    );
  }

  static get empty => Lang();
}
