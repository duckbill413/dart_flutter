import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_gallery_saver/flutter_image_gallery_saver.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/features/users/view_models/upload_video_vm.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  final XFile video;
  final bool isPicked;

  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isPicked,
  });

  @override
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;
  bool _savedVideo = false;

  Future<String> convertTempFileToVideo(String tempFilePath) async {
    final tempFile = File(tempFilePath);
    final fileContent = await tempFile.readAsBytes();

    // 기존 파일 경로의 확장자 교체
    final newFilePath = tempFilePath.replaceFirst('.temp', '.mp4');
    final newFile = File(newFilePath);
    await newFile.writeAsBytes(fileContent);
    return newFilePath;
  }

  Future<void> initVideo() async {
    _videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.setVolume(0);
    // await _videoPlayerController.play();
    if (widget.isPicked) {
      _savedVideo = true;
    }
    setState(() {});
  }

  void _saveToGallery() async {
    if (_savedVideo) return;

    String newFilePath = widget.video.path;
    if (newFilePath.endsWith(".temp")) {
      newFilePath = await convertTempFileToVideo(newFilePath);
    }

    await FlutterImageGallerySaver.saveFile(
      newFilePath,
    );

    _savedVideo = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onUploadPressed() {
    ref.read(uploadVideoProvider.notifier).uploadVideo(
          File(widget.video.path),
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Preview video',
        ),
        actions: [
          // _savedVideo 가 false 이거나 widget.isPicked 가 false 일때
          if (!_savedVideo)
            IconButton(
              onPressed: _saveToGallery,
              icon: Icon(
                FontAwesomeIcons.download,
              ),
            ),
          IconButton(
            onPressed: ref.watch(uploadVideoProvider).isLoading
                ? () {}
                : _onUploadPressed,
            icon: ref.watch(uploadVideoProvider).isLoading
                ? CircularProgressIndicator()
                : FaIcon(FontAwesomeIcons.cloudArrowUp),
          )
        ],
      ),
      body: !_videoPlayerController.value.isInitialized
          ? null
          : VideoPlayer(
              _videoPlayerController,
            ),
    );
  }
}
