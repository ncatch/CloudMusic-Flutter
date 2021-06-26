/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-12 13:46:51
 * @LastEditTime: 2021-05-12 13:49:44
 * @LastEditors: Walker
 */

extension StringExtend on String {
  String overFlowString(int length) {
    if (this.length <= length) return this;

    return this.substring(0, length) + '...';
  }
}
