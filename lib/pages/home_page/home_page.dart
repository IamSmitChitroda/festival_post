import 'package:festival_post/headers.dart';
import 'package:google_fonts/google_fonts.dart';

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
        backgroundColor: Colors.blue.shade300,
        centerTitle: true,
        title: Text(
          "Festivals",
          style: GoogleFonts.aladin(textStyle: TextStyle(fontSize: 40)),
        ),
      ),
      body: Column(
        children: [
          // SearchBar
          const Padding(
            padding: EdgeInsets.all(16),
            child: SearchBar(
              hintText: "Search here",
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
                physics: const BouncingScrollPhysics(),
                children: festivalData.festivals
                    .map(
                      (e) => Card(
                        color: Colors
                            .primaries[(festivalData.festivals.indexOf(e)) +
                                ((festivalData.festivals.indexOf(e)))]
                            .shade100,
                        child: ListTile(
                            trailing: const Icon(Icons.arrow_forward_ios_sharp),
                            onTap: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.instance.detailPage,
                                  arguments: e,
                                ),
                            title: Text(
                              e.name,
                              style: const TextStyle(
                                fontSize: 18.3,
                              ),
                            )),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
