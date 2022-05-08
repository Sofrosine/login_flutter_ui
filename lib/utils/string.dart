class UtilsString {
  static String capitalizeEachWords(String sentences) {
    var string = sentences.split(" ").map((e) {
      return e[0].toUpperCase() + e.substring(1);
    }).toString();
    return string.substring(1, string.length - 1);
  }
}
