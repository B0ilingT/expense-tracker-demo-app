import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import the locale data initialization library

void main() async {
  // Initialize the locale data for 'en_GB'
  await initializeDateFormatting('en_GB', null);

  // Now you can create your date formatter
  final formatter = DateFormat('dd/MM/yyyy', 'en_GB');

  // Use the formatter as needed
  print(formatter.format(DateTime.now())); // Example usage
}


final formatter = DateFormat('dd/MM/yyyy', 'en_GB');

class DateFormatter {
  static String format(DateTime date) {
    return formatter.format(date);
  }
}
