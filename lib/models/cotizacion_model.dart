class CotizacionModel {
  CotizacionModel(
      {required this.id,
      required this.premiumBs,
      required this.days,
      required this.premiumUsd});

  final int id;
  final double premiumBs;
  final int days;
  final double premiumUsd;

  factory CotizacionModel.fromJson(Map<String, dynamic> json) {
    return CotizacionModel(
      id: json['id'],
      premiumBs: json['premium_bs'],
      days: json['days'],
      premiumUsd: json['premium_usd'],
    );
  }
}
