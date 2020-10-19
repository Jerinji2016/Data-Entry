class User {
  String name, phone, email, id, imgUrl;

  User({this.id, this.name, this.phone, this.email, this.imgUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'phone': this.phone,
      'imageURL': this.imgUrl
    };
  }

  static User fromMap(Map<String, dynamic> user) => new User(
      id: user["_id"],
      name: user["name"],
      email: user["email"],
      phone: user["phone"],
      imgUrl: user["image"]);

  static validImageUrl(String testUrl) {
    String url = testUrl.toLowerCase();
    
    return (url.endsWith('jpg') ||
        url.endsWith('png') ||
        url.endsWith('gif') ||
        url.endsWith('bmp') ||
        url.endsWith('webp'));
  }
}
