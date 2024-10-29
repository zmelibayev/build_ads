import 'package:build_ads/add_screen.dart';
import 'package:build_ads/detail_screen.dart';
import 'package:build_ads/provider_fb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      body: Consumer<AdsProvider>(
        builder: (context, provider, _) {
          return FutureBuilder(
            future: provider.getDataPrv(),
            builder: (context, snapshot) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: const Text(
                      'БРУСОВЕЦ',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    actions: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(width: 2.0, color: Colors.amber),
                        ),
                        child: const Text('Заказать звонок'),
                      ),
                    ],
                    backgroundColor: Colors.white,
                    elevation: 0,
                    floating: false,
                    pinned: true,
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      // title: const Text('Home Page'),

                      background: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Image.asset(
                              'assets/builder.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.amber.withOpacity(0.4)),
                          Positioned(
                            top: 90,
                            left: 20,
                            child: Row(
                              children: [
                                const Text(
                                  '+ 998 (90) 511-22-44',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.telegram_outlined,
                                    size: 25,
                                    color: Color.fromARGB(255, 4, 72, 117),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // SliverGrid --------- GridView.builder
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  2, // Number of columns in the grid
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                              childAspectRatio: 1.0,
                              mainAxisExtent: 300),
                      delegate: SliverChildBuilderDelegate(
                        childCount: provider.adsList.length,
                        (BuildContext context, int index) {
                          final item = provider.adsList[index];
                          if (provider.adsList.isNotEmpty) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(details: item),
                                ));
                              },
                              child: Container(
                                // color: Colors.green[100 * (index % provider.adsList.length)],
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(
                                        -1.0,
                                        1.0,
                                      ),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ),
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(
                                        5.0,
                                        3.0,
                                      ),
                                      blurRadius: 10.0,
                                      spreadRadius: 0.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                      ),
                                      child: Image.network(
                                        height: 150,
                                        width: double.infinity,
                                        item.adsImgUrl.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: FittedBox(
                                        child: Column(
                                          children: [
                                            Text(
                                              item.adsName.toUpperCase(),
                                              maxLines: 20,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                                '${item.housePlace}  |  ${item.homeScale}',
                                                style: const TextStyle(
                                                    letterSpacing: 2,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.architecture_rounded,
                                                  size: 25,
                                                ),
                                                Text(
                                                  item.adsPrice,
                                                  style: const TextStyle(
                                                      letterSpacing: 3,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            const Center(
                              child: Text('Ads not'),
                            );
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddScreen(),
          ));
        },
        child: const Icon(Icons.import_contacts),
      ),
    );
  }
}
