
import 'dart:convert';

List<Request> requestFromJson(String str) =>
    List<Request>.from(json.decode(str).map((x) => Request.fromJson(x)));

String requestToJson(List<Request> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Request {
  DateTime createdAt;
  String firstName;
  String idNumber;
  String idType;
  String lastName;
  String secondLastName;
  String secondName;
  String status;

  Request({
    required this.createdAt,
    required this.firstName,
    required this.idNumber,
    required this.idType,
    required this.lastName,
    required this.secondLastName,
    required this.secondName,
    required this.status,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    createdAt: DateTime.parse(json["createdAt"]),
    firstName: json["firstName"],
    idNumber: json["idNumber"],
    idType: json["idType"],
    lastName: json["lastName"],
    secondLastName: json["secondLastName"],
    secondName: json["secondName"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
    "firstName": firstName,
    "idNumber": idNumber,
    "idType": idType,
    "lastName": lastName,
    "secondLastName": secondLastName,
    "secondName": secondName,
    "status": status,
  };
}
