//2023-01-12T04:20:24.551Z

import 'package:flutter/material.dart';
import 'package:new_spark/widgets/custom_snackbar.dart';

const UTCSri_Lanka = 5.30;

class TimeAgo {
  findTimeZone(BuildContext context) {
    try {
      return DateTime.now().timeZoneName;
    } catch (e) {
      showErrorSnackbar(context, 'Failed getting current time');
    }
  }

  utcToLocal(BuildContext context) {
    try {
      final utcTime = DateTime.utc(2023, 1, 12, 04, 20, 24);
      final localTime = utcTime.toLocal();
      return localTime;
    } catch (e) {
      showErrorSnackbar(context, 'Failed converting to local time');
    }
  }

  String convertToAgo(DateTime input, BuildContext context) {
    try {
      Duration diff = DateTime.now().difference(input);

      if (diff.inDays >= 365) {
        return '${(diff.inDays / 365).toStringAsFixed(0)} years(s) ago';
      } else if (diff.inDays >= 30) {
        return '${(diff.inDays / 30).toStringAsFixed(0)} month(s) ago';
      } else if (diff.inDays >= 1) {
        return '${diff.inDays} day(s) ago';
      } else if (diff.inHours >= 1) {
        return '${diff.inHours} hour(s) ago';
      } else if (diff.inMinutes >= 1) {
        return '${diff.inMinutes} minute(s) ago';
      } else if (diff.inSeconds >= 1) {
        return '${diff.inSeconds} second(s) ago';
      } else {
        return 'just now';
      }
    } catch (e) {
      showErrorSnackbar(context, 'Failed to read timeAgo service');
      return '';
    }
  }
}
