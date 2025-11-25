
import 'package:http/http.dart';
import 'dart:convert';
void main() {
  // print('ola mundo');
  // requestData();
  // requestDataAsync();
  sendDataAsync({
    "id": "NEW001",
    "name": "Flutter",
    "lastName": "Dart",
    "balance": 5000,
  });
  }

void requestData() {
  String url = "https://gist.githubusercontent.com/ragielly/2e6a49b0e6403d1188084e027ec1c975/raw/1209e5a4a12b8b55697f39d414ad8e43d81ba2cf/gistfile1.txt";
  Future<Response> futureResponse =  get(Uri.parse(url));
  print(futureResponse);
  futureResponse.then((Response response){
    // print(response);
    // print(response.body);
    List<dynamic> listAccount =  json.decode(response.body);
    Map<String, dynamic> mapCarla = listAccount.firstWhere(
      (element) => element["name"] == "Carla"
      );
      print(mapCarla["balance"]);
  },
  );
}

Future<List<dynamic>> requestDataAsync () async {
  String url = "https://gist.githubusercontent.com/ragielly/2e6a49b0e6403d1188084e027ec1c975/raw/1209e5a4a12b8b55697f39d414ad8e43d81ba2cf/gistfile1.txt";
  Response response = await get(Uri.parse(url));
  return json.decode(response.body);

}
void sendDataAsync(Map<String,dynamic> mapAccount) async {
  List<dynamic> listAccounts = await requestDataAsync();
  listAccounts.add(mapAccount);
  String content = json.encode(listAccounts) ;

  String url = "https://gist.githubusercontent.com/ragielly/2e6a49b0e6403d1188084e027ec1c975/raw/1209e5a4a12b8b55697f39d414ad8e43d81ba2cf/gistfile1.txt";
  Response response = await post(Uri.parse(url), body: content);
  print(response.statusCode);
}

