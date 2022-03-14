import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:news_project/logic/filter_bloc/filter_bloc.dart';
import 'package:news_project/logic/internet/connectioncheck_cubit.dart';
import 'package:news_project/logic/internet/internet_state.dart';
import 'package:news_project/logic/news_bloc/news_bloc.dart';
import 'package:news_project/models/news_model.dart';
import 'package:news_project/utils/api.dart';
import 'package:news_project/utils/const.dart';
import 'package:news_project/widgets/news_card.dart';
import 'package:news_project/widgets/no_data_widget.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  List<NewsModel> newsList = [];
  bool _isSearch = false;
  String initialDropValue = 'Newest';
  var items = [
    'Popular',
    'Newest',
    'Oldest',
  ];
  @override
  void initState() {
    BlocProvider.of<NewsBloc>(context).add(const FetchNews());
    super.initState();
  }

  String? countryName = 'India';
  String countryCode = 'IN';

  selectCountry({BuildContext? ctx}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Choose your loction',
                      style: TextStyle(
                          fontFamily: 'helve',
                          color: Colors.black,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.black54,
                    ),
                    Column(
                      children: List.generate(
                        Api().code.length,
                        (index) => RadioListTile(
                          dense: true,
                          value: value,
                          title: Text(
                            Api().country[index]!,
                            style: const TextStyle(
                                fontFamily: 'helve',
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          onChanged: (val) {
                            BlocProvider.of<NewsBloc>(ctx!)
                                .add(FetchNews(country: Api().code[index]));
                            setState(() {
                              countryName = Api().country[index]!;
                            });
                            Navigator.pop(context);
                          },
                          groupValue: Api().code,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Const.color,
        title: const Text('My News'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: BlocProvider<NewsBloc>(
              create: (context) => NewsBloc(),
              child: GestureDetector(
                onTap: () {
                  selectCountry(ctx: context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'LOCATION',
                      style: TextStyle(
                          fontFamily: 'helve',
                          color: Colors.white,
                          //fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 18,
                        ),
                        Text(
                          countryName! == null ? '' : countryName!,
                          style: const TextStyle(
                              fontFamily: 'helve',
                              color: Colors.white,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Const.color,
        child: const Icon(Icons.filter_alt_outlined),
        onPressed: () => FilterBottom(
            country: countryCode != null ? countryCode : 'IN', ctx: context),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextField(
              controller: search,
              decoration: InputDecoration(
                suffixIcon: _isSearch
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_isSearch) {
                              _isSearch = false;
                              search.clear();

                              FocusScope.of(context).unfocus();
                              BlocProvider.of<NewsBloc>(context)
                                  .add(const FetchNews());
                            }
                          });
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      )
                    : const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Search for news, topics..',
                fillColor: Colors.grey[200],
                filled: true,
              ),
              onChanged: (val) {
                if (val.isNotEmpty) {
                  BlocProvider.of<NewsBloc>(context)
                      .add(FetchSearch(search: val));
                }
                setState(() {
                  if (val.isEmpty) {
                    _isSearch = false;
                    BlocProvider.of<NewsBloc>(context).add(const FetchNews());
                  } else {
                    _isSearch = true;
                  }
                });
              },
              onSubmitted: (val) {},
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Top Headlines',
                  style: TextStyle(
                    fontFamily: 'helve',
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Sort:',
                    style: TextStyle(
                      fontFamily: 'helve',
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  DropdownButton(
                    value: initialDropValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        initialDropValue = newValue!;
                      });
                      if (initialDropValue.contains('Popular')) {
                        BlocProvider.of<NewsBloc>(context).add(
                            const FetchSorting(
                                sort: 'country=in&sortBy=popularity'));
                      } else if (initialDropValue.contains('Newest')) {
                        BlocProvider.of<NewsBloc>(context)
                            .add(const FetchNews());
                      } else if (initialDropValue.contains('Oldest')) {
                        BlocProvider.of<NewsBloc>(context).add(const FetchSorting(
                            sort:
                                'country=in&from=2022-02-15&to=2022-03-13&sortBy=popularity'));
                      }
                    },
                    style: const TextStyle(
                        fontFamily: 'helve', fontSize: 12, color: Colors.black),
                    isDense: true,
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: BlocListener<NewsBloc, NewsState>(
              listener: (context, state) {
                if (state is NewsError) {
                  Center(
                    child: Text(state.message.toString(),
                        style: const TextStyle(
                            fontFamily: 'helve',
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  );
                }
              },
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  final connectionState =
                      context.watch<ConnectionCheckerCubit>().state;
                  if (connectionState is InternetConnectionDisconnected) {
                    return nodata();
                  } else {
                    if (state is FilterFetchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is FilterFetchLoaded) {
                      print('state is FilterFetchLoaded');
                      return CustomScrollView(
                        shrinkWrap: true,
                        slivers: [
                          SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                            Article news = state.model.articles[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: NewsCard(
                                news: news,
                              ),
                            );
                          }, childCount: state.model.articles.length)),
                        ],
                      );
                    }
                    if (state is Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is Loaded) {
                      var data = state.model.articles;
                      return CustomScrollView(shrinkWrap: true, slivers: [
                        SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                          Article news = data[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: NewsCard(
                              news: news,
                            ),
                          );
                        }, childCount: data.length))
                      ]);
                    } else if (state is SearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SearchLoaded) {
                      return CustomScrollView(
                        shrinkWrap: true,
                        slivers: [
                          SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                            Article news = state.model.articles[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: NewsCard(
                                news: news,
                              ),
                            );
                          }, childCount: state.model.articles.length)),
                        ],
                      );
                    } else if (state is SortLoaded) {
                      return CustomScrollView(
                        shrinkWrap: true,
                        slivers: [
                          SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                            Article news = state.model.articles[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: NewsCard(
                                news: news,
                              ),
                            );
                          }, childCount: state.model.articles.length)),
                        ],
                      );
                    }
                    return const Center(
                        child: Text(
                      'Something Wrong!',
                      style: TextStyle(
                          fontFamily: 'helve',
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool value = false;
  List selectSource = [];
  FilterBottom({String? country, BuildContext? ctx}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocProvider<FilterBloc>(
            create: (context) => FilterBloc()..add(FetchFilter(country: 'IN')),
            child: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: BlocBuilder<FilterBloc, FilterState>(
                builder: (context, state) {
                  if (state is FilterLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FilterLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 3,
                            width: 40,
                            color: Colors.black38,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Filter by sources',
                          style: TextStyle(
                              fontFamily: 'helve',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.black38,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: CheckboxGroup(
                                labels: List.generate(
                                    state.model.sources.length,
                                    (index) => state.model.sources[index].id),
                                onSelected: (List<String> checked) {
                                  selectSource = checked;
                                  print(checked);
                                })),
                        Center(
                          child: FlatButton(
                              color: const Color(0xff0c56BE),
                              onPressed: () {
                                var data = selectSource
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', '')
                                    .toString();
                                BlocProvider.of<NewsBloc>(ctx!).add(
                                    FetchFiltered(search: data.toString()));
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Apply Filter',
                                style: TextStyle(
                                    fontFamily: 'helve',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                        )
                      ],
                    );
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/no-results.png',
                            fit: BoxFit.cover, height: 150, width: 150),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'No result found!',
                          style: TextStyle(
                              fontFamily: 'helve',
                              fontSize: 14,
                              color: Colors.black38),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}