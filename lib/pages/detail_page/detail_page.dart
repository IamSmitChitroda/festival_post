import 'dart:ui' as ui;
import 'package:festival_post/headers.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

String? selectedImage;

class _DetailPageState extends State<DetailPage> {
  int i = 0;
  String quote = "";
  GlobalKey widgetKey = GlobalKey();
  GlobalKey colour = GlobalKey();

  Future<File> getFileFromWidget() async {
    RenderRepaintBoundary boundary =
        widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(
      pixelRatio: 15,
    );
    ByteData? data = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    Uint8List list = data!.buffer.asUint8List();

    Directory directory = await getTemporaryDirectory();
    File file = await File(
            "${directory.path}/QA${DateTime.now().millisecondsSinceEpoch}.png")
        .create();
    file.writeAsBytesSync(list);

    return file;
  }

  @override
  void initState() {
    Globals.instance.reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    Festival data = ModalRoute.of(context)!.settings.arguments as Festival;

    return EyeDrop(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade300,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: Text(
            data.name,
            style: GoogleFonts.aladin(textStyle: const TextStyle(fontSize: 30)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Image
              Expanded(
                child: RepaintBoundary(
                  key: widgetKey,
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                      image: DecorationImage(
                        image: AssetImage(
                          (selectedImage != null)
                              ? selectedImage!
                              : data.frame[0],
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            String text = "";

                            return AlertDialog(
                              title: const Text("Edit Quote"),
                              content: TextFormField(
                                initialValue: quote,
                                maxLines: 3,
                                onChanged: (val) => text = val,
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    quote = text;
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Save"),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                              ],
                            );
                          },
                        ).then((value) => setState(() {}));
                      },
                      onPanUpdate: (DragUpdateDetails dragUpdateDetails) =>
                          setState(() => Globals.instance.offSet +=
                              dragUpdateDetails.delta),
                      child: Transform.translate(
                        offset: Globals.instance.offSet,
                        child: Center(
                          child: Text(
                            quote,
                            textAlign: Globals.instance.quoteTextAlignment,
                            style: TextStyle(
                              fontSize: Globals.instance.size,
                              color: Globals.instance.quoteTextColor,
                              letterSpacing:
                                  Globals.instance.quotelettringSpacing,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // OptionsSlide
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    TextButton.icon(
                      onPressed: () =>
                          setState(() => Globals.instance.index = 0),
                      label: const Text(
                        "Frame",
                        style: TextStyle(color: Colors.black54),
                      ),
                      icon: const Icon(
                        Icons.filter_frames_outlined,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    TextButton.icon(
                      onPressed: () =>
                          setState(() => Globals.instance.index = 1),
                      label: const Text(
                        "Quote",
                        style: TextStyle(color: Colors.black54),
                      ),
                      icon: const Icon(
                        Icons.format_quote,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    TextButton.icon(
                      onPressed: () =>
                          setState(() => Globals.instance.index = 2),
                      label: const Text(
                        "Text",
                        style: TextStyle(color: Colors.black54),
                      ),
                      icon: const Icon(
                        Icons.text_increase,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    TextButton.icon(
                      onPressed: () =>
                          setState(() => Globals.instance.index = 3),
                      label: const Text(
                        "Colour",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      icon: const Icon(
                        Icons.color_lens_outlined,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Expanded(
                child: IndexedStack(
                  index: Globals.instance.index,
                  children: [
                    // Frame
                    SingleChildScrollView(
                      child: Row(
                        children: data.frame
                            .map(
                              (e) => GestureDetector(
                                onTap: () {
                                  selectedImage = e;

                                  i = data.frame.indexOf(e);
                                  setState(() {});
                                },
                                child: Container(
                                  height: size.height * 0.15,
                                  width: size.width * 0.25,
                                  margin: EdgeInsets.all(
                                      (i == data.frame.indexOf(e)) ? 20 : 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(3, 3),
                                        blurRadius: 10,
                                        color: Colors.grey,
                                      )
                                    ],
                                    border: Border.all(
                                      color: (i == data.frame.indexOf(e))
                                          ? Colors.transparent
                                          : Colors.transparent,
                                      width:
                                          (i == data.frame.indexOf(e)) ? 10 : 2,
                                    ),
                                    color: Colors.grey.shade200,
                                    image: DecorationImage(
                                      image: AssetImage(e),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    // Quote
                    ListWheelScrollView(
                        itemExtent: 55,
                        clipBehavior: Clip.antiAlias,
                        diameterRatio: 1,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          ...data.quotes
                              .map(
                                (e) => TextButton(
                                  onPressed: () {
                                    quote = e;
                                    setState(() {});
                                  },
                                  child: Text(
                                    e,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              )
                              .toList(),
                        ]),
                    // TextProperty
                    ListView(
                      children: [
                        // FontSize
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                Globals.instance.size += 3;
                                setState(() {});
                              },
                              icon: const Icon(CupertinoIcons.plus_app),
                            ),
                            const Text(
                              "Font Size: ",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Globals.instance.size -= 3;
                                setState(() {});
                              },
                              icon: const Icon(CupertinoIcons.minus_rectangle),
                            ),
                          ],
                        ),
                        // FontAlignment
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                Globals.instance.quoteTextAlignment =
                                    TextAlign.left;
                                setState(() {});
                              },
                              icon: const Icon(Icons.format_align_left),
                            ),
                            IconButton(
                              onPressed: () {
                                Globals.instance.quoteTextAlignment =
                                    TextAlign.center;
                                setState(() {});
                              },
                              icon: const Icon(Icons.format_align_center),
                            ),
                            IconButton(
                              onPressed: () {
                                Globals.instance.quoteTextAlignment =
                                    TextAlign.right;
                                setState(() {});
                              },
                              icon: const Icon(Icons.format_align_right),
                            ),
                          ],
                        ),
                        // FontLetterSpacing
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                Globals.instance.quotelettringSpacing += 1;
                                setState(() {});
                              },
                              icon: const Icon(CupertinoIcons.plus_app),
                            ),
                            const Text(
                              "Letter Spacing",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Globals.instance.quotelettringSpacing -= 1;
                                setState(() {});
                              },
                              icon: const Icon(CupertinoIcons.minus_rectangle),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Colour_Picker
                    Column(
                      children: [
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 5,
                            children: Globals.instance.allColors
                                .map(
                                  (e) => e == Colors.transparent
                                      ?
                                      // Colour_Picker
                                      Container(
                                          alignment: Alignment.center,
                                          child: ColorButton(
                                            key: colour,
                                            config: const ColorPickerConfig(
                                                enableEyePicker: true),
                                            size: 32,
                                            color:
                                                Globals.instance.quoteTextColor,
                                            onColorChanged: (value) => setState(
                                              () {
                                                Globals.instance
                                                    .quoteTextColor = value;
                                              },
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            Globals.instance.quoteTextColor = e;
                                            setState(() {});
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: e,
                                              boxShadow: const [
                                                BoxShadow(
                                                  offset: Offset(3, 3),
                                                  color: Colors.grey,
                                                  blurRadius: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blue.shade300,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Options"),
                  content: const Text("Select any one option."),
                  actions: [
                    // Share
                    ElevatedButton.icon(
                      onPressed: () async {
                        ShareExtend.share(
                          (await getFileFromWidget()).path,
                          "image",
                        );
                      },
                      icon: const Icon(Icons.share),
                      label: const Text("Share"),
                    ),
                    // Save
                    ElevatedButton.icon(
                      onPressed: () async {
                        ImageGallerySaver.saveFile(
                                (await getFileFromWidget()).path,
                                isReturnPathOfIOS: true)
                            .then(
                          (value) {
                            Navigator.pop(context);
                            return ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Saved on Gallery !!"),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.save),
                      label: const Text("Save"),
                    ),
                  ],
                );
              },
            );
          },
          label: const Text("Share"),
          icon: const Icon(Icons.edit),
        ),
      ),
    );
  }
}
