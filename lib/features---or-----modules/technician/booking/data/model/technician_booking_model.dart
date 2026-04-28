import 'package:clean_arc/core/enums/booking_status.dart';

class TechnicianBooking {
  int? id;
  ServiceDetails? serviceDetails;
  String? streetAddress;
  String? zipCode;
  String? city;
  String? bookingDate;
  String? bookingTime;
  String? status;
  String? createdAt;

  BookingStatus get bookingStatus {
    switch (status?.toLowerCase()) {
      case 'pending':
        return BookingStatus.pending;
      case 'accepted':
        return BookingStatus.accepted;
      case 'rejected':
        return BookingStatus.rejected;
      case 'completed':
        return BookingStatus.completed;
      default:
        return BookingStatus.pending;
    }
  }
  int? customer;
  int? technician;
  int? service;

  TechnicianBooking(
      {this.id,
        this.serviceDetails,
        this.streetAddress,
        this.zipCode,
        this.city,
        this.bookingDate,
        this.bookingTime,
        this.status,
        this.createdAt,
        this.customer,
        this.technician,
        this.service});

  TechnicianBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceDetails = json['service_details'] != null
        ? ServiceDetails.fromJson(json['service_details'])
        : null;
    streetAddress = json['street_address'];
    zipCode = json['zip_code'];
    city = json['city'];
    bookingDate = json['booking_date'];
    bookingTime = json['booking_time'];
    status = json['status'];
    createdAt = json['created_at'];
    customer = json['customer'];
    technician = json['technician'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (serviceDetails != null) {
      data['service_details'] = serviceDetails!.toJson();
    }
    data['street_address'] = streetAddress;
    data['zip_code'] = zipCode;
    data['city'] = city;
    data['booking_date'] = bookingDate;
    data['booking_time'] = bookingTime;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['customer'] = customer;
    data['technician'] = technician;
    data['service'] = service;
    return data;
  }
}

class ServiceDetails {
  int? id;
  int? category;
  String? nameAr;
  String? nameEn;
  String? price;
  String? description;
  String? image;
  String? rating;
  String? duration;

  ServiceDetails(
      {this.id,
        this.category,
        this.nameAr,
        this.nameEn,
        this.price,
        this.description,
        this.image,
        this.rating,
        this.duration});

  ServiceDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    rating = json['rating'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['price'] = price;
    data['description'] = description;
    data['image'] = image;
    data['rating'] = rating;
    data['duration'] = duration;
    return data;
  }
}
