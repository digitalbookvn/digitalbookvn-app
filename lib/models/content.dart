import 'package:equatable/equatable.dart';

class Content extends Equatable {
  var id;
  var book;
  var lang;
  var subtitle = [] ;
  var audio = [];
  var image = [];

  Content({
    this.id = '',
    this.book = '',
    this.lang = '',
    this.subtitle = const [],
    this.audio = const [],
    this.image = const [],
  });

  @override
  String toString() => 'Content';

  @override
  List<Object> get props => [
    id,
    book,
    lang,
    subtitle,
    audio,
    image,
  ];

  factory Content.fromJson(Map<String, dynamic> dictionary) {
    return Content(
        id: dictionary['id'] ?? '',
        book: dictionary['book'] ?? '',
        lang: dictionary['lang'] ?? '',
        subtitle: dictionary['subtitle'] ?? [],
        audio: dictionary['audio'] ?? [],
        image: dictionary['image'] ?? []);
  }

  static get empty => Content();
}
