import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entity/issue.dart';
import '../domain/entity/repository.dart';
import '../domain/entity/user.dart';
import 'bloc/search/search_bloc.dart';
import 'bloc/search_mode/search_mode_bloc.dart';
import 'bloc/view_mode/view_mode_bloc.dart';
import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final _primaryColor = Theme.of(context).colorScheme.primary;
    TextEditingController _searchInput = TextEditingController();
    ScrollController _scrollController = ScrollController();
    var _focusSearch = FocusNode();

    var _searchBloc = context.read<SearchBloc>();
    var _searchModeBloc = context.read<SearchModeBloc>();
    var _viewModeBloc = context.read<ViewModeBloc>();

    String _query = '';
    _searchInput.text = _query;

    void onScroll() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;

      var searchState = _searchBloc.state;

      if (searchState is SearchResult &&
          _viewModeBloc.state is ViewModeLazyLoading) {
        _query = searchState.query;
        bool isNotLast = searchState.maxPage != searchState.page;
        if (currentScroll == maxScroll && isNotLast) {
          _searchBloc.add(LoadData(_query, page: searchState.page + 1));
        }
      }
    }

    _scrollController.addListener(onScroll);

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: _primaryColor,
            title: SafeArea(
              child: BlocSelector<SearchBloc, SearchState, String>(
                selector: (state) {
                  return state is SearchResult ? state.query : _query;
                },
                builder: (context, state) {
                  _searchInput.text = state;
                  return TextField(
                    focusNode: _focusSearch,
                    controller: _searchInput,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: "Search",
                      contentPadding: const EdgeInsets.all(8),
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.search),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _searchInput.clear();
                          _searchBloc.add(Reset());
                          _focusSearch.requestFocus();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(Icons.clear),
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        maxHeight: 24,
                        maxWidth: 24,
                      ),
                      suffixIconConstraints: const BoxConstraints(
                        maxHeight: 24,
                        maxWidth: 24,
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        debugPrint("Searching $value ....");
                        _query = value;
                        _searchBloc.add(Reset());
                        _searchBloc.add(LoadData(value, page: 1));
                      } else {
                        _searchBloc.add(Reset());
                      }
                    },
                  );
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
                            _searchModeBloc
                                .add(SwitchSearchMode(selectedIndex!));
                            _searchBloc.add(Reset());
                            _searchBloc.add(SetSearchMode(selectedIndex));
                            if (_searchInput.text.isNotEmpty) {
                              _searchBloc.add(LoadData(_searchInput.text));
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
                            _viewModeBloc.add(SwitchViewMode(selectedIndex));
                            _searchBloc.add(Reset());
                            _searchBloc.add(SetViewMode(selectedIndex));
                            if (_searchInput.text.isNotEmpty) {
                              _searchBloc.add(LoadData(_searchInput.text));
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
                      childCount: 10,
                    ),
                  );
                } else if (state is SearchResult) {
                  SearchResult _s = state;
                  if (_s.data.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: NoDataWidget(),
                    );
                  }

                  bool isLazyLoad = _viewModeBloc.state is ViewModeLazyLoading;
                  bool isNotLast = state.page != state.maxPage;

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (index >= _s.data.length) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        switch (_s.data.runtimeType) {
                          case List<User>:
                            return UserItemCard(user: _s.data[index]);
                          case List<Issue>:
                            return IssueItemCard(issue: _s.data[index]);
                          case List<Repository>:
                            return RepositoryItemCard(
                                repository: _s.data[index]);
                          default:
                            return const LoadingItemCard();
                        }
                      },
                      childCount: isLazyLoad && isNotLast
                          ? _s.data.length + 1
                          : _s.data.length,
                    ),
                  );
                } else if (state is Error) {
                  return SliverToBoxAdapter(
                    child: FailureWidget(message: state.failure.message),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: InitialView(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchResult &&
              state.data.isNotEmpty &&
              _viewModeBloc.state is ViewModeWithIndex) {
            return PageWidget(
              page: state.page,
              maxPage: state.maxPage,
              previous: (page) {
                String savedQuery = (_searchBloc.state as SearchResult).query;
                _searchBloc.add(LoadData(
                  _query.isNotEmpty ? _query : savedQuery,
                  page: page,
                ));
              },
              next: (page) {
                String savedQuery = (_searchBloc.state as SearchResult).query;
                _searchBloc.add(LoadData(
                  _query.isNotEmpty ? _query : savedQuery,
                  page: page,
                ));
              },
            );
          }
          return const SizedBox(height: 0, width: 0);
        },
      ),
    );
  }
}
