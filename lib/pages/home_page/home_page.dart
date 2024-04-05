import 'package:festival_post/headers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Festivals"),
      ),
      // ==============================================================
      body: Column(
        children: [
          // SearchBar
          const Padding(
            padding: EdgeInsets.all(16),
            child: SearchBar(
              leading: Icon(Icons.search),
            ),
          ),
          // SizeBox--------------------------------------
          const SizedBox(
            height: 10,
          ),
          // CarouselSlider-----------------------------------
          CarouselSlider(
            items: festivalData.festivals.map((element) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, AppRoutes.instance.detailPage,
                        arguments: element),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(element.image),
                              fit: BoxFit.cover),
                          color: Colors.amber,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(4, 4),
                              spreadRadius: 4,
                              blurRadius: 10,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 3),
            ),
          ),
          // AllFestival-----------------------------------------
          const Text(
            "All Festival",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  ...festivalData.festivals
                      .map(
                        (e) => Card(
                          color: Colors
                              .primaries[festivalData.festivals.indexOf(e)]
                              .shade100,
                          shadowColor: Colors
                              .primaries[festivalData.festivals.indexOf(e)],
                          child: ListTile(
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_sharp),
                              onTap: () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.instance.detailPage,
                                    arguments: e,
                                  ),
                              title: Text(e.name)),
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
