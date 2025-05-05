import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';
import 'package:tiktok/features/users/view_models/upload_video_vm.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/views/widgets/tags_input.dart';
import 'package:uuid/uuid.dart';

class UploadVideoDetailScreen extends ConsumerStatefulWidget {
  final String creatorUid;
  final String creator;
  final TaskSnapshot snapshot;

  const UploadVideoDetailScreen({
    super.key,
    required this.creatorUid,
    required this.creator,
    required this.snapshot,
  });

  @override
  UploadVideoDetailScreenState createState() => UploadVideoDetailScreenState();
}

class UploadVideoDetailScreenState
    extends ConsumerState<UploadVideoDetailScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String title = '';
  String description = '';
  List<String> tags = [];
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(
      () => setState(() {}),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> uploadVideoDone() async {
    setState(() => _isUploading = true);
    try {
      final videoModel = VideoModel(
        id: Uuid().v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        contentPath: await widget.snapshot.ref.getDownloadURL(),
        thumbnailPath: await widget.snapshot.ref.getDownloadURL(),
        likes: 0,
        comments: 0,
        tags: tags,
        creatorUid: widget.creatorUid,
        createdAt: widget.snapshot.metadata!.timeCreated ?? DateTime.now(),
        creator: widget.creator,
      );
      await ref.read(uploadVideoProvider.notifier).saveVideoDescription(
            context: context,
            videoModel: videoModel,
          );
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => context.go("/home"),
          child: Text("취소"),
        ),
        title: Text("업로드 비디오 설명"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.size24,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v20,
                  Text(
                    "영상 제목",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: Sizes.size16,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 60),
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: "제목",
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Gaps.v8,
                  Text(
                    "영상 설명",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: Sizes.size16,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 120),
                    child: TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: "설명",
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Gaps.v8,
                  Text(
                    "태그",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: Sizes.size16,
                    ),
                  ),
                  TagsInput(
                    initialTags: [],
                    onTagsChanged: (tags) => this.tags = tags,
                  ),
                  Gaps.v28,
                  FormButton(
                    onTap: () => uploadVideoDone(),
                    disabled: _titleController.text.isEmpty,
                    text: "영상 업로드",
                  ),
                ],
              ),
              if (_isUploading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black54, // 어두운 반투명 배경
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator.adaptive(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
