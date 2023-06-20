import 'package:flutter/material.dart';
import 'package:medeasy/screens/screens.dart';
import 'package:medeasy/widgets/widgets.dart';

import '../configs/constants.dart';
import '../model/models.dart';
import 'package:get/get.dart';
import 'package:medeasy/controllers/controllers.dart';
import 'package:searchfield/searchfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userCon = Get.put(UserController());
  final FireStoreController fireCon = Get.put(FireStoreController());
  final StorageController storeCon = Get.put(StorageController());
  List<Specialist> specialists = [];
  List<Specialist> filtered = [];

  bool loading = true;

  TextEditingController searchCon = TextEditingController();

  featuredSpecialist() async {
    final resp = await fireCon.getSpecialists();
    setState(() {
      specialists = resp!;
      filtered = specialists;
      loading = false;
    });
  }

  @override
  void initState() {
    featuredSpecialist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            elevation: 1,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {
                  if (userCon.user() == null) {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const Authentications(),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const Account(),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.account_circle_rounded,
                    color: Colors.black, size: 36),
              ),
            ],
            title: const Text(
              'Medeasy',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(
                screen.width,
                screen.height * .1,
              ),
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const MapView(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.location_on_rounded),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x22000000),
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                      width: screen.width * .7,
                      child: SearchField<String>(
                        suggestions: suggestionSpecialists.map((e) {
                          return SearchFieldListItem<String>(e,
                              item: e,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  e,
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                              ));
                        }).toList(),
                        controller: searchCon,
                        searchInputDecoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(fontSize: 17),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.only(left: 10, top: 15),
                          suffixIcon: Container(
                            width: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0FA984),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            child: const Center(child: Icon(Icons.search)),
                          ),
                        ),
                        suggestionsDecoration: SuggestionDecoration(
                          padding: const EdgeInsets.all(5),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x22000000),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: Offset(2, 2),
                            )
                          ],
                        ),
                        onSubmit: (text) {
                          FocusScope.of(context).unfocus();
                          search(text);
                        },
                        onSuggestionTap: (listItem) {
                          FocusScope.of(context).unfocus();
                          search(listItem.item!);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Featured specialist'),
            ),
          ),
          loading
              ? const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                )
              : filtered.isEmpty
                  ? const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: Center(
                          child: Text('No specialist found'),
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, int index) {
                          return SpecialistCard(
                            specialist: filtered[index],
                          );
                        },
                        childCount: filtered.length,
                      ),
                    ),
        ],
      ),
    );
  }

  search(String searchText) {
    if (searchText == '') {
      setState(() {
        filtered = specialists;
      });
      return;
    }
    setState(() {
      loading = true;
    });
    List<Specialist> tmp = [];
    // Filter list with specialist that match the text
    for (var element in specialists) {
      if (element.speciality == searchText) {
        tmp.add(element);
      }
    }
    setState(() {
      filtered = tmp;
      loading = false;
    });
  }
}
