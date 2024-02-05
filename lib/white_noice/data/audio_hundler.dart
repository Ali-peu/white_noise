// import 'package:audio_service/audio_service.dart';
// import 'package:audioplayers/audioplayers.dart';

// class MyAudioHandler extends BaseAudioHandler
//     with
//         QueueHandler, // mix in default queue callback implementations
//         SeekHandler {
//   // mix in default seek callback implementations

//   // The most common callbacks:]

//   final player = AudioPlayer();
//   @override
//   Future<void> play() async {
//     // All 'play' requests from all origins route to here. Implement this
//     // callback to start playing audio appropriate to your app. e.g. music.

//     playbackState.add(PlaybackState(
//       // Which buttons should appear in the notification now
//       controls: [
//         MediaControl.skipToPrevious,
//         MediaControl.pause,
//         MediaControl.stop,
//         MediaControl.skipToNext,
//       ],
//       // Which other actions should be enabled in the notification
//       systemActions: const {
//         MediaAction.seek,
//         MediaAction.seekForward,
//         MediaAction.seekBackward,
//       },
//       // Which controls to show in Android's compact view.
//       androidCompactActionIndices: const [0, 1, 3],
//       // Whether audio is ready, buffering, ...
//       processingState: AudioProcessingState.ready,
//       // Whether audio is playing
//       playing: true,
//       // The current position as of this update. You should not broadcast
//       // position changes continuously because listeners will be able to
//       // project the current position after any elapsed time based on the
//       // current speed and whether audio is playing and ready. Instead, only
//       // broadcast position updates when they are different from expected (e.g.
//       // buffering, or seeking).
//       updatePosition: Duration(milliseconds: 54321),
//       // The current buffered position as of this update
//       bufferedPosition: Duration(milliseconds: 65432),
//       // The current speed
//       speed: 1.0,
//       // The current queue position
//       queueIndex: 0,
//     ));
//   }

//   @override
//   Future<void> pause() async {}
//   @override
//   Future<void> stop() async {}
//   @override
//   Future<void> seek(Duration position) async {}
//   @override
//   Future<void> skipToQueueItem(int i) async {}
// }
