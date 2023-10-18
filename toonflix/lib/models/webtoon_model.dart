class WebtoonModal {
  final String title, thumb, id;

  WebtoonModal.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
