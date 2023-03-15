import 'package:flutter/material.dart';
import 'package:medeasy/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                onPressed: () {},
                icon: const Icon(Icons.account_circle_rounded, color: Colors.black, size: 36),
              ),
            ],
            // centerTitle: true,
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
                  children: [
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.location_on_rounded),
                    ),
                    SizedBox(
                      width: screen.width * .7,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return const SpecialistCard();
              },
              childCount: 20,
            ),
          )
        ],
      ),
    );
  }
}
