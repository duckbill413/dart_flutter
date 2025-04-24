import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/playback_config_model.dart';
import 'package:tiktok/features/videos/repos/playback_config_repo.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(
      muted: value,
      autoplay: state.autoplay,
    );
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(
      muted: state.muted,
      autoplay: value,
    );
  }

  void toggleMute() {
    _repository.setMuted(!state.muted);
    state = PlaybackConfigModel(
      muted: !state.muted,
      autoplay: state.autoplay,
    );
  }

  void toggleAutoplay() {
    _repository.setAutoplay(!state.autoplay);
    state = PlaybackConfigModel(
      muted: state.muted,
      autoplay: !state.autoplay,
    );
  }

  /**
   * build 메서드는 화면이 보기를 원하는 데이터의 초기 상태를 반환
   */
  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);
