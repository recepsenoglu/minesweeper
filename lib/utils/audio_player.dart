import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:minesweeper/constants/audio_enums.dart';

class GameAudioPlayer {
  static late AudioPlayer _player;

  GameAudioPlayer() {
    _player = AudioPlayer();
  }

  static void dispose() {
    _player.dispose();
  }

  static void pause() {
    _player.pause();
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
    if (await _setAudio(audio.toPath)) {
      if (loop) {
        _player.setLoopMode(LoopMode.one);
      }
      _player.play();
    }
  }
}
