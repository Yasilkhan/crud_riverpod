class DetailModel {
  final String firstName;
  final String lastName;
  final String address;
  final String email;
  String? id;
  String? imageUrl;

  DetailModel({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.email,
    this.id,
    this.imageUrl,
  });

  // Serialize the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'email': email,
      'id': id,
      'imageUrl': imageUrl,
    };
  }

  // Deserialize JSON to create a DetailModel instance
  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      address: json['address'] ?? '',
      email: json['email'] ?? '',
      id: json['id'],
      imageUrl: json['imageUrl'],
    );
  }

  // Create a copy of the model with updated values
  DetailModel copyWith({
    String? firstName,
    String? lastName,
    String? address,
    String? email,
    String? id,
    String? imageUrl,
  }) {
    return DetailModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      email: email ?? this.email,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
