extension CapitalizeExtension on String {
  String capitalize() {
    List<String> words =
        split(RegExp(r'\s+')); // Splitting by one or more spaces

    return words
        .map((word) =>
                '${word[0].toUpperCase()}${word.substring(1)}' // Capitalize the first letter of each word
            )
        .join(
            ' '); // Join the words back together with a single space between each word
  }
}
