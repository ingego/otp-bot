import 'dart:io';

import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:prostoproekti_testing_tests/parsers.dart';
import 'package:prostoproekti_testing_tests/scripting.dart';
import 'package:test/test.dart';


void main() {
String? url;
Response? resp;
ParserOfSummonerData summoner = ParserOfSummonerData();
FavChampsFromOPGG champs = FavChampsFromOPGG();

  group("parserOfSummonerData", (){
    setUp(() async {await summoner.envSetUp();
      });

      group("Unit Test", (){

        test('setUp', (){
          expect(summoner.url, summoner.url!);
          expect(summoner.resp, summoner.resp!);
        });

        test("Parse leagueTier", (){
          var tierSQ = summoner.leagueTier();
                Logger().w(tierSQ);
              });
        test("Parse positionInGame", (){
          var linePosition = summoner.positionInGame();
            Logger().w(linePosition);
        });
      });
 });
  group("favChampsFromOPGG", (){
    setUp(() async {await champs.envSetUp();
      });
      group("Unit Test", (){

         test('setUp', (){
          expect(champs.url, champs.url!);
          expect(champs.resp, champs.resp!);
        });

         test("Parse favChamps", (){
          var champList = champs.favChamps();
              for (var value in champList!){
                Logger().w((value));
                }
                
              });

      });

  });

}