import 'dart:convert';

class StringBeautify {
  static String formatJSON(String jsonInput) {
    try {
      final jsonObject = jsonDecode(jsonInput);
      return const JsonEncoder.withIndent('  ').convert(jsonObject);
    } catch (e) {
      return 'Invalid JSON: $e';
    }
  }

  static const int kilobyte = 1000;
  static const int megabyte = kilobyte * 1000;
  static const int gigabyte = megabyte * 1000;

  static String formatStorageSize(int size) {
    if (size > gigabyte) {
      final val = size / gigabyte;
      return '${val.toStringAsFixed(2)} GB';
    }
    if (size > megabyte) {
      final val = size / megabyte;
      return '${val.toStringAsFixed(2)} MB';
    }
    if (size > kilobyte) {
      final val = size / kilobyte;
      return '${val.toStringAsFixed(2)} KB';
    }
    return '${size.toString()} B';
  }

  static String formatDateTimeElapsed(DateTime ts) {
    final now = DateTime.now();
    if (ts.isAfter(now)) {
      return 'N/A';
    }
    //
    final diff = now.difference(ts);
    final seconds = diff.inSeconds;
    if (seconds < 1) {
      return 'Less than a second';
    } else if (seconds == 1) {
      return '1 second';
    } else if (seconds < 60) {
      return '$seconds seconds';
    }
    //
    final minutes = diff.inMinutes;
    if (minutes == 1) {
      return 'About a minute';
    } else if (minutes < 60) {
      return '$minutes minutes';
    }
    //
    final hours = diff.inHours;
    if (hours == 1) {
      return 'About an hour';
    } else if (hours < 48) {
      return '$hours hours';
    } else if (hours < 24 * 7 * 2) {
      return '${hours ~/ 24} days';
    } else if (hours < 24 * 30 * 2) {
      return '${hours ~/ (24 * 7)} weeks';
    } else if (hours < 24 * 365 * 2) {
      return '${hours ~/ (24 * 30)} months';
    }
    return '${hours ~/ (24 * 365)} years';
  }

  static String formatTimestampElapsed(int timestamp) {
    final ts = DateTime.fromMillisecondsSinceEpoch(
        timestamp * Duration.millisecondsPerSecond);
    return formatDateTimeElapsed(ts);
  }
}
