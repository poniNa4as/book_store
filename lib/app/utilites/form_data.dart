class FormData {
  String title;
  String autor;
  int price;
  int year;
  String image;
  double rate;
  int pages;

  FormData({
    this.title = '',
    this.autor = '',
    this.price = 0,
    this.year = 0,
    this.image = '',
    this.rate = 0,
    this.pages = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'autor': autor,
      'price': price,
      'year': year,
      'image': image,
      'rate': rate,
      'pages': pages
    };
  }
}
