// URLS GOOGLE MAP
// ADD GOOGLE API KEY HERE & ANDROID & IOS

// const BASE_URL_AUTH = "https://api.apothecary.dafa.dev/v1/mobile";

class ApiConstants {
  static const String baseURL = "https://easyservice.pythonanywhere.com/api/accounts/";

  static const String categoriesURL = "categories/";
  static const String serviceCategoryURL = "services/category/{cat_id}/"; //GET /services/category/{cat_id}/
  static const String serviceDetailURL = "services/detail/{service_id}/"; //GET /services/detail/{service_id}/
  static const String registerURL = "register/"; //POST /register/
  static const String loginURL = "login/"; //POST /login/
  static const String serviceTechniciansURL = "services/technicians/{service_id}/"; //GET /services/technicians/{service_id}/
  static const String bookingCreateURL = "booking/create/"; //POST /booking/create/
  static const String bookingCustomerURL = "booking/customer/{user_id}/"; //GET /booking/customer/{user_id}/
  static const String bookingUpdateStatusURL = "booking/update-status/"; //POST /booking/update-status/  static const String favoriteToggleURL = "favorite/toggle/"; //POST /favorite/toggle/
  static const String favoriteURL = "favorite/toggle/"; //GET /favorite/toggle/
  static const String bookingTechnicianURL = "booking/technician/{user_id}/";
}