String parseErrorMessages(Map<String, dynamic> errorResponse) {
  List<String> errors = [];

  if (errorResponse.containsKey('errors')) {
    Map<String, dynamic> errorDetails = errorResponse['errors'];

    for (var fieldErrors in errorDetails.values) {
      if (fieldErrors is List) {
        errors.addAll(fieldErrors.map((e) => e.toString()));
      }
    }
  }

  return errors.join(" & ");
}
