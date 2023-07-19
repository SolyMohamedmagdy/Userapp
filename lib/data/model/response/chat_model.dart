class ChatModel {
  int? totalSize;
  int? limit;
  int? offset;
  List<Messages>? messages;

  ChatModel(
      {this.totalSize = 0, this.limit = 0, this.offset = 0, this.messages});

  ChatModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'] ?? 0;
    limit = json['limit'] ?? 0;
    offset = json['offset'] ?? 0;
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages?.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  int id = 0;
  int conversationId = 0;
  CustomerId? customerId;
  DeliverymanId? deliverymanId;
  String message = '';
  String reply = '';
  List<String>? attachment;
  List<String>? image;
  bool isReply = false;
  String createdAt = '';
  String updatedAt = '';

  Messages({
    this.id = 0,
    this.conversationId = 0,
    this.customerId,
    this.deliverymanId,
    this.message = '',
    this.reply = '',
    this.attachment,
    this.image,
    this.isReply = false,
    this.createdAt = '',
    this.updatedAt = '',
  });

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    conversationId = json['conversation_id'] ?? 0;
    customerId = json['customer_id'] != null
        ? CustomerId.fromJson(json['customer_id'])
        : null;
    deliverymanId = json['deliveryman_id'] != null
        ? DeliverymanId.fromJson(json['deliveryman_id'])
        : null;
    message = json['message'] ?? '';
    reply = json['reply'] ?? '';
    attachment = json['attachment'] != null
        ? List<String>.from(json['attachment'])
        : null;
    image = json['image'] != null ? List<String>.from(json['image']) : null;
    isReply = json['is_reply'] ?? false;
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['conversation_id'] = this.conversationId;
    if (this.customerId != null) {
      data['customer_id'] = this.customerId!.toJson();
    }
    if (this.deliverymanId != null) {
      data['deliveryman_id'] = this.deliverymanId!.toJson();
    }
    data['message'] = this.message;
    data['reply'] = this.reply;
    data['attachment'] = this.attachment;
    data['image'] = this.image;
    data['is_reply'] = this.isReply;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}

class CustomerId {
  String name = '';
  String image = '';

  CustomerId({this.name = '', this.image = ''});

  CustomerId.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class DeliverymanId {
  String name = '';
  String image = '';

  DeliverymanId({this.name = '', this.image = ''});

  DeliverymanId.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
