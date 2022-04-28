import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/search_mode/search_mode_bloc.dart';
import 'bloc/view_mode/view_mode_bloc.dart';
import 'widgets/loading_item_card.dart';
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
                    BlocBuilder<SearchModeBloc, SearchModeState>(
                      builder: (context, state) {
                        return SearchModeRadioGroup(
                          selectedIndex: state.index,
                          onValueChange: (selectedIndex) {
                            context
                                .read<SearchModeBloc>()
                                .add(SwitchSearchMode(selectedIndex!));
                          },
                        );
                      },
                    ),
                    BlocBuilder<ViewModeBloc, ViewModeState>(
                      builder: (context, state) {
                        return ViewModeChoiceGroup(
                          selectedIndex: state.index,
                          onValueChange: (selectedIndex) {
                            context
                                .read<ViewModeBloc>()
                                .add(SwitchViewMode(selectedIndex));
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return const LoadingItemCard();
                },
                childCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
