class ProfileDTO {
  String name;
  String email;
  String image;
  String phone;

  ProfileDTO({
    required this.name,
    required this.email,
    required this.image,
    required this.phone,
  });

  factory ProfileDTO.fromApi(dynamic data) {
    return ProfileDTO(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      image: data['image'] ?? '',
      phone: data['phone'] ?? '',
    );
  }
}
