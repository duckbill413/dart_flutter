import 'package:flutter/material.dart';

class TagsInput extends StatefulWidget {
  final List<String> initialTags;
  final Function(List<String>) onTagsChanged;

  const TagsInput({
    super.key,
    required this.initialTags,
    required this.onTagsChanged,
  });

  @override
  State<TagsInput> createState() => _TagsInputState();
}

class _TagsInputState extends State<TagsInput> {
  final TextEditingController _tagsTextController = TextEditingController();
  final List<String> _tags = [];

  @override
  void initState() {
    super.initState();
    _tags.addAll(widget.initialTags);
  }

  @override
  void dispose() {
    _tagsTextController.dispose();
    super.dispose();
  }

  void _addTag(String tag) {
    final trimmed = tag.trim();
    if (trimmed.isNotEmpty && !_tags.contains(trimmed)) {
      setState(() {
        _tags.add(trimmed);
        widget.onTagsChanged(_tags);
      });
    }
    _tagsTextController.clear();
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
      widget.onTagsChanged(_tags);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _tags.map((tag) {
            return InputChip(
              label: Text(tag),
              onDeleted: () => _removeTag(tag),
            );
          }).toList(),
        ),
        TextField(
          controller: _tagsTextController,
          decoration: InputDecoration(
            hintText: "태그 입력 후 Enter 또는 쉼표",
          ),
          onSubmitted: (value) {
            if (value.endsWith(',')) {
              _addTag(value.substring(0, value.length - 1));
            } else {
              _addTag(value);
            }
          },
          onChanged: (value) {
            if (value.endsWith(',')) {
              _addTag(value.substring(0, value.length - 1));
            }
          },
        )
      ],
    );
  }
}
