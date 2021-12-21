class ImageAndExplanation {
  late String assetLink;
  late String explanation;
  late String title;
  ImageAndExplanation(
      {required this.explanation,
      required this.title,
      required this.assetLink});

  List<ImageAndExplanation> getImageList() {
    return [
      ImageAndExplanation(
          explanation:
              "Antiemetics work by inhibiting the transmitters involved in the process of nausea and vomiting. The most commonly given antiemetics in the UK are Dexamethasone (unknown mechanism), Ondansetron(5HT3 inhibitor.",
          title: 'Anti-emetics',
          assetLink: 'Antiemetics.jpg')
    ];
  }
}
