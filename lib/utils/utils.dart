class Utils{
  static Map<String, int> timeConverter(Duration diff){
    var days=diff.inDays;
    var hours=diff.inHours% 24;
    var minutes = diff.inMinutes % 60;
    var seconds=diff.inSeconds % 60;
    return {'days':days,'hours':hours,'minutes':minutes,'seconds':seconds};
  }
}