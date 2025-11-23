
import 'package:http/http.dart';
import 'dart:convert';
void main() {
  // print('ola mundo');
  requestData();
  }

void requestData() {
  String url = "https://gist.githubusercontent.com/ragielly/2e6a49b0e6403d1188084e027ec1c975/raw/1209e5a4a12b8b55697f39d414ad8e43d81ba2cf/gistfile1.txt";
  Future<Response> futureResponse =  get(Uri.parse(url));
  print(futureResponse);
  futureResponse.then((Response response){
    print(response);
    print(response.body);
    List<dynamic> listAccont =  json.decode(response.body);
    Map<String, dynamic> mapCarla = listAccont.firstWhere(
      (element) => element["name"] == "Carla"
      );
      print(mapCarla["balance"]);
  },
  );
}
