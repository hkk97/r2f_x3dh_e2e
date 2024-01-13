class Message {
  final String text;
  final KeyPair keyPair;

  Message({
    required this.text,
    required this.keyPair,
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
  final String u1SharedSecretKey;
  final String u2SharedSecretKey;

  KeyPair({
    required this.u1SharedSecretKey,
    required this.u2SharedSecretKey,
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
