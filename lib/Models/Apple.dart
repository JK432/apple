class Apple {
  String id;
  String Temperature;
  String Humidity;
  List<String>photolink;
  Apple(
      {this.id = "",
        this.Temperature="",
        this.Humidity="",
        this.photolink=const []
      });

  Map<String, dynamic> toJson() => {
    'id': id,
    'Temperature': Temperature,
    'Humidity': Humidity,
    'photolink':photolink
  };

  static Apple fromJson(Map<String, dynamic> Json) => Apple(
    id: Json['id'],
    Temperature:Json['Temperature'],
    Humidity:Json['Humidity'],
    photolink:  dyntostr(Json['photolink']),
  );

  static List<String> dyntostr(List<dynamic> dynamiclist){
    List<String> stringlist = [];
    dynamiclist.forEach((element) {stringlist.add(element.toString());});
    return stringlist;
  }
}