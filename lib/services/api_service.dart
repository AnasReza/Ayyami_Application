import 'package:http/http.dart' as http;
class ApiServices
{

  Future<http.Response> callGetApi(String url,{Map<String,String>? header})async{
    http.Response response = await http.get(Uri.parse(url),headers: header);
    return response;
  }

  Future<http.Response> callPostApi(String url,Map<String,dynamic> body,{Map<String,String>? header})async{
    http.Response response = await http.post(Uri.parse(url),body: body,headers: header);
    return response;
  }

}