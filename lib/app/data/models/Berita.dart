class Berita {
  final int id;
  final String name;
  final String codeCategory;
  final String? content;
  final String? picture;
  final String? url;
  final String publish;
  final DateTime? createdAt;

  Berita({
    required this.id,
    required this.name,
    required this.codeCategory,
    this.content,
    this.picture,
    this.url,
    required this.publish,
    this.createdAt,
  });

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      id: json['id'],
      name: json['name'],
      codeCategory: json['code_category'],
      content: json['content'],
      picture: json['picture'],
      url: json['url'],
      publish: json['publish'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
    );
  }
}