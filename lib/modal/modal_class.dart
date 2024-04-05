class Festival {
  String name;
  String description;
  String image;
  List<String> quotes;
  List<String> frame;

  Festival({
    required this.name,
    required this.description,
    required this.image,
    required this.quotes,
    required this.frame,
  });

  factory Festival.fromMap(Map<String, dynamic> data) {
    return Festival(
      name: data['name'],
      description: data['description'],
      image: data['image'],
      quotes: List<String>.from(data['quotes']),
      frame: List<String>.from(data['frame']),
    );
  }
}

class FestivalData {
  List<Festival> festivals;

  FestivalData({required this.festivals});

  factory FestivalData.fromMap(Map<String, dynamic> data) {
    List<Festival> festivals = (data['festivals'] as List)
        .map((fest) => Festival.fromMap(fest))
        .toList();

    return FestivalData(festivals: festivals);
  }
}
