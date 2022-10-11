// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeatherExeption implements Exception {
  String message;

  WeatherExeption([this.message = 'Something went wrong!']) {
    message = 'Weather Exeption $message';
  }

  @override
  String toString() => 'WeatherExeption(message: $message)';
}
