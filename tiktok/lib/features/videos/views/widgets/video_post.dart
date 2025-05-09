import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/users/models/user_profile_model.dart';
import 'package:tiktok/features/users/view_models/users_vm.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok/features/videos/view_models/video_post_vm.dart';
import 'package:tiktok/features/videos/views/widgets/video_button.dart';
import 'package:tiktok/features/videos/views/widgets/video_comments.dart';
import 'package:tiktok/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final VideoModel video;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.video,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

/*
SingleTickerProviderMixin 은 Flutter에서 애니메이션을 다룰 때 사용하는 mixin 으로, AnimationController 를
생성할 때 필요한 TickerProvider 를 제공하기 위해 사용된다.

주요 특징
1. 싱글 Ticker
- SingleTickerProviderStateMixin 은 단일 애니메이션을 위한 Ticker 를 제공하며, 하나의 AnimationController 와 함께 사용됨
- 여러 애니메이션 컨트롤러가 필요한 경우 TickerProviderStateMixin 을 사용
2. 효율적인 리소스 관리
- Ticker 은 애니메이션을 매 프레임마다 갱신하도록 도와주는 객체로, 이를 제대로 관리하지 않은면 메모리 누수가 발생함
- SingleTickerProviderStateMixin은 사용이 끝난 Ticker 를 자동으로 정리하여 리소스를 효율적으로 관리

동작 방식
1. vsync: this 를 통해 Ticker가 State 객체와 동기화됨
  - vsync 는 애니메이션의 갱신을 화면의 프레임에 맞춰 효율적으로 처리하도록 함
2. SingleTickerProviderStateMixin은 애니메이션의 생명 주기를 자동으로 관리
 */
class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;
  late final AnimationController _animationController;
  late final Future<UserProfileModel> _videoOwner;
  late Future<bool> _isLiked;
  late int _likeCount = 0;

  bool _isPaused = false;
  final Duration _animationDuration = Duration(milliseconds: 200);
  bool _isTagExpanded = false;
  bool _isMute = false;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  /// 대부분의 웹 환경에서 음성이 있는 영상을 바로 재생시키려한다면 에러를 발생시킨다.
  /// 이유는, 음성이 갑작스럽게 나오는 것을 많은 광고 회사들이 남용했기 때문이다.
  void _initVideoPlayer() async {
    // _videoPlayerController =
    //     VideoPlayerController.asset("assets/videos/video1.MP4");
    _videoPlayerController =
        VideoPlayerController.network(widget.video.contentPath);
    await _videoPlayerController.initialize();

    setState(() {});
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0); // 웹인 경우 볼륨을 기본적으로 0으로 설정
      _isMute = true;
    }
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _videoOwner = loadVideoOwner();
    _isLiked =
        ref.read(videoPostProvider(widget.video.id).notifier).isLikedVideo();
    _likeCount = widget.video.likes;
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );

    _isMute = ref.read(playbackConfigProvider).muted;
    _isPaused = !ref.read(playbackConfigProvider).autoplay;
    if (_isMute) {
      _videoPlayerController.setVolume(0);
      setState(() {});
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<UserProfileModel> loadVideoOwner() async {
    return ref
        .read(usersProvider.notifier)
        .fetchProfile(widget.video.creatorUid);
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;
    final muted = ref.read(playbackConfigProvider).muted;
    setState(() {
      _isMute = muted;
    });
    if (muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    // visibility 에 변화가 있더라도 mount 된 상태가 아니면 아무것도 하지 않음
    if (!mounted) return;
    // visibleFaction 은 현재 위젯이 화면에 보이는 정도
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      if (ref.read(playbackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
      if (ref.read(playbackConfigProvider).muted) {
        _videoPlayerController.setVolume(0);
      }
    }

    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onMuteTap() async {
    _isMute = !_isMute;
    if (_isMute) {
      await _videoPlayerController.setVolume(0);
    } else {
      await _videoPlayerController.setVolume(1);
    }
    setState(() {});
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }

    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onToggleTag() {
    setState(() {
      _isTagExpanded = !_isTagExpanded;
    });
  }

  Future<void> _onLikeTap() async {
    final wasLiked = await _isLiked;
    ref.read(videoPostProvider(widget.video.id).notifier).likeVideo();

    setState(() {
      _isLiked = Future.value(!wasLiked);
      _likeCount += wasLiked ? -1 : 1;
    });
  }

  void _onCommentTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 내부에서 ListView를 사용할 경우 true로 변경
      builder: (context) => VideoComments(),
      backgroundColor: Colors.transparent,
    );
    _onTogglePause();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(playbackConfigProvider, (previous, next) {
      _onPlaybackConfigChanged();
    });
    return VisibilityDetector(
      key: Key(widget.video.id),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Image.network(
                    widget.video.thumbnailPath,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animationController.value,
                    child: child,
                  );
                },
                child: Transform.scale(
                  scale: _animationController.value,
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 0.8 : 0,
                    duration: _animationDuration,
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.play,
                        color: Colors.white,
                        size: Sizes.size52,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: Opacity(
              opacity: 0,
              child: IconButton(
                onPressed: () =>
                    ref.read(playbackConfigProvider.notifier).toggleMute(),
                icon: FaIcon(
                  ref.watch(playbackConfigProvider).muted
                      ? FontAwesomeIcons.volumeOff
                      : FontAwesomeIcons.volumeHigh,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.video.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Text(
                  widget.video.description,
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.white,
                  ),
                ),
                Gaps.v5,
                GestureDetector(
                  onTap: _onToggleTag,
                  child: Row(
                    children: [
                      SizedBox(
                        width: _isTagExpanded ? 300 : 200,
                        child: Text(
                          overflow: _isTagExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          widget.video.tags
                              .map((e) => '#$e')
                              .toList()
                              .join(' '),
                          style: const TextStyle(
                            fontSize: Sizes.size14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !_isTagExpanded,
                        child: const Text(
                          "See more",
                          style: TextStyle(
                            fontSize: Sizes.size14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    return CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      foregroundImage: NetworkImage(snapshot.data!.avatarLink ??
                          'https://w7.pngwing.com/pngs/551/755/png-transparent-sample-stamp.png'),
                      child: Text(
                        snapshot.data!.username,
                        style: TextStyle(
                          fontSize: Sizes.size10,
                        ),
                      ),
                    );
                  },
                  future: _videoOwner,
                ),
                Gaps.v28,
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return GestureDetector(
                        onTap: _onLikeTap,
                        child: VideoButton(
                          icon: Icon(
                            FontAwesomeIcons.solidHeart,
                            color: Colors.white,
                            size: Sizes.size40,
                          ),
                          text: S.of(context).likeCount(_likeCount),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: _onLikeTap,
                      child: VideoButton(
                        icon: Icon(
                          FontAwesomeIcons.solidHeart,
                          color: snapshot.data! ? Colors.red : Colors.white,
                          size: Sizes.size40,
                        ),
                        text: S.of(context).likeCount(_likeCount),
                      ),
                    );
                  },
                  future: _isLiked,
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: () => _onCommentTap(context),
                  child: VideoButton(
                    icon: Icon(
                      FontAwesomeIcons.solidComment,
                      color: Colors.white,
                      size: Sizes.size40,
                    ),
                    text: S.of(context).commentCount(widget.video.comments),
                  ),
                ),
                Gaps.v28,
                VideoButton(
                  icon: Icon(
                    FontAwesomeIcons.share,
                    color: Colors.white,
                    size: Sizes.size40,
                  ),
                  text: "Share",
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 50,
            child: AnimatedOpacity(
              opacity: _isMute ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: IgnorePointer(
                // 안 보일 때 클릭 방지
                ignoring: !_isMute,
                child: IconButton(
                  onPressed: _onMuteTap,
                  icon: FaIcon(
                    FontAwesomeIcons.volumeHigh,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
