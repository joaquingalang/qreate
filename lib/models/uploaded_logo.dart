
class UploadedLogo {
  const UploadedLogo({
    this.id,
    this.userId,
    this.url,
    this.path,
  });

  final int? id;
  final String? userId;
  final String? url;
  final String? path;

  // Map to QrCode
  factory UploadedLogo.fromMap(Map<String, dynamic> map) {
    return UploadedLogo(
      id: map['id'],
      userId: map['user_id'],
      url: map['url'],
      path: map['path']
    );
  }

  // QrCode to Map
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'url': url,
      'path': path,
    };
  }
}