class ApiUrl {
  static const String baseUrl = 'https://responsi1a.dalhaqq.xyz';

  static const String listIkan = '$baseUrl/ikan';
  static const String createIkan = '$baseUrl/ikan';

  static String updateIkan(String id) {
    return '$baseUrl/ikan/$id';
  }

  static String showIkan(String id) {
    return '$baseUrl/ikan/$id';
  }

  static String deleteIkan(String id) {
    return '$baseUrl/ikan/$id';
  }
}
