class Program {
  final int id;
  final String code;
  final String name;
  final String? codeCategory;
  final String? codeCity;
  final int price;
  final int? duration;
  final int kuota;
  final int sisaKursi;
  final DateTime tanggalBerangkat;
  final String? desc;
  final String? picture;
  final String status;

  Program({
    required this.id,
    required this.code,
    required this.name,
    this.codeCategory,
    this.codeCity,
    required this.price,
    this.duration,
    required this.kuota,
    required this.sisaKursi,
    required this.tanggalBerangkat,
    this.desc,
    this.picture,
    required this.status,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      codeCategory: json['code_category'],
      codeCity: json['code_city'],
      price: json['price'],
      duration: json['duration'],
      kuota: json['kuota'],
      sisaKursi: json['sisa_kursi'],
      tanggalBerangkat: DateTime.parse(json['tanggal_berangkat']),
      desc: json['desc'],
      picture: json['picture'],
      status: json['status'],
    );
  }
}