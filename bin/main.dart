import 'dart:async';

import 'package:dart_asynchronous/api_key.dart';
import 'package:http/http.dart';
import 'dart:convert';

StreamController<String> streamController = StreamController<String>();
void main() {
  StreamSubscription streamSubscription = streamController.stream.listen((
    String info,
  ) {
    print(info);
  });

  requestData();
  requestDataAsync();
  sendDataAsync({
    "id": "NEW001",
    "name": "Flutter",
    "lastName": "Dart",
    "balance": 5000,
  });
}

void requestData() {
  String url =
      "https://gist.githubusercontent.com/ragielly/2e6a49b0e6403d1188084e027ec1c975/raw/a48ea2fd9d16bd55b9bfd9268b208e227a43f8c6/accounts.json";
  Future<Response> futureResponse = get(Uri.parse(url));

  futureResponse.then((Response response) {
    streamController.add(
      " ${DateTime.now()} | Requisição Leitura (usando then) ",
    );
  });
}

Future<List<dynamic>> requestDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/ragielly/2e6a49b0e6403d1188084e027ec1c975/raw/a48ea2fd9d16bd55b9bfd9268b208e227a43f8c6/accounts.json";
  Response response = await get(Uri.parse(url));
  streamController.add("${DateTime.now()} | Requisição Leitura }");
  return json.decode(response.body);
}

void sendDataAsync(Map<String, dynamic> mapAccount) async {
  List<dynamic> listAccounts = await requestDataAsync();
  listAccounts.add(mapAccount);
  String content = json.encode(listAccounts);

  String url = "https://api.github.com/gists/2e6a49b0e6403d1188084e027ec1c975";
  Response response = await post(
    Uri.parse(url),
    headers: {"Authorization": "Bearer $gitHubApiKey"},
    body: json.encode({
      "description": "accounts.json",
      "public": true,
      "files": {
        "accounts.json": {"content": content},
      },
    }),
  );
  if(response.statusCode.toString()[0] == "2" ){
    streamController.add("${DateTime.now()} | Requisição adição bem sucedida ${mapAccount["name"]} .");
  }else{
    streamController.add("${DateTime.now()} | Requisição adição falhou .");
  }
}
