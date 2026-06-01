import 'package:intl/intl.dart';

abstract final class AppDateUtils {
  static String formatDate(DateTime date) => DateFormat('MMM d, yyyy').format(date);

  static String formatDateTime(DateTime date) => DateFormat('MMM d, yyyy • h:mm a').format(date);

  static String formatTime(DateTime date) => DateFormat('h:mm a').format(date);

  static String formatCurrency(double amount, {String symbol = '\$'}) =>
      NumberFormat.currency(symbol: symbol, decimalDigits: 2).format(amount);

  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays > 365) return '${(diff.inDays / 365).floor()}y ago';
    if (diff.inDays > 30) return '${(diff.inDays / 30).floor()}mo ago';
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }

  static String formatShortDate(DateTime date) => DateFormat('MMM d').format(date);

  static String formatMonthYear(DateTime date) => DateFormat('MMMM yyyy').format(date);
}
