class Response {
  final bool status;
  final String? error;
  final List items;
  final Map<String, dynamic> item;
  final Map<String, dynamic>? data;
  final int count;
  final String? accessToken;
  final String? refreshToken;

  const Response(
      {required this.status, required this.item, required this.items, required this.count, this.accessToken, this.refreshToken, this.data,this.error, });

  factory Response.fromJson(Map<String, dynamic> dictionary) {
    return Response(
        status: dictionary['success'],
        items: dictionary['success'] ? dictionary['items'] : [],
        item: dictionary['success'] ? dictionary["item"] : {},
        data: dictionary['success'] ? dictionary["data"] : {},
        error: dictionary['error'] ?? '',
        accessToken: dictionary['success']? dictionary["access_token"] : '',
        refreshToken: dictionary['success']? dictionary["refresh_token"] : '',
        count:dictionary['count']);
  }
}
