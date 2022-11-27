class Character{
 late int charId;
 late String name;
 late String nickName;
 late String image;
 late String status;
 late String actorName;
 late String category;
 late List<dynamic> jobs;
 late List<dynamic> appearanceOfSeasons;
 late List<dynamic> betterCallSaulAppearance;

  Character.fromJson(Map<String, dynamic> json)
  {
    charId = json['char_id'];
    name = json['name'];
    nickName = json['nickname'];
    image = json['img'];
    status = json['status'];
    actorName = json['portrayed'];
    category = json['category'];
    jobs = json['occupation'];
    appearanceOfSeasons = json['appearance'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
  }
}