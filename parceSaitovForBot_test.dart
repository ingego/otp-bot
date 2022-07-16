import 'dart:io';

import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:test/test.dart';

void main() {
  String? url;
  Response? resp;
  

  group("parser", (){
    setUp(() async {
      url = r"https://www.leagueofgraphs.com/summoner/ru/TiPidorina";
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
        test("favChamps", (){
          BeautifulSoup sp = BeautifulSoup(resp!.data);
          var favChamps = sp.find("div", id: "favchamps")?.find("div", class_: "tabs-content")
          ?.find("div", class_: "content active")?.findAll("div", class_: "name");
          for (var value in favChamps!){
            Logger().d((value).getText());

          }

        });
      });
 });


}