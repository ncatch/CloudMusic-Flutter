/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-12 15:42:36
 * @LastEditTime: 2021-05-20 15:47:05
 * @LastEditors: Walker
 */

extension IntExtend on int {
  String toMyriadString([fixed = 0]) {
    if (this > 10000) {
      return (this / 10000).toStringAsFixed(fixed) + '万';
    }
    return this.toString();
  }
}
