import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/search/search_bloc.dart';
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
    TextEditingController _searchInput = TextEditingController();

    var searchBloc = context.read<SearchBloc>();
    var searchModeBloc = context.read<SearchModeBloc>();
    var viewModeBloc = context.read<ViewModeBloc>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: _primaryColor,
            title: SafeArea(
              child: TextField(
                controller: _searchInput,
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
                    context.read<SearchBloc>().add(LoadData(value, page: 1));
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
                            searchModeBloc
                                .add(SwitchSearchMode(selectedIndex!));
                            searchBloc.add(SetSearchMode(selectedIndex));
                            if (_searchInput.text.isNotEmpty) {
                              searchBloc.add(LoadData(_searchInput.text));
                            }
                          },
                        );
                      },
                    ),
                    BlocBuilder<ViewModeBloc, ViewModeState>(
                      builder: (context, state) {
                        return ViewModeChoiceGroup(
                          selectedIndex: state.index,
                          onValueChange: (selectedIndex) {
                            viewModeBloc.add(SwitchViewMode(selectedIndex));
                            searchBloc.add(SetViewMode(selectedIndex));
                            if (_searchInput.text.isNotEmpty) {
                              searchBloc.add(LoadData(_searchInput.text));
                            }
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
              sliver: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return const LoadingItemCard();
                        },
                        childCount: 5,
                      ),
                    );
                  } else if (state is SearchResult) {
                    return const SliverToBoxAdapter(
                      child: Text("Result"),
                    );
                  } else {
                    return const SliverToBoxAdapter(
                      child: Text("unknown"),
                    );
                  }
                },
              )),
        ],
      ),
    );
  }
}
