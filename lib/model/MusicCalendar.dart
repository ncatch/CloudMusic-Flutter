/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-06-02 14:14:56
 * @LastEditTime: 2021-06-02 14:32:13
 * @LastEditors: Walker
 */

class MusicCalendarModel {
  String title = "";
  String btnText = "";
  List<MusicCalendarItem> items = [];

  MusicCalendarModel.fromJson(Map<String, dynamic> jsonstr) {
    this.btnText = jsonstr["uiElement"]["button"]["text"];
    this.title = jsonstr["uiElement"]["subTitle"]["title"];

    this.items = List<MusicCalendarItem>.from(jsonstr["creatives"]
        .map<MusicCalendarItem>((ele) => MusicCalendarItem.fromJson(ele)));
  }
}

class MusicCalendarItem {
  List<String> labels = [];
  String content = "";
  String imgUrl = "";
  String resourceId = "";
  String resourceType = ""; // WEBVIEW ALBUM

  MusicCalendarItem.fromJson(Map<String, dynamic> jsonstr) {
    this.content = jsonstr["resources"][0]["uiElement"]["mainTitle"]["title"];
    this.labels = (jsonstr["resources"][0]["uiElement"]["labelTexts"] ?? [])
        .map<String>((ele) => ele.toString())
        .toList();
    this.imgUrl = jsonstr["resources"][0]["uiElement"]["image"]["imageUrl"];

    this.resourceId = jsonstr["resources"][0]["resourceId"];
    this.resourceType = jsonstr["resources"][0]["resourceType"];
  }
}
