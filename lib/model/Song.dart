/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-07 15:40:01
 * @LastEditTime: 2021-05-08 11:42:37
 * @LastEditors: Walker
 */
class SongListModel {
  String title = "";
  String btnText = "";
  List<SongModel> songList = [];

  SongListModel() {}

  SongListModel.fromJson(Map<String, dynamic> jsonstr) {
    this.btnText = jsonstr["uiElement"]["button"]["text"];
    this.title = jsonstr["uiElement"]["subTitle"]["title"];
    this.songList = List<SongModel>.from(jsonstr['creatives']
        .map((ele) => SongModel.fromJson(ele['resources'][0])));
  }
}

class SongModel {
  String imageUrl = "";
  int id = 0;
  String name = "";
  int playCount = 0;

  SongModel(String imageUrl, int id, String name, int playCount) {
    this.imageUrl = imageUrl;
    this.id = id;
    this.name = name;
    this.playCount = playCount;
  }

  SongModel.fromJson(Map<String, dynamic> jsonstr) {
    this.id = int.parse(jsonstr["resourceId"]);
    this.imageUrl = jsonstr["uiElement"]["image"]["imageUrl"];
    this.name = jsonstr["uiElement"]["mainTitle"]["title"];
    this.playCount = jsonstr["resourceExtInfo"]["playCount"];
  }
}
