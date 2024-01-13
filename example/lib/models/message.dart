class Message {
  final String text; // The text of the message
  final KeyPair keyPair; // The key pair associated with the message

  Message({
    required this.text, // The text of the message
    required this.keyPair, // The key pair associated with the message
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'keyPair': keyPair.toJson(),
      };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        text: json['text'],
        keyPair: KeyPair.fromJson(json['key_pair']),
      );
}

class KeyPair {
  final String u1SharedSecretKey; // The shared secret key for user 1
  final String u2SharedSecretKey; // The shared secret key for user 2

  KeyPair({
    required this.u1SharedSecretKey, // The shared secret key for user 1
    required this.u2SharedSecretKey, // The shared secret key for user 2
  });

  Map<String, dynamic> toJson() => {
        'u1SharedSecretKey': u1SharedSecretKey,
        'u2SharedSecretKey': u2SharedSecretKey,
      };

  factory KeyPair.fromJson(Map<String, dynamic> json) => KeyPair(
        u1SharedSecretKey: json['u1_shared_secret_key'],
        u2SharedSecretKey: json['u2_shared_secret_key'],
      );
}
