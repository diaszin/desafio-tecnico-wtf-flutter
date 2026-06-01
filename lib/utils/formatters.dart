class Formatters {
  static String formatMovieRunTime(int runtime) {
    Duration duration = Duration(minutes: runtime);

    String hour = duration.inHours.toString();
    String minutes = duration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    String formattedMovieTime = '${hour}h ${minutes}m';

    return formattedMovieTime;
  }

  static String formatMoney(num value) {
    if (value == 0) {
      return "Não divulgado";
    }
    if (value >= 1e9) {
      return 'US\$ ${(value / 1e9).toStringAsFixed(1)} bilhões';
    }

    if (value >= 1e6) {
      return 'US\$ ${(value / 1e6).toStringAsFixed(1)} milhões';
    }

    return 'US\$ ${value.toInt()}';
  }
}