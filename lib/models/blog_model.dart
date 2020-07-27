
class BlogModel{
  String id;
  String name;
  String description;
  String date;
  String image;
  String link;

  BlogModel({
    this.id,
    this.name,
    this.description,
    this.date,
    this.image,
    this.link
});

  factory BlogModel.fromJson(Map<String, dynamic> item){
    return BlogModel(
      id: item['id'],
      name: item['name'],
      description: item['description'],
      date: item['date'],
      image: item['image'],
      link: item['link'],
    );
  }

}