/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-27 19:24:35
 * @LastEditTime: 2021-05-28 16:26:54
 * @LastEditors: Walker
 */
class Level {
  String info = "";
  int level = 0;
  int nextLoginCount = 0;
  int nextPlayCount = 0;
  int nowLoginCount = 0;
  int nowPlayCount = 0;
  double progress = 0;
  int userId = 0;

  Level() {}

  Level.fromJson(Map<String, dynamic> jsonstr) {
    this.info = jsonstr["info"];
    this.level = jsonstr["level"];
    this.nextLoginCount = jsonstr["nextLoginCount"];
    this.nextPlayCount = jsonstr["nextPlayCount"];
    this.nowLoginCount = jsonstr["nowLoginCount"];
    this.nowPlayCount = jsonstr["nowPlayCount"];
    this.progress = jsonstr["progress"];
    this.userId = jsonstr["userId"];
  }
}
