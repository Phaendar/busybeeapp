import 'package:shared_preferences/shared_preferences.dart';

export 'auth.dart';
export 'firestore.dart';
export 'models.dart';

Future<bool> checkIfLimitReached() async {
  final prefs = await SharedPreferences.getInstance();
  final int dailyLimit =
      prefs.getInt('daily_limit') ?? -1; //  -1 means 'Unlimited'
  final int currentUsage = prefs.getInt('daily_usage') ?? 0;

  // Convert daily limit to seconds for comparison, assuming it's stored in minutes
  final int dailyLimitInSeconds = dailyLimit * 60;

  // If the limit is 'Unlimited' or current usage is within the limit, return false
  if (dailyLimit == -1 || currentUsage < dailyLimitInSeconds) {
    return false;
  } else {
    // Limit reached
    return true;
  }
}
