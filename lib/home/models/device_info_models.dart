// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';

import 'package:http_proxy_worker/service/api_service.dart';

class DeviceInfoModels {
  DeviceInfoPlugin? deviceInfo;
  AndroidDeviceInfo? androidInfo;
  IosDeviceInfo? iosInfo;
  DeviceInfoModels({this.androidInfo, this.deviceInfo, this.iosInfo});

  factory DeviceInfoModels.fromApi() {
    var res = ApiService.shared.getDeviceInfo();
    return DeviceInfoModels(
      androidInfo: res.androidInfo,
      deviceInfo: res.deviceInfo,
      iosInfo: res.iosInfo,
    );
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
  }) {
    return DeviceInfoModels(
      deviceInfo: deviceInfo ?? this.deviceInfo,
      androidInfo: androidInfo ?? this.androidInfo,
      iosInfo: iosInfo ?? this.iosInfo,
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
