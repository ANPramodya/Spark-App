class Messages {
  final String sender; //type User
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool isLiked;
  final bool unread;

  Messages({
    required this.sender,
    required this.time,
    required this.text,
    required this.isLiked,
    required this.unread,
  });

  static Messages fromJson(json) => Messages(
        sender: json['sender'],
        time: json['time'],
        text: json['text'],
        isLiked: json['isLiked'],
        unread: json['unread'],
      );
}

List<Messages> dummyMessages = [
  Messages(
      sender: 'Nipun',
      time: '15:38',
      text: 'Adimn ceerrrrr',
      isLiked: true,
      unread: true),
  Messages(
      sender: 'Admin cer',
      time: '15:38',
      text: 'ai ai ai ai',
      isLiked: true,
      unread: true),
  Messages(
      sender: 'Nipun',
      time: '15:39',
      text: 'Cod gahamu?',
      isLiked: true,
      unread: true),
  Messages(
      sender: 'Admin cer',
      time: '15:39',
      text: 'hitpn ennm',
      isLiked: true,
      unread: true),
  Messages(
      sender: 'Nipun',
      time: '15:39',
      text: 'Apo meh hack nm ain korala enta😜',
      isLiked: true,
      unread: true),
  Messages(
      sender: 'Admin cer',
      time: '15:40',
      text: 'hack naa yako🤬',
      isLiked: true,
      unread: true),
  Messages(
      sender: 'Nipun',
      time: '15:42',
      text: 'ow ow oya ithin hack gahan naa ne😂',
      isLiked: true,
      unread: true),
  Messages(
      sender: 'Nipun',
      time: '15:42',
      text: 'Api thama hack daagena oyagen marum kanne😂',
      isLiked: true,
      unread: true),
  Messages(
      sender: 'Admin cer',
      time: '15:50',
      text: 'Hitpn dennm ada ubata🗡⚔',
      isLiked: true,
      unread: true),
  Messages(
      sender: 'Nipun',
      time: '15:51',
      text: 'Onna adanna baa, left wenna ba.😂',
      isLiked: true,
      unread: true),
  Messages(
      sender: 'Admin cer',
      time: '15:51',
      text: 'waren mn server eke',
      isLiked: true,
      unread: true),
  Messages(
      sender: 'Nipun',
      time: '15:52',
      text: 'ocay',
      isLiked: true,
      unread: true),
];
