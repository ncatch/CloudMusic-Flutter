/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-04-02 11:24:30
 * @LastEditTime: 2021-05-14 15:23:47
 * @LastEditors: Walker
 */
const clientType = {
  "pc": 0,
  "android": 1,
  "iphone": 2,
  "ipad": 3,
};

enum playModes {
  order, // 顺序播放
  repeatOne, // 单曲循环
  repeat, // 列表循环
  random, // 随机
}

enum subscribeDic {
  collect, // 收藏
  cancel, // 取消收藏
}

var subscribeVal = {
  subscribeDic.cancel: 2,
  subscribeDic.collect: 1,
};
