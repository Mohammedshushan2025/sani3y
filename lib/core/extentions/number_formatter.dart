class NumberFormatter {
  /// Formats a number string to have comma separators for human readability
  /// Example: "1000000" -> "1,000,000"
  static String formatPrice(String? price) {
    if (price == null || price.isEmpty) {
      return '';
    }

    // Remove any existing commas and whitespace
    String cleanPrice = price.replaceAll(RegExp(r'[,\s]'), '');

    // Check if it's a valid number
    if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(cleanPrice)) {
      return price; // Return original if not a valid number
    }

    // Parse as double to handle decimal numbers
    double? numericValue = double.tryParse(cleanPrice);
    if (numericValue == null) {
      return price; // Return original if parsing fails
    }

    // Convert to integer if it's a whole number
    if (numericValue % 1 == 0) {
      int intValue = numericValue.toInt();
      return _addCommasToInteger(intValue);
    } else {
      // Handle decimal numbers
      List<String> parts = cleanPrice.split('.');
      String integerPart = _addCommasToInteger(int.parse(parts[0]));
      return '$integerPart.${parts[1]}';
    }
  }

  /// Adds commas to an integer for readability
  /// Example: 1000000 -> "1,000,000"
  static String _addCommasToInteger(int number) {
    String numberStr = number.toString();
    String result = '';
    int count = 0;
    // Add commas from right to left
    for (int i = numberStr.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) {
        result = ',$result';
      }
      result = numberStr[i] + result;
      count++;
    }
    return result;
  }

  /// Formats a dynamic value (could be String, int, or double) to a readable price format
  static String formatDynamicPrice(dynamic price) {
    if (price == null) return '';
    if (price is String) {
      return formatPrice(price);
    } else if (price is int) {
      return _addCommasToInteger(price);
    } else if (price is double) {
      if (price % 1 == 0) {
        return _addCommasToInteger(price.toInt());
      } else {
        String priceStr = price.toString();
        List<String> parts = priceStr.split('.');
        String integerPart = _addCommasToInteger(int.parse(parts[0]));
        return '$integerPart.${parts[1]}';
      }
    }
    return price.toString();
  }
}
