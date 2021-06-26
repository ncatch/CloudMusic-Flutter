/*
 * @Description: 
 * @Author: Walker
 * @Date: 2021-05-27 15:14:28
 * @LastEditTime: 2021-05-27 15:19:32
 * @LastEditors: Walker
 */
import 'UserInfo.dart';

class HugInfo {
  int hugTotalCounts = 0;
  bool hasMore = false;
  List<HugComment> hugComments = [];

  HugInfo() {}

  HugInfo.fromJson(Map<String, dynamic> data) {
    this.hugTotalCounts = data['hugTotalCounts'];
    this.hasMore = data['hasMore'];

    this.hugComments = List<HugComment>.from(
        data['hugComments'].map<HugComment>((ele) => HugComment.fromJson(ele)));
  }
}

class HugComment {
  String hugContent = "";
  UserInfo user = UserInfo();

  HugComment.fromJson(Map<String, dynamic> data) {
    this.hugContent = data['hugContent'];

    this.user = UserInfo.fromJson(data['user']);
  }
}
