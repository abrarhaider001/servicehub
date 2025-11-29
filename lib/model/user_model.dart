class AddressModel {
  final String addressId;
  final String label;
  final String address;
  final double? lat;
  final double? lng;

  AddressModel({
    required this.addressId,
    required this.label,
    required this.address,
    this.lat,
    this.lng,
  });

  Map<String, dynamic> toJson() => {
        'addressId': addressId,
        'label': label,
        'address': address,
        'lat': lat,
        'lng': lng,
      };

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        addressId: json['addressId'] as String? ?? '',
        label: json['label'] as String? ?? 'Home',
        address: json['address'] as String? ?? '',
        lat: (json['lat'] as num?)?.toDouble(),
        lng: (json['lng'] as num?)?.toDouble(),
      );
}

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String profileImageUrl;
  final DateTime createdAt;
  final List<String> favorites;
  final String city;
  final List<AddressModel> address;
  final List<String> deviceTokens;
  final String walletId;
  final bool isSubscriptionPaid;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.profileImageUrl,
    required this.createdAt,
    required this.favorites,
    required this.city,
    required this.address,
    required this.deviceTokens,
    required this.walletId,
    required this.isSubscriptionPaid,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'email': email,
        'role': role,
        'profileImageUrl': profileImageUrl,
        'createdAt': createdAt.toIso8601String(),
        'favorites': favorites,
        'city': city,
        'address': address.map((e) => e.toJson()).toList(),
        'metadata': {
          'deviceTokens': deviceTokens,
        },
        'walletId': walletId,
        'isSubscriptionPaid': isSubscriptionPaid,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String? ?? '',
        fullName: json['fullName'] as String? ?? '',
        email: json['email'] as String? ?? '',
        role: json['role'] as String? ?? 'user',
        profileImageUrl: json['profileImageUrl'] as String? ?? '',
        createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
        favorites: (json['favorites'] as List<dynamic>? ?? const []).map((e) => e.toString()).toList(),
        city: json['city'] as String? ?? '',
        address: ((json['address'] as List<dynamic>? ?? const [])
                .map((e) => AddressModel.fromJson((e as Map).cast<String, dynamic>())))
            .toList(),
        deviceTokens: ((json['metadata'] as Map<String, dynamic>? ?? const {})['deviceTokens'] as List<dynamic>? ?? const [])
            .map((e) => e.toString())
            .toList(),
        walletId: json['walletId'] as String? ?? '',
        isSubscriptionPaid: json['isSubscriptionPaid'] as bool? ?? false,
      );

  UserModel copyWith({bool? isSubscriptionPaid}) => UserModel(
        id: id,
        fullName: fullName,
        email: email,
        role: role,
        profileImageUrl: profileImageUrl,
        createdAt: createdAt,
        favorites: favorites,
        city: city,
        address: address,
        deviceTokens: deviceTokens,
        walletId: walletId,
        isSubscriptionPaid: isSubscriptionPaid ?? this.isSubscriptionPaid,
      );
}

