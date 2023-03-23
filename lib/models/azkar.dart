class Zekr {
  final String? zekr;
  final String? count;
  final String? category;
  Zekr({required this.zekr, required this.count, required this.category});
  factory Zekr.fromJson(Map<String, dynamic> json) {
    return Zekr(
        zekr: json["zekr"], count: json["count"], category: json["category"]);
  }
  Map<String, dynamic> tojson() =>
      {"zekr": zekr, "count": count, "category": category};
}
