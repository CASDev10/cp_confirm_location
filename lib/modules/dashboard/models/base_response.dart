// To parse this JSON data, do
//
//     final baseResponse = baseResponseFromJson(jsonString);

import 'dart:convert';

BaseResponse baseResponseFromJson(dynamic json) => BaseResponse.fromJson(json);

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse {
  int code;
  String message;
  bool success;
  String data;

  BaseResponse({
    required this.code,
    required this.message,
    required this.success,
    required this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
    code: json["code"],
    message: json["message"],
    success: json["success"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "success": success,
    "data": data,
  };
}
