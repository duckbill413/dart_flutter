import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/onboarding/tutorial_screen.dart';
import 'package:tiktok/features/onboarding/widgets/interest_button.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  // MEMO: ScrollController 와 Scrollbar 을 이용하여 화면에 스크롤바 생성
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  void _onScroll() {
    if (_scrollController.offset > 100) {
      if (_showTitle) return;
      setState(() {
        _showTitle = true;
      });
    } else {
      setState(() {
        _showTitle = false;
      });
    }
  }

  void _onNextTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TutorialScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: Duration(
            microseconds: 300,
          ),
          child: Text("Choose your interests"),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.only(
              left: Sizes.size24,
              right: Sizes.size24,
              bottom: Sizes.size16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose your interests",
                  style: TextStyle(
                    fontSize: Sizes.size40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v20,
                Text(
                  "Get better video recommendations",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                  ),
                ),
                Gaps.v60,
                Wrap(
                  runSpacing: 15,
                  spacing: 15,
                  children: [
                    // ListViewBuilder 로 최적화 가능
                    for (var interest in interests)
                      InterestButton(
                        interest: interest,
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: Sizes.size40,
            top: Sizes.size16,
            left: Sizes.size24,
            right: Sizes.size24,
          ),
          // MEMO: Cupertino button 으로 대체
          // child: Container(
          //   padding: EdgeInsets.symmetric(
          //     vertical: Sizes.size20,
          //   ),
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).primaryColor,
          //   ),
          //   child: Text(
          //     "Next",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: Sizes.size16,
          //       fontWeight: FontWeight.bold,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          // MEMO 종료
          // MEMO CupertinoButton 을 사용하여 TextButton 을 대체
          child: CupertinoButton(
            onPressed: _onNextTap,
            color: Theme.of(context).primaryColor,
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
