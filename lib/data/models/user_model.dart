class User{
  final String username;
  final String email;
  final List<String> roles;
  final String? address;
  final String? id;
  
  


  User({required this.id,required this.username,required this.email,
  required this.roles,required this.address});


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
     username: json['username'] ?? '', // Provide default if null
      email: json['email'] ?? '',
      roles: List<String>.from(json['roles'] ?? []), // Ensure roles is not null
      address: json['address'] as String?, // Allow address to be null
      id: json['_id'] as String?, // Allow id to be null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'roles': roles,
      'address': address,
      // Omit password for security reasons
    };
  }
}