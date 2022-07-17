import 'dart:io';

import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:test/test.dart';

void main() {
  String? url;
  Response? resp;
  

  group("parserOfSummonerData", (){
    setUp(() async {
      url = r"https://www.leagueofgraphs.com/summoner/ru/CopyBara";
      resp = await Dio().get(url!);
      });

      group("Unit Test", (){

        test('setUp', (){
          expect(url, url!);
          expect(resp, resp!);
        });

        test("Parse leagueTier", (){
          BeautifulSoup sp = BeautifulSoup(resp!.data);
          var tierSQ = sp.find("div", class_: "leagueTier")?.getText();
                Logger().w(tierSQ);
              });
        test("Parse positionInGame", (){
          BeautifulSoup sp = BeautifulSoup(resp!.data);
          var linePosition = sp.find("div", id: "profileRoles")?.
          find("div", class_: "tabs-content")?.find("div", class_:"content active")?.find("div", class_: "txt name")?.getText();
            Logger().w(linePosition);
        });
      });
 });
  group("favChampsFromOPGG", (){
    setUp(() async {
      url = r"https://ru.op.gg/summoners/ru/CopyBara";
      resp = await Dio().get(url!);
      });
      group("Unit Test", (){

         test('setUp', (){
          expect(url, url!);
          expect(resp, resp!);
        });

         test("Parse favChamps", (){
          BeautifulSoup sp = BeautifulSoup(resp!.data);
          var champList = sp.find("div", class_: "css-e9xk5o e1g7spwk3")?.findAll("div", class_: "name");
              for (var value in champList!){
                Logger().w((value).getText());
                }
                
              });

      });

  });

}