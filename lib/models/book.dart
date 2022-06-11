import 'package:equatable/equatable.dart';

class Book extends Equatable {
  int id;
  String ten;
  String anh;
  String thoi_luong;
  String tom_tat;
  String gioi_thieu;

  Book({
    this.id = 0,
    this.ten = '',
    this.anh = '',
    this.thoi_luong = '',
    this.tom_tat = '',
    this.gioi_thieu = '',
  });

  @override
  String toString() => 'Book';

  @override
  // 
  List<Object> get props => [
        id,
        ten,
        anh,
        thoi_luong,
        tom_tat,
        gioi_thieu,
      ];

  factory Book.fromJson(Map<String, dynamic> dictionary) {
    return Book(
        id: dictionary['id'] ?? '',
        ten: dictionary['ten'] ?? '',
        anh: dictionary['anh'] ?? '',
        thoi_luong: dictionary['thoi_luong'] ?? '',
        tom_tat: dictionary['tom_tat'] ?? '',
        gioi_thieu: dictionary['gioi_thieu'] ?? '');
  }

  static get empty => Book();
}


class BookServices {
  static getBook(String uuid) {

  }

  static createOrUpdateBook(Book book) {

  }
}