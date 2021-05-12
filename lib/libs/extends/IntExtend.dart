/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-12 15:42:36
 * @LastEditTime: 2021-05-12 15:44:34
 * @LastEditors: Walker
 */

extension IntExtend on int {
  String toMyriadString() {
    if (this > 10000) {
      return (this / 10000).round().toString() + '万';
    }
    return this.toString();
  }
}
