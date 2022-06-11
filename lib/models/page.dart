import 'package:equatable/equatable.dart';

class BookPage extends Equatable {
  var image;
  var content;

  BookPage({
    this.image = '',
    this.content = const {},
  });

  @override
  String toString() => 'BookPage';

  @override
  // 
  List<Object> get props => [
    image,content
  ];

  factory BookPage.fromJson(Map<String, dynamic> dictionary) {
    return BookPage(

        image: dictionary['image'] ?? '',
        content: dictionary['content'] ?? {},
    );
  }

  static get empty => BookPage();
}
