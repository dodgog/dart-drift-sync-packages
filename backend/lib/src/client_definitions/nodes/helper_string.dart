// AIUSE help used
extension StringIterableExtension on Iterable<String> {
  String maxString() {
    if (isEmpty) {
      throw StateError('Cannot find maximum of empty iterable');
    }

    return reduce(
        (current, next) => next.compareTo(current) > 0 ? next : current);
  }

  String? maxStringOrNull() {
    if (isEmpty) {
      return null;
    }

    return reduce(
        (current, next) => next.compareTo(current) > 0 ? next : current);
  }
}
