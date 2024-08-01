// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';

import 'package:http_proxy_worker/service/api_service.dart';

class PingCommand {
  String? command;
  List<RequestTracker>? requests;
  PingCommand({
    this.command,
    this.requests,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'command': command,
      'requests': requests?.map((x) => x.toMap()).toList(),
    };
  }

  factory PingCommand.fromMap(Map<String, dynamic> map) {
    return PingCommand(
      command: map['command'] != null ? map['command'] as String : null,
      requests: map['requests'] != null
          ? List<RequestTracker>.from(
              (map['requests'] as List<dynamic>).map<RequestTracker?>(
                (x) => RequestTracker.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PingCommand.fromJson(String source) =>
      PingCommand.fromMap(json.decode(source) as Map<String, dynamic>);

  PingCommand copyWith({
    String? command,
    List<RequestTracker>? requests,
  }) {
    return PingCommand(
      command: command ?? this.command,
      requests: requests ?? this.requests,
    );
  }
}

class HttpInfo {
  int? secondPingSeq;
  String? sessionId;
  int? primaryTimeout;
  bool? sendResponseWithSecondary;

  HttpInfo({
    this.secondPingSeq,
    this.sessionId,
    this.primaryTimeout,
    this.sendResponseWithSecondary,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'secondPingSeq': secondPingSeq,
      'sessionId': sessionId,
      'primaryTimeout': primaryTimeout,
      'sendResponseWithSecondary': sendResponseWithSecondary,
    };
  }

  factory HttpInfo.fromMap(Map<String, dynamic> map) {
    return HttpInfo(
      secondPingSeq:
          map['secondPingSeq'] != null ? map['secondPingSeq'] as int : null,
      sessionId: map['sessionId'] != null ? map['sessionId'] as String : null,
      primaryTimeout:
          map['primaryTimeout'] != null ? map['primaryTimeout'] as int : null,
      sendResponseWithSecondary: map['sendResponseWithSecondary'] != null
          ? map['sendResponseWithSecondary'] as bool
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HttpInfo.fromJson(String source) =>
      HttpInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  HttpInfo copyWith({
    int? secondPingSeq,
    String? sessionId,
    int? primaryTimeout,
    bool? sendResponseWithSecondary,
  }) {
    return HttpInfo(
      secondPingSeq: secondPingSeq ?? this.secondPingSeq,
      sessionId: sessionId ?? this.sessionId,
      primaryTimeout: primaryTimeout ?? this.primaryTimeout,
      sendResponseWithSecondary:
          sendResponseWithSecondary ?? this.sendResponseWithSecondary,
    );
  }
}

class DeviceInfoModels {
  DeviceInfoPlugin? deviceInfo;
  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;
  HttpInfo? httpInfo;
  PingCommand? pingCommand;

  DeviceInfoModels({
    this.deviceInfo,
    this.androidInfo,
    this.iosInfo,
    this.httpInfo,
    this.pingCommand,
  });

  factory DeviceInfoModels.init() {
    return DeviceInfoModels();
  }

  fromApi() async {
    var res = await ApiService.shared.getDeviceInfo();
    print(res);
    return DeviceInfoModels(
      androidInfo: res["androidInfo"],
      deviceInfo: res["deviceInfo"],
      iosInfo: res["iosInfo"],
      httpInfo: null,
      pingCommand: null,
    );
  }

  updateHttpInfo(Map<String, dynamic> map) {
    httpInfo = HttpInfo.fromMap(map);
  }

  updatePingCommand(Map<String, dynamic> map) {
    pingCommand = PingCommand.fromMap(map);
  }

  DeviceInfoModels update(
      {DeviceInfoPlugin? deviceInfo,
      AndroidDeviceInfo? androidInfo,
      IosDeviceInfo? iosInfo}) {
    return DeviceInfoModels(
      deviceInfo: deviceInfo ?? this.deviceInfo,
      androidInfo: androidInfo ?? this.androidInfo,
      iosInfo: iosInfo ?? this.iosInfo,
    );
  }

  DeviceInfoModels copyWith({
    DeviceInfoPlugin? deviceInfo,
    AndroidDeviceInfo? androidInfo,
    IosDeviceInfo? iosInfo,
    HttpInfo? httpInfo,
    PingCommand? pingCommand,
  }) {
    return DeviceInfoModels(
      deviceInfo: deviceInfo ?? this.deviceInfo,
      androidInfo: androidInfo ?? this.androidInfo,
      iosInfo: iosInfo ?? this.iosInfo,
      httpInfo: httpInfo ?? this.httpInfo,
      pingCommand: pingCommand ?? this.pingCommand,
    );
  }

  @override
  bool operator ==(covariant DeviceInfoModels other) {
    if (identical(this, other)) return true;

    return other.deviceInfo == deviceInfo &&
        other.androidInfo == androidInfo &&
        other.iosInfo == iosInfo;
  }

  @override
  int get hashCode =>
      deviceInfo.hashCode ^ androidInfo.hashCode ^ iosInfo.hashCode;
}

class PingDtos {
  String? command;
  PingDtos({
    this.command,
  });

  PingDtos copyWith({
    String? command,
  }) {
    return PingDtos(
      command: command ?? this.command,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'command': command,
    };
  }

  factory PingDtos.fromMap(Map<String, dynamic> map) {
    return PingDtos(
      command: map['command'] != null ? map['command'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PingDtos.fromJson(String source) =>
      PingDtos.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DeviceInfoDtos {
  String? sessionId;
  int? primaryTimeout;
  bool? sendResponseWithSecondary;
  int? secondPingSeq;
  DeviceInfoDtos({
    this.sessionId,
    this.primaryTimeout,
    this.sendResponseWithSecondary,
    this.secondPingSeq,
  });

  DeviceInfoDtos copyWith({
    String? sessionId,
    int? primaryTimeout,
    bool? sendResponseWithSecondary,
    int? secondPingSeq,
  }) {
    return DeviceInfoDtos(
      sessionId: sessionId ?? this.sessionId,
      primaryTimeout: primaryTimeout ?? this.primaryTimeout,
      sendResponseWithSecondary:
          sendResponseWithSecondary ?? this.sendResponseWithSecondary,
      secondPingSeq: secondPingSeq ?? this.secondPingSeq,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sessionId': sessionId,
      'primaryTimeout': primaryTimeout,
      'sendResponseWithSecondary': sendResponseWithSecondary,
      'secondPingSeq': secondPingSeq,
    };
  }

  factory DeviceInfoDtos.fromMap(Map<String, dynamic> map) {
    return DeviceInfoDtos(
      sessionId: map['sessionId'] != null ? map['sessionId'] as String : null,
      primaryTimeout:
          map['primaryTimeout'] != null ? map['primaryTimeout'] as int : null,
      sendResponseWithSecondary: map['sendResponseWithSecondary'] != null
          ? map['sendResponseWithSecondary'] as bool
          : null,
      secondPingSeq:
          map['secondPingSeq'] != null ? map['secondPingSeq'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceInfoDtos.fromJson(String source) =>
      DeviceInfoDtos.fromMap(json.decode(source) as Map<String, dynamic>);
}

class APIResult {
  String? message;
  int? code;
  bool? isPopup;
  dynamic data;
  APIResult({
    this.message,
    this.code,
    this.isPopup,
    this.data,
  });

  APIResult copyWith({
    String? message,
    int? code,
    bool? isPopup,
    dynamic data,
  }) {
    return APIResult(
      message: message ?? this.message,
      code: code ?? this.code,
      isPopup: isPopup ?? this.isPopup,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'code': code,
      'isPopup': isPopup,
      'data': data,
    };
  }

  factory APIResult.fromMap(Map<String, dynamic> map) {
    return APIResult(
      message: map['message'] != null ? map['message'] as String : null,
      code: map['code'] != null ? map['code'] as int : null,
      isPopup: map['isPopup'] != null ? map['isPopup'] as bool : null,
      data: map['data'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory APIResult.fromJson(String source) =>
      APIResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'APIResult(message: $message, code: $code, isPopup: $isPopup, data: $data)';
  }

  @override
  bool operator ==(covariant APIResult other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.code == code &&
        other.isPopup == isPopup &&
        other.data == data;
  }

  @override
  int get hashCode {
    return message.hashCode ^ code.hashCode ^ isPopup.hashCode ^ data.hashCode;
  }
}

class HeaderTracker {
  String? Accept;
  String? AcceptLanguage;
  String? UserAgent;
  String? Host;
  String? Origin;
  String? Referer;
  HeaderTracker({
    this.Accept,
    this.AcceptLanguage,
    this.UserAgent,
    this.Host,
    this.Origin,
    this.Referer,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Accept': Accept,
      'AcceptLanguage': AcceptLanguage,
      'UserAgent': UserAgent,
      'Host': Host,
      'Origin': Origin,
      'Referer': Referer,
    };
  }

  factory HeaderTracker.fromMap(Map<String, dynamic> map) {
    return HeaderTracker(
      Accept: map['Accept'] != null ? map['Accept'] as String : null,
      AcceptLanguage: map['Accept-Language'] != null
          ? map['Accept-Language'] as String
          : null,
      UserAgent: map['User-Agent'] != null ? map['User-Agent'] as String : null,
      Host: map['Host'] != null ? map['Host'] as String : null,
      Origin: map['Origin'] != null ? map['Origin'] as String : null,
      Referer: map['Referer'] != null ? map['Referer'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HeaderTracker.fromJson(String source) =>
      HeaderTracker.fromMap(json.decode(source) as Map<String, dynamic>);

  HeaderTracker copyWith({
    String? Accept,
    String? AcceptLanguage,
    String? UserAgent,
    String? Host,
    String? Origin,
    String? Referer,
  }) {
    return HeaderTracker(
      Accept: Accept ?? this.Accept,
      AcceptLanguage: AcceptLanguage ?? this.AcceptLanguage,
      UserAgent: UserAgent ?? this.UserAgent,
      Host: Host ?? this.Host,
      Origin: Origin ?? this.Origin,
      Referer: Referer ?? this.Referer,
    );
  }
}

class RequestTracker {
  String? id;
  String? createdTime;
  String? updatedTime;
  bool? isLocked;
  bool? isDraft;
  String? schema;
  String? creator;
  int? version_number;
  String? name;
  String? url;
  String? payload;
  HeaderTracker? header;
  String? status;
  String? method;
  String? action;
  String? process_status;
  String? content;
  int? statusCode;
  String? process_error;
  String? sessionId;
  String? workerId;
  String? updater;
  RequestTracker({
    this.id,
    this.createdTime,
    this.updatedTime,
    this.isLocked,
    this.isDraft,
    this.schema,
    this.creator,
    this.version_number,
    this.name,
    this.url,
    this.payload,
    this.header,
    this.status,
    this.method,
    this.action,
    this.process_status,
    this.content,
    this.statusCode,
    this.process_error,
    this.sessionId,
    this.workerId,
    this.updater,
  });

  RequestTracker copyWith({
    String? id,
    String? createdTime,
    String? updatedTime,
    bool? isLocked,
    bool? isDraft,
    String? schema,
    String? creator,
    int? version_number,
    String? name,
    String? url,
    String? payload,
    HeaderTracker? header,
    String? status,
    String? method,
    String? action,
    String? process_status,
    String? content,
    int? statusCode,
    String? process_error,
    String? sessionId,
    String? workerId,
    String? updater,
  }) {
    return RequestTracker(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
      isLocked: isLocked ?? this.isLocked,
      isDraft: isDraft ?? this.isDraft,
      schema: schema ?? this.schema,
      creator: creator ?? this.creator,
      version_number: version_number ?? this.version_number,
      name: name ?? this.name,
      url: url ?? this.url,
      payload: payload ?? this.payload,
      header: header ?? this.header,
      status: status ?? this.status,
      method: method ?? this.method,
      action: action ?? this.action,
      process_status: process_status ?? this.process_status,
      content: content ?? this.content,
      statusCode: statusCode ?? this.statusCode,
      process_error: process_error ?? this.process_error,
      sessionId: sessionId ?? this.sessionId,
      workerId: workerId ?? this.workerId,
      updater: updater ?? this.updater,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
      'isLocked': isLocked,
      'isDraft': isDraft,
      'schema': schema,
      'creator': creator,
      'version_number': version_number,
      'name': name,
      'url': url,
      'payload': payload,
      'header': header?.toMap(),
      'status': status,
      'method': method,
      'action': action,
      'process_status': process_status,
      'content': content,
      'statusCode': statusCode,
      'process_error': process_error,
      'sessionId': sessionId,
      'workerId': workerId,
      'updater': updater,
    };
  }

  factory RequestTracker.fromMap(Map<String, dynamic> map) {
    return RequestTracker(
      id: map['id'] != null ? map['id'] as String : null,
      createdTime:
          map['createdTime'] != null ? map['createdTime'] as String : null,
      updatedTime:
          map['updatedTime'] != null ? map['updatedTime'] as String : null,
      isLocked: map['isLocked'] != null ? map['isLocked'] as bool : null,
      isDraft: map['isDraft'] != null ? map['isDraft'] as bool : null,
      schema: map['schema'] != null ? map['schema'] as String : null,
      creator: map['creator'] != null ? map['creator'] as String : null,
      version_number:
          map['version_number'] != null ? map['version_number'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      payload: map['payload'] != null ? map['payload'] as String : null,
      header: map['header'] != null
          ? HeaderTracker.fromMap(map['header'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      method: map['method'] != null ? map['method'] as String : null,
      action: map['action'] != null ? map['action'] as String : null,
      process_status: map['process_status'] != null
          ? map['process_status'] as String
          : null,
      content: map['content'] != null ? map['content'] as String : null,
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
      process_error:
          map['process_error'] != null ? map['process_error'] as String : null,
      sessionId: map['sessionId'] != null ? map['sessionId'] as String : null,
      workerId: map['workerId'] != null ? map['workerId'] as String : null,
      updater: map['updater'] != null ? map['updater'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestTracker.fromJson(String source) =>
      RequestTracker.fromMap(json.decode(source) as Map<String, dynamic>);
}
