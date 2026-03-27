class MarketModel {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  String? address;
  double? long;
  double? lat;
  int? status;
  double? distance;
  String? distanceUint;
  // List<OfferModel> offers = [];
  MarketModel({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.address,
    this.long,
    this.lat,
    this.status,
    this.distance,
    // this.offers = const []
  });

  MarketModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    address = json['address'];
    long = json['long'];
    lat = json['lat'];
    status = json['status'];
    distance = json['distance'];
    // offers = json['offers'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['address'] = address;
    data['long'] = long;
    data['lat'] = lat;
    data['status'] = status;
    data['distance'] = distance;
    // data['offers'] = offers;
    return data;
  }

  handleDistance(double distance) {
    if (distance >= 0) {
      distance = distance;
      // distanceUint = "$distance m";
    } else if (distance >= 1000) {
      distance = distance / 1000;
      // distanceUint = "$distance km";
    } else if (distance >= 100000) {
      distance = distance / 100000;
      // distanceUint = "$distance million";
    }
  }
}
