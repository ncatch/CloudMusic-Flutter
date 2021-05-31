/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-02 11:24:30
 * @LastEditTime: 2021-05-31 16:04:15
 * @LastEditors: Walker
 */
const ClientType = {
  "pc": 0,
  "android": 1,
  "iphone": 2,
  "ipad": 3,
};

enum PlayModes {
  order, // 顺序播放
  repeatOne, // 单曲循环
  repeat, // 列表循环
  random, // 随机
}

enum SubscribeDic {
  collect, // 收藏
  cancel, // 取消收藏
}

var SubscribeVal = {
  SubscribeDic.cancel: 2,
  SubscribeDic.collect: 1,
};

// 评论操作类型
class CommentType {
  static int delete = 0; // 删除
  static int send = 1; // 发送
  static int reply = 2; // 回复
}

// 评论资源类型
enum ResourceType {
  music, // 歌曲 0
  mv, // mv 1
  playList, // 歌单 2
  dvd, // 专辑 3
  radio, // 电台 4
  video, // 视频 5
  dynamic, // 动态 6
}

enum CommentSortType {
  recommend, // 推荐
  hot, // 热度
  time, // 时间
}

enum PlayListType {
  recommend, // 每日推荐
  common, // 正常歌单
}
