import 'dart:convert';
import 'dart:io' as io;
import 'package:test/test.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:collection/collection.dart';
import 'dart:collection';

String? url;
Response? resp;

Function eq = const ListEquality().equals;

Future<void> envSetUp(u) async {
  url = u;
  resp = await Dio().get(u!);
}

Future<List> getTags(name) async{
  io.File file = io.File.fromUri(Uri.file("C:/Users/79509/dart/champion_selection/champion.json", windows: true));
  var response = jsonDecode(await file.readAsString());
  return response['data'][name]['tags'];
}

void main() {
  group('get tierlist by role/elo', () {
    test('tierlist parsing', () async{
      List<String> playerData = ['Platinum', 'Top'];
      String elo = playerData[0].toLowerCase();
      String role = playerData[1].toLowerCase();
      await envSetUp('https://www.leagueofgraphs.com/champions/builds/$role/$elo');
      BeautifulSoup sp = BeautifulSoup(resp!.data);
      var tierList = sp.find('div', class_: 'medium-24 columns')?.findAll("span", class_: 'name');
      Map tagTierList = {};
      for(var champ in tierList!) {
        String name = champ.getText().replaceAll(' ', '').replaceAll('\n', '').replaceAll('.', '').replaceAll("'", '');
        tagTierList[name] = await getTags(name);
      }
      List recommendedChampions = [];
      tagTierList.forEach((k,v) {
        if (eq(v, ['Fighter', 'Assassin']) || eq(v, ['Assassin', 'Fighter']) || eq(v, ['Fighter'])){
          recommendedChampions.add(k);
        }
      });
      print(recommendedChampions);
    });
    test('define main class of champions from champion pull', () async {
      List pull = ['Fiora', 'Irelia', 'Olaf', 'Mordekaiser'];
      Map tags = {'Assassin': 0, 'Fighter': 0, 'Mage': 0, 'Marksman': 0, 'Support': 0, 'Tank': 0};
      for (String champion in pull){
        List tagsOfPullChamp = await getTags(champion);
        for (String tag in tagsOfPullChamp) {
          tags[tag] ++;
        }
      }
      var sortedKeys = tags.keys.toList(growable:false)
        ..sort((k2, k1) => tags[k1].compareTo(tags[k2]));
      LinkedHashMap sortedMap = LinkedHashMap
        .fromIterable(sortedKeys, key: (k) => k, value: (k) => tags[k]);
      print([sortedMap.keys.elementAt(0), sortedMap.keys.elementAt(1)]);
    });
  });

  group("get champion tags", () {
    test('get data', () async {
      var response = 
          await Dio().get('https://ddragon.leagueoflegends.com/cdn/12.13.1/data/en_US/champion.json');
      Logger().d(response.data);
    });
    test('get champion tags by name', () async {
      String name = 'Olaf';
      var response = 
          await Dio().get('https://ddragon.leagueoflegends.com/cdn/12.13.1/data/en_US/champion.json');
      List tags = response.data['data'][name]['tags'];
      Logger().d(tags[0]);
    });
  });
  group('champion info parser', () {
    test('get winrate/banrate/pickrate', () async{
      await envSetUp('https://www.leagueofgraphs.com/champions/builds/darius/top/platinum');
      BeautifulSoup sp = BeautifulSoup(resp!.data);
      var statistics = sp.find("div", id: 'graphDD1')?.getText().replaceAll('\n', '').replaceAll(' ', '');
      Logger().d(statistics);
    });
  });
}

