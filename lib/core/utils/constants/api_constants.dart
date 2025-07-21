class ApiConstants {
  static const String baseUrl = 'https://your-api.com';
  static const String getMovies = '$baseUrl/movie/';


  static String getmovieDetailsUrl(String movieId) => '$baseUrl/movie/$movieId';
}