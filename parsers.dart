


import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:dio/dio.dart';

class ParserOfSummonerData{

String? url;
Response? resp;

Future <void> envSetUp()async{url = r"https://www.leagueofgraphs.com/summoner/ru/huetao";
      resp = await Dio().get(url!);}
String? leagueTier(){

BeautifulSoup sp = BeautifulSoup(resp!.data);
          var tierSQ = sp.find("div", class_: "leagueTier")?.getText();
                return(tierSQ);

}

String? positionInGame(){

BeautifulSoup sp = BeautifulSoup(resp!.data);
          var linePosition = sp.find("div", id: "profileRoles")?.
          find("div", class_: "tabs-content")?.find("div", class_:"content active")?.find("div", class_: "txt name")?.getText();
            return(linePosition);

}
}

class FavChampsFromOPGG{

String? url;
Response? resp;

Future <void> envSetUp()async{url = r"https://ru.op.gg/summoners/ru/huetao";
      resp = await Dio().get(url!);}
List <String?> favChamps(){
List <String?> champs = [];
BeautifulSoup sp = BeautifulSoup(resp!.data);
          var champList = sp.find("div", class_: "css-e9xk5o e1g7spwk3")?.findAll("div", class_: "name");
              for (var value in champList!){
                champs.add((value).getText());
                }
 return champs;
}
}