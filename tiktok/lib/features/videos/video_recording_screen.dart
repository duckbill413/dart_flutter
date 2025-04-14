import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/videos/video_preview_screen.dart';
import 'package:tiktok/features/videos/widgets/flash_mode_button.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  bool _appActivated = false;
  double _zoomLevel = 0.0;
  late double _minZoomLevel;
  late double _maxZoomLevel;
  late FlashMode _flashMode;
  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late CameraController _cameraController;
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(
      milliseconds: 300,
    ),
  );
  late final Animation<double> _recordBtnAnimation = Tween(
    begin: 1.0,
    end: 1.3,
  ).animate(_animationController);
  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }
    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    await _cameraController.prepareForVideoRecording(); // ios

    _appActivated = true;
    _flashMode = _cameraController.value.flashMode;
    await _setFlashMode(FlashMode.off);

    _minZoomLevel = await _cameraController.getMinZoomLevel();
    _maxZoomLevel = await _cameraController.getMaxZoomLevel();
    setState(() {});
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    if (newFlashMode == _flashMode) {
      newFlashMode = FlashMode.off;
    }

    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  void _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) {
      return;
    }

    await _cameraController.startVideoRecording();

    _progressAnimationController.forward();
    _animationController.forward();
  }

  void _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) {
      return;
    }
    _animationController.reverse();
    _progressAnimationController.reset();

    final file = await _cameraController.stopVideoRecording();

    // 줌 초기화
    _zoomLevel = _minZoomLevel;
    await _cameraController.setZoomLevel(_zoomLevel);
    setState(() {});

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: file,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      // source: ImageSource.camera,
      source: ImageSource.gallery,
    );
    if (video == null) return;
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  Future<void> _onZoomInOut(DragUpdateDetails details) async {
    var deltaDy = details.delta.dy;
    if (deltaDy > 0) {
      _zoomLevel =
          _zoomLevel <= _minZoomLevel ? _minZoomLevel : _zoomLevel - 0.05;
    } else if (deltaDy < 0) {
      _zoomLevel =
          _zoomLevel >= _maxZoomLevel ? _maxZoomLevel : _zoomLevel + 0.05;
    } else {
      return;
    }

    await _cameraController.setZoomLevel(_zoomLevel);
    setState(() {});
  }

  // From: nico
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (!_hasPermission) return;
  //   if (!_cameraController.value.isInitialized) return;
  //   if (state == AppLifecycleState.inactive) {
  //     _cameraController.dispose();
  //   } else if (state == AppLifecycleState.resumed) {
  //     initCamera();
  //   }
  // }

  @override
  Future didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_noCamera) return;
    if (!_cameraController.value.isInitialized) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _appActivated = true;
        await initPermissions();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _appActivated = false;
        setState(() {});
        // 위젯 트리에서 CameraPreview를 제거 후, dispose 해야한다.
        // setState와의 순서 중요
        _cameraController.dispose();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _animationController.dispose();

    if (_cameraController.value.isInitialized) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: !_hasPermission
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Initializing...",
                      style: TextStyle(
                          color: Colors.white, fontSize: Sizes.size20),
                    ),
                    Gaps.v20,
                    CircularProgressIndicator.adaptive()
                  ],
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_appActivated && !_noCamera)
                      Center(
                        child: CameraPreview(_cameraController),
                      ),
                    if (!_noCamera)
                      Positioned(
                        top: Sizes.size20,
                        right: Sizes.size20,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: _toggleSelfieMode,
                              color: Colors.white,
                              icon: Icon(
                                Icons.cameraswitch,
                              ),
                            ),
                            Gaps.v10,
                            FlashModeButton(
                              onPressed: _setFlashMode,
                              flashMode: _flashMode,
                              setFlashMode: FlashMode.off,
                              icon: Icons.flash_off_rounded,
                            ),
                            Gaps.v10,
                            FlashModeButton(
                              onPressed: _setFlashMode,
                              flashMode: _flashMode,
                              setFlashMode: FlashMode.always,
                              icon: Icons.flash_on_rounded,
                            ),
                            Gaps.v10,
                            FlashModeButton(
                              onPressed: _setFlashMode,
                              flashMode: _flashMode,
                              setFlashMode: FlashMode.auto,
                              icon: Icons.flash_auto_rounded,
                            ),
                            Gaps.v10,
                            FlashModeButton(
                              onPressed: _setFlashMode,
                              flashMode: _flashMode,
                              setFlashMode: FlashMode.torch,
                              icon: Icons.flashlight_on_rounded,
                            ),
                          ],
                        ),
                      ),
                    Positioned(
                      bottom: Sizes.size40,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTapDown: _startRecording,
                            onTapUp: (details) => _stopRecording(),
                            onPanUpdate: (details) => _onZoomInOut(details),
                            child: ScaleTransition(
                              scale: _recordBtnAnimation,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: Sizes.size64,
                                    height: Sizes.size64,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                  FadeTransition(
                                    opacity: _recordBtnAnimation,
                                    child: SizedBox(
                                      width: Sizes.size56,
                                      height: Sizes.size56,
                                      child: AnimatedBuilder(
                                        animation: _progressAnimationController,
                                        builder: (context, child) =>
                                            CircularProgressIndicator(
                                          value: _progressAnimationController
                                              .value,
                                          strokeWidth: Sizes.size5,
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: _onPickVideoPressed,
                                icon: FaIcon(
                                  FontAwesomeIcons.image,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
