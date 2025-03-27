import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
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
    with TickerProviderStateMixin {
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  late FlashMode _flashMode;

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
      cameras[_isSelfieMode ? 0 : 1],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    await _cameraController.prepareForVideoRecording(); // ios

    _flashMode = _cameraController.value.flashMode;
    await _setFlashMode(FlashMode.off);
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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: file,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
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
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: !_hasPermission || !_cameraController.value.isInitialized
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
                    CameraPreview(_cameraController),
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
                      child: GestureDetector(
                        onTapDown: _startRecording,
                        onTapUp: (details) => _stopRecording(),
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
                                      value: _progressAnimationController.value,
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
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
