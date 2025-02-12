import 'package:drift/drift.dart';

class WeirdDate implements Comparable<WeirdDate> {
  WeirdDate(this.clientTimeStamp, this.serverTimeStamp);

  final String clientTimeStamp;
  final String? serverTimeStamp;

  static final zeroTime = DateTime.fromMillisecondsSinceEpoch(0)
      .toIso8601String();

  @override
  int compareTo(WeirdDate other) {
    if (serverTimeStamp != null && other.serverTimeStamp != null) {
      return serverTimeStamp!.compareTo(other.serverTimeStamp!);
    }

    if (serverTimeStamp != null) {
      return 1;
    }
    if (other.serverTimeStamp != null) {
      return -1;
    }

    return clientTimeStamp.compareTo(other.clientTimeStamp);
  }
}
