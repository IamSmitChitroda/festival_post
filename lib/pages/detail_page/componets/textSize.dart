import 'package:festival_post/headers.dart';

Widget quoteTextSize({required Function onChanged}) {
  return Center(
    child: Slider(
      min: 10,
      max: 50,
      value: Globals.instance.size,
      onChanged: onChanged(),
    ),
  );
}
