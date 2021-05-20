/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-20 19:40:35
 * @LastEditTime: 2021-05-20 19:47:43
 * @LastEditors: Walker
 */
extension DateTimeExtends on DateTime {
  String format([String fmt = 'YYYY-MM-DD HH:mm:ss']) {
    var result = fmt;

    result = result.replaceFirst('YYYY', this.year.toString())
      ..replaceFirst('yyyy', this.year.toString())
      ..replaceFirst('MM', this.month.toString())
      ..replaceFirst('DD', this.day.toString())
      ..replaceFirst('dd', this.day.toString())
      ..replaceFirst('HH', this.hour.toString())
      ..replaceFirst('hh', this.hour.toString())
      ..replaceFirst('mm', this.minute.toString())
      ..replaceFirst('ss', this.second.toString());
    return result;
  }
}
