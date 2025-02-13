import 'package:backend/client_definitions.dart';

class WeirdDate
    with CompareOperators<WeirdDate>
    implements Comparable<WeirdDate> {
  WeirdDate(this.clientTimeStamp, this.serverTimeStamp);

  WeirdDate.fromEvent(Event event):
   clientTimeStamp = event.clientTimeStamp,
   serverTimeStamp = event.serverTimeStamp;

  WeirdDate.fromNode(Node node):
        clientTimeStamp = node.clientTimeStamp,
        serverTimeStamp = node.serverTimeStamp;

  final String clientTimeStamp;
  final String? serverTimeStamp;

  static final zeroTime =
      DateTime.fromMillisecondsSinceEpoch(0).toIso8601String();

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

mixin CompareOperators<T> implements Comparable<T> {
  bool operator <(T other) => compareTo(other) < 0;
  bool operator <=(T other) => compareTo(other) <= 0;
  bool operator >=(T other) => compareTo(other) >= 0;
  bool operator >(T other) => compareTo(other) > 0;
}
