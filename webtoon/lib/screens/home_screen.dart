import 'package:flutter/material.dart';
import 'package:webtoon/services/api_service.dart';
import 'package:webtoon/widgets/webtoon_widget.dart';

import '../models/webtoon_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  Future<List<WebtoonModel>> webtoons = ApiService().getTodayToons();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // MEMO: ListView는 한번에 모든 데이터를 로드하기 때문에 효율적이지 않다.
            // MEMO: ListView.builder은 사용자가 데이터를 보고 있지 않으면 메모리에서 삭제한다.
            // MEMO: ListView.separated는 각 객체 사이를 구분할 위젯을 생성할 수 있다.
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        print("$index ${snapshot.data![index].thumb} 안녕!");
        var webtoon = snapshot.data![index];
        return Webtoon(webtoon: webtoon);
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
