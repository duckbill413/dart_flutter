import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/common/theme_config/view_models/theme_config_vm.dart';
import 'package:tiktok/constants/sizes.dart';

class InterestButton extends ConsumerStatefulWidget {
  final String interest;

  const InterestButton({
    super.key,
    required this.interest,
  });

  @override
  InterestButtonState createState() => InterestButtonState();
}

class InterestButtonState extends ConsumerState<InterestButton> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size24,
        ),
        decoration: BoxDecoration(
          color: _isSelected
              ? Theme.of(context).primaryColor
              : ref.watch(themeConfigProvider).isDark
                  ? Colors.grey.shade700
                  : Colors.white,
          borderRadius: BorderRadius.circular(
            Sizes.size32,
          ),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.05,
              ),
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],
        ),
        duration: Duration(milliseconds: 300),
        child: Text(
          widget.interest,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
