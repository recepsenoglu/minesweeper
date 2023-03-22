import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../constants/audio_enums.dart';

class GameAudioPlayer {
  static late AudioPlayer _player;
  static bool playable = true;

  GameAudioPlayer() {
    _player = AudioPlayer();
    _player.play();
  }

  static void resetPlayer() {
    _player.dispose();
    _player = AudioPlayer();
  }

  static void pause() {
    playable = false;
    _player.pause();
  }

  static void resume() {
    playable = true;
    try {
      _player.play();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> setVolume(bool soundOn) async {
    await _player.setVolume(soundOn ? 1 : 0);
  }

  Future<bool> _setAudio(String audioPath) async {
    try {
      await _player.setAudioSource(
        AudioSource.asset(audioPath),
      );
      _player.setLoopMode(LoopMode.off);
      return true;
    } catch (e) {
      debugPrint("Error loading audio source: $e");
    }
    return false;
  }

  Future<void> playAudio(Audio audio, {bool loop = false}) async {
    if (await _setAudio(audio.toPath) && playable) {
      if (loop) {
        _player.setLoopMode(LoopMode.one);
      }
      _player.play();
    }
  }
}
