import 'package:youtube_player_flutter/youtube_player_flutter.dart';

String? getVideoId(String url) {
  if (url.contains('youtube.com/shorts')) {
    return url.split('shorts/')[1].split('?')[0];
  }
  if (url.contains('youtube.com/watch')) {
    return url.split('v=')[1].split('&')[0];
  }
  if (url.contains('youtu.be/')) {
    return url.split('youtu.be/')[1].split('?')[0];
  }
  return null;
}

YoutubePlayerController createController(
  String videoId, {
  bool autoPlay = true,
  bool mute = false,
  bool loop = true,
}) {
  return YoutubePlayerController(
    initialVideoId: videoId,
    flags: YoutubePlayerFlags(
      autoPlay: autoPlay,
      mute: mute,
      loop: loop,
    ),
  );
}
