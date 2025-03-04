import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/breakpoints.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  late TabController _tabController;
  String _searchWord = "";

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(
      () {
        setState(() {
          _searchWord = _textEditingController.value.text;
        });
      },
    );

    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );

    _tabController.addListener(
      () {
        if (_tabController.indexIsChanging) {
          setState(() {
            _onStopSearch();
          });
        }
      },
    );
  }

  void _onStopSearch() {
    FocusScope.of(context).unfocus();
  }

  void _onSearchSubmitted() {
    if (_searchWord != "") {
      print(_searchWord); // 검색시 수행
    }
  }

  void _onClearTap() {
    _textEditingController.clear();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          titleSpacing: Sizes.size4,
          title: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: TextField(
              controller: _textEditingController,
              textInputAction: TextInputAction.search,
              onEditingComplete: _onSearchSubmitted,
              decoration: InputDecoration(
                hintText: "Search for ...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Sizes.size8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: EdgeInsets.zero,
                icon: GestureDetector(
                  onTap: _onStopSearch,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Sizes.size10,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                    left: Sizes.size16,
                    right: Sizes.size10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (_searchWord.isNotEmpty)
                        GestureDetector(
                          onTap: _onClearTap,
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleXmark,
                            color: Colors.grey.shade600,
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // title: CupertinoSearchTextField(
          //   controller: _textEditingController,
          //   onChanged: _onSearchChanged,
          //   onSubmitted: _onSearchSubmitted,
          // ),
          actions: [
            IconButton(
              splashRadius: Sizes.size24,
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.sliders,
              ),
              tooltip: "Under Construction",
            )
          ],
          bottom: TabBar(
            controller: _tabController,
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            indicatorWeight: 3,
            labelStyle: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: 20,
              padding: EdgeInsets.all(
                Sizes.size6,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 20,
              ),
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) =>
                    Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.size4),
                      ),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/picture1.jpg",
                          image:
                              "https://images.unsplash.com/photo-1737143765999-bd3be790ab4f?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwyfHx8ZW58MHx8fHx8",
                          fit: BoxFit.cover,
                          placeholderFit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gaps.v10,
                    Text(
                      "${constraints.maxWidth} This is a very long caption for my tiktok that im upload just now currently.",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.v4,
                    if (constraints.maxWidth < 200 ||
                        constraints.maxWidth > 250)
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(
                                "https://avatars.githubusercontent.com/u/86183856?v=4",
                              ),
                            ),
                            Gaps.h4,
                            Expanded(
                              child: Text(
                                "My avatar is going to be very long.",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size16,
                              color: Colors.grey.shade600,
                            ),
                            Gaps.h2,
                            Text(
                              "2.5M",
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: TextStyle(
                    fontSize: Sizes.size28,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
