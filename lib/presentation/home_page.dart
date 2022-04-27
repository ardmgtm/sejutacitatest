import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final _primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: _primaryColor,
            title: SafeArea(
              child: TextField(
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  hintText: "Search",
                  contentPadding: EdgeInsets.all(8),
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.search),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 24,
                    maxWidth: 24,
                  ),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    debugPrint("Searching $value ....");
                  }
                },
              ),
            ),
          ),
          SliverAppBar(
            elevation: 0,
            backgroundColor: _primaryColor,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchModeRadioGroup(
                      selectedIndex: 0,
                      onValueChange: (selectedIndex) {},
                    ),
                    ViewModeChoiceGroup(
                      selectedIndex: 0,
                      onValueChange: (selectedIndex) {},
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            pinned: true,
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.grey[200],
                  child: Text('list item $index'),
                );
              },
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}
