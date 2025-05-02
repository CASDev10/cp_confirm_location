// To parse this JSON data, do
//
//     final orderDetailResponse = orderDetailResponseFromJson(jsonString);

import 'dart:convert';

OrderDetailResponse orderDetailResponseFromJson(String str) =>
    OrderDetailResponse.fromJson(json.decode(str));

String orderDetailResponseToJson(OrderDetailResponse data) =>
    json.encode(data.toJson());

class OrderDetailResponse {
  int code;
  String message;
  bool success;
  OrderModel data;

  OrderDetailResponse({
    required this.code,
    required this.message,
    required this.success,
    required this.data,
  });

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      OrderDetailResponse(
        code: json["code"],
        message: json["message"],
        success: json["success"],
        data: OrderModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "success": success,
        "data": data.toJson(),
      };
}

class OrderModel {
  String locationId;
  int invoiceNo;
  DateTime invoiceDate;
  String invoiceType;
  String paymentMode;
  String partyId;
  String receiptNo;
  int invoiceTotal;
  int invoiceDiscount;
  int fpBox;
  int fpCharges;
  int cpCharges;
  int deliveryCharges;
  int promoCode;
  String remarks;
  bool isLocationUpdate;
  int netInvoiceTotal;
  CustomerModel customer;
  List<ItemModel> items;
  String transactionBy;

  OrderModel({
    required this.locationId,
    required this.invoiceNo,
    required this.invoiceDate,
    required this.invoiceType,
    required this.paymentMode,
    required this.partyId,
    required this.receiptNo,
    required this.invoiceTotal,
    required this.invoiceDiscount,
    required this.fpBox,
    required this.fpCharges,
    required this.cpCharges,
    required this.deliveryCharges,
    required this.promoCode,
    required this.remarks,
    required this.isLocationUpdate,
    required this.netInvoiceTotal,
    required this.customer,
    required this.items,
    required this.transactionBy,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        locationId: json["locationID"],
        invoiceNo: json["invoiceNo"],
        invoiceDate: DateTime.parse(json["invoiceDate"]),
        invoiceType: json["invoiceType"],
        paymentMode: json["paymentMode"],
        partyId: json["partyID"],
        receiptNo: json["receiptNo"],
        invoiceTotal: json["invoiceTotal"],
        invoiceDiscount: json["invoiceDiscount"],
        fpBox: json["fpBox"],
        fpCharges: json["fpCharges"],
        cpCharges: json["cpCharges"],
        deliveryCharges: json["deliveryCharges"],
        promoCode: json["promoCode"],
        remarks: json["remarks"],
        isLocationUpdate: json["isLocationUpdate"],
        netInvoiceTotal: json["netInvoiceTotal"],
        customer: CustomerModel.fromJson(json["customer"]),
        items: List<ItemModel>.from(
          json["items"].map((x) => ItemModel.fromJson(x)),
        ),
        transactionBy: json["transactionBy"],
      );

  Map<String, dynamic> toJson() => {
        "locationID": locationId,
        "invoiceNo": invoiceNo,
        "invoiceDate": invoiceDate.toIso8601String(),
        "invoiceType": invoiceType,
        "paymentMode": paymentMode,
        "partyID": partyId,
        "receiptNo": receiptNo,
        "invoiceTotal": invoiceTotal,
        "invoiceDiscount": invoiceDiscount,
        "fpBox": fpBox,
        "fpCharges": fpCharges,
        "cpCharges": cpCharges,
        "deliveryCharges": deliveryCharges,
        "promoCode": promoCode,
        "remarks": remarks,
        "isLocationUpdate": isLocationUpdate,
        "netInvoiceTotal": netInvoiceTotal,
        "customer": customer.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "transactionBy": transactionBy,
      };
}

class CustomerModel {
  String partyId;
  String partyName;
  String mobile;
  String address;
  String lat;
  String long;

  CustomerModel({
    required this.partyId,
    required this.partyName,
    required this.mobile,
    required this.address,
    required this.lat,
    required this.long,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        partyId: json["partyID"],
        partyName: json["partyName"],
        mobile: json["mobile"],
        address: json["address"],
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "partyID": partyId,
        "partyName": partyName,
        "mobile": mobile,
        "address": address,
        "lat": lat,
        "long": long,
      };
}

class ItemModel {
  String itemId;
  String itemName;
  int quantity;
  int rate;
  int amount;
  int discountId;
  int itemDiscountPercent;
  int itemPercentageAmount;
  int itemDiscount;
  int gstPercent;
  int gstAmount;
  bool applyTax;
  bool applyDiscount;
  String discountType;
  int subTotal;

  ItemModel({
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.rate,
    required this.amount,
    required this.discountId,
    required this.itemDiscountPercent,
    required this.itemPercentageAmount,
    required this.itemDiscount,
    required this.gstPercent,
    required this.gstAmount,
    required this.applyTax,
    required this.applyDiscount,
    required this.discountType,
    required this.subTotal,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        itemId: json["itemID"],
        itemName: json["itemName"],
        quantity: json["quantity"],
        rate: json["rate"],
        amount: json["amount"],
        discountId: json["discountID"],
        itemDiscountPercent: json["itemDiscountPercent"],
        itemPercentageAmount: json["itemPercentageAmount"],
        itemDiscount: json["itemDiscount"],
        gstPercent: json["gstPercent"],
        gstAmount: json["gstAmount"],
        applyTax: json["applyTax"],
        applyDiscount: json["applyDiscount"],
        discountType: json["discountType"],
        subTotal: json["subTotal"],
      );

  Map<String, dynamic> toJson() => {
        "itemID": itemId,
        "itemName": itemName,
        "quantity": quantity,
        "rate": rate,
        "amount": amount,
        "discountID": discountId,
        "itemDiscountPercent": itemDiscountPercent,
        "itemPercentageAmount": itemPercentageAmount,
        "itemDiscount": itemDiscount,
        "gstPercent": gstPercent,
        "gstAmount": gstAmount,
        "applyTax": applyTax,
        "applyDiscount": applyDiscount,
        "discountType": discountType,
        "subTotal": subTotal,
      };
}
